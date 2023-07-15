local client = client
local awful = require("awful")
local gears = require("gears")

local scratch = {}
local defaultRule = { instance = "scratch" }

-- Turn on this scratch window client (add current tag to window's tags,
-- then set focus to the window)
local function turn_on(c)
	local current_tag = awful.tag.selected(c.screen)
	c:tags(awful.util.table.join({ current_tag }, c:tags()))

	-- Move the scratch window to the focused screen
	c:move_to_screen(awful.screen.focused())

	c:raise()
	client.focus = c

	-- Apply dimensions to the scratchpad window
	scratch.apply_dimensions(c)

	-- Scale and center the scratchpad window on the focused screen
	gears.timer.delayed_call(function()
		awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
	end)
end

-- Turn off this scratch window client (remove current tag from window's tags)
local function turn_off(c)
	local current_tag = awful.tag.selected(c.screen)
	local ctags = {}
	for _, tag in pairs(c:tags()) do
		if tag ~= current_tag then
			table.insert(ctags, tag)
		end
	end
	c:tags(ctags)
end

-- Calculate the dimensions based on the screen size and orientation
function scratch.calculate_dimensions(c)
	local screen = c.screen
	local screen_geometry = screen.geometry
	local width_ratio = 0.7 -- Width ratio relative to the screen
	local height_ratio = 0.75 -- Height ratio relative to the screen

	local width, height

	if screen_geometry.width > screen_geometry.height then
		width = screen_geometry.width * width_ratio
		height = screen_geometry.height * height_ratio
	else
		width = screen_geometry.height * width_ratio
		height = screen_geometry.width * height_ratio
	end

	return width, height
end

-- Apply the calculated dimensions to the scratchpad window
function scratch.apply_dimensions(c)
	local width, height = scratch.calculate_dimensions(c)
	c.width = width
	c.height = height
end

function scratch.raise(cmd, rule)
	local safe_rule = rule or defaultRule

	-- Find the scratch window client
	local focused_screen = awful.screen.focused()
	local start = focused_screen.index
	local matcher = function(c)
		return awful.rules.match(c, safe_rule)
	end

	for c in awful.client.iterate(matcher, start) do
		turn_on(c)
		return
	end

	-- If the client is not found, spawn a new scratch window
	awful.spawn(cmd, {
		rule = safe_rule,
		callback = function(c)
			turn_on(c)
		end,
	})
end

function scratch.toggle(cmd, rule)
	local safe_rule = rule or defaultRule

	-- Find the scratch window client
	local focused_screen = awful.screen.focused()
	local start = focused_screen.index
	local matcher = function(c)
		return awful.rules.match(c, safe_rule)
	end

	for c in awful.client.iterate(matcher, start) do
		if c == client.focus then
			turn_off(c)
		else
			turn_on(c)
		end
		return
	end

	-- If the client is not found, spawn a new scratch window
	awful.spawn(cmd, {
		rule = safe_rule,
		callback = function(c)
			turn_on(c)
		end,
	})
end

return scratch
