#!/usr/bin/env python3
# Usage:
#   bluetooth.py status <alias>
#   bluetooth.py toggle <alias>
# Outputs exactly one JSON line for 'status' suitable for Waybar custom modules.
# pyright: reportAttributeAccessIssue=false

import sys
import json
import asyncio
from typing import Dict, Any, List, Tuple, Optional
from dbus_next.aio.message_bus import MessageBus
from dbus_next.constants import BusType
from dbus_next.signature import Variant

BLUEZ = "org.bluez"
OBJMGR_IFACE = "org.freedesktop.DBus.ObjectManager"
PROPS_IFACE = "org.freedesktop.DBus.Properties"
ADAPTER_IFACE = "org.bluez.Adapter1"
DEVICE_IFACE = "org.bluez.Device1"


def v(props: Dict[str, Any], key: str, default=None):
    """Safely unwrap a D-Bus Variant (or return default)."""
    val = props.get(key, default)
    return val.value if isinstance(val, Variant) else val


async def get_objects(bus) -> Dict[str, Dict[str, Dict[str, Any]]]:
    obj = bus.get_proxy_object(BLUEZ, "/", await bus.introspect(BLUEZ, "/"))
    mgr = obj.get_interface(OBJMGR_IFACE)
    return await mgr.call_get_managed_objects()


def find_adapter_by_alias(
    objects, alias_want: str
) -> Tuple[Optional[str], Optional[str], Optional[str]]:
    """Return (adapter_path, alias, address) by exact Alias match."""
    want = alias_want.strip()
    for path, ifaces in objects.items():
        a = ifaces.get(ADAPTER_IFACE)
        if not a:
            continue
        alias = str(v(a, "Alias", "")).strip()
        if alias == want:
            addr = str(v(a, "Address", ""))
            return path, alias, addr
    return None, None, None


def connected_devices_on_adapter(objects, adapter_path: str) -> List[Tuple[str, str]]:
    out: List[Tuple[str, str]] = []
    for path, ifaces in objects.items():
        d = ifaces.get(DEVICE_IFACE)
        if not d:
            continue
        if str(v(d, "Adapter", "")) != adapter_path:
            continue
        if bool(v(d, "Connected", False)):
            alias = str(v(d, "Alias", v(d, "Name", "Device")))
            addr = str(v(d, "Address", ""))
            out.append((alias, addr))
    return out


async def status(alias: str) -> None:
    bus = await MessageBus(bus_type=BusType.SYSTEM).connect()
    objects = await get_objects(bus)

    adapter_path, a_alias, a_addr = find_adapter_by_alias(objects, alias)
    if not adapter_path:
        # Helpful list so you can copy the exact alias
        seen = []
        for _, ifs in objects.items():
            ad = ifs.get(ADAPTER_IFACE)
            if ad:
                seen.append(
                    f"- {str(v(ad, 'Alias', '')).strip()}\t{str(v(ad, 'Address', ''))}"
                )
        tip = f'Alias "{alias}" not found.\nAvailable:\n' + (
            "\n".join(seen) if seen else "<none>"
        )
        print(
            json.dumps(
                {"text": " off", "class": "disabled", "tooltip": tip},
                ensure_ascii=False,
            )
        )
        return

    proxy = bus.get_proxy_object(
        BLUEZ, adapter_path, await bus.introspect(BLUEZ, adapter_path)
    )
    props = proxy.get_interface(PROPS_IFACE)

    powered = bool((await props.call_get(ADAPTER_IFACE, "Powered")).value)

    if not powered:
        payload = {
            "text": " off",
            "class": "off",
            "tooltip": f"{a_alias}  {a_addr}\nPowered: no",
        }
        print(json.dumps(payload, ensure_ascii=False))
        return

    devs = connected_devices_on_adapter(objects, adapter_path)
    if not devs:
        payload = {
            "text": " on",
            "class": "on",
            "tooltip": f"{a_alias}  {a_addr}\nPowered: yes",
        }
        print(json.dumps(payload, ensure_ascii=False))
        return

    lines = "\n".join([f"- {d_alias}\t{d_addr}" for d_alias, d_addr in devs])
    payload = {
        "text": f" {len(devs)} connected",
        "class": "connected",
        "tooltip": f"{a_alias}  {a_addr}\nPowered: yes\n\n{lines}",
    }
    print(json.dumps(payload, ensure_ascii=False))


async def toggle(alias: str) -> None:
    bus = await MessageBus(bus_type=BusType.SYSTEM).connect()
    objects = await get_objects(bus)
    adapter_path, _, _ = find_adapter_by_alias(objects, alias)
    if not adapter_path:
        return
    proxy = bus.get_proxy_object(
        BLUEZ, adapter_path, await bus.introspect(BLUEZ, adapter_path)
    )
    props = proxy.get_interface(PROPS_IFACE)
    powered = bool((await props.call_get(ADAPTER_IFACE, "Powered")).value)
    try:
        await props.call_set(ADAPTER_IFACE, "Powered", Variant("b", not powered))
    except Exception:
        # ignore (permissions/policy); Waybar click just won’t flip
        pass


def main():
    if len(sys.argv) < 3 or sys.argv[1] not in ("status", "toggle"):
        print(
            json.dumps({"text": " off", "class": "disabled", "tooltip": "bad usage"})
        )
        return
    cmd, alias = sys.argv[1], " ".join(sys.argv[2:])
    if cmd == "status":
        asyncio.run(status(alias))
    else:
        asyncio.run(toggle(alias))


if __name__ == "__main__":
    main()
