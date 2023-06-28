local client = client
local awful = require("awful")
local util = require("awful.util")
local gears = require("gears")

local scratch = {}
local defaultRule = { instance = "scratch" }

-- Turn on this scratch window client (add current tag to window's tags,
-- then set focus to the window)
local function turn_on(c)
	local current_tag = awful.tag.selected(awful.screen.focused())
	local ctags = { current_tag }
	for _, tag in pairs(c:tags()) do
		if tag ~= current_tag then
			table.insert(ctags, tag)
		end
	end
	c:tags(ctags)
	c:move_to_screen(awful.screen.focused())
	c:raise()
	client.focus = c

	-- Center the scratchpad window on the focused screen
	gears.timer.delayed_call(function()
		awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
	end)
end

-- Turn off this scratch window client (remove current tag from window's tags)
local function turn_off(c)
	local current_tag = awful.tag.selected(awful.screen.focused())
	local ctags = {}
	for _, tag in pairs(c:tags()) do
		if tag ~= current_tag then
			table.insert(ctags, tag)
		end
	end
	c:tags(ctags)
end

function scratch.raise(cmd, rule)
	local safe_rule = rule or defaultRule
	local function matcher(c)
		return awful.rules.match(c, safe_rule)
	end

	-- logic mostly copied from awful.client.run_or_raise, except we don't want
	-- to change to or merge with scratchpad tag, just show the window
	local clients = client.get()
	local findex = util.table.hasitem(clients, client.focus) or 1
	local start = util.cycle(#clients, findex + 1)

	for c in awful.client.iterate(matcher, start) do
		turn_on(c)
		return
	end

	-- client not found, spawn it
	util.spawn(cmd)
end

function scratch.toggle(cmd, rule)
	local safe_rule = rule or defaultRule

	if client.focus and awful.rules.match(client.focus, safe_rule) then
		turn_off(client.focus)
	else
		scratch.raise(cmd, safe_rule)
	end
end

return scratch
