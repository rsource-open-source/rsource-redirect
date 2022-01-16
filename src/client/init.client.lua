--# selene: allow(undefined_variable, unused_variable, empty_if)

-- https://roblox.github.io/roact/api-reference/
-- https://github.com/Roblox/roact

--[[

todo:
[x] player charcter does not load
[ ] make background (pattern of rsource logo slowly moving left and up)

[ ] make and await api call

]]

local rsource_colors = {
	white = Color3.fromRGB(199, 213, 224),
	darker = Color3.fromRGB(23, 26, 33),
	bluish = Color3.fromRGB(18, 26, 37),
	bg = Color3.fromRGB(27, 40, 56),
}

setmetatable(rsource_colors, {
	__call = function(self, color)
		return self[color] or Color3.new(0, 0, 0)
	end,
})

local PlayerGui = game:GetService('Players').LocalPlayer.PlayerGui
local Roact = require(game:GetService('ReplicatedStorage'):WaitForChild('Roact'))

local interface = Roact.createElement('ScreenGui', {
	Name = 'Interface',
	IgnoreGuiInset = true,
}, {
	background = Roact.createElement('Frame', {
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = rsource_colors('bg'),
	}, {
		text = Roact.createElement('TextLabel', {
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = rsource_colors('bluish'),
			BorderSizePixel = 2,
			BorderColor3 = rsource_colors('darker'),
			Text = 'Loading...',
			TextColor3 = rsource_colors('white'),
			Size = UDim2.new(0.15, 0, 0.15, 0),
		}),
	}),
})

Roact.mount(interface, PlayerGui)

-- local amIPending = game:GetService('ReplicatedStorage'):WaitForChild('is he?')
-- local sendMeOff = game:GetService('ReplicatedStorage'):WaitForChild('indeed i do')
-- local LetsSee = amIPending:InvokeServer()
-- if LetsSee then
-- 	-- warnUI('You are currently awaiting teleport, do you wish to confirm?') --template or something idk lol
-- 	-- Send to alternate universe
-- 	--[[
-- 		notes:
-- 		add config where u can auto teleport
-- 	]]
-- 	local success, result = sendMeOff:InvokeServer() --This confirms the TP
-- 	if success then
-- 		--Show the TP Worked (If even needed). Result has no use here
-- 	else
-- 		--We screwed up, oh boy (not supposed to happen)
-- 		--Just make the UI mention it failed or something idk
-- 		--The error will be within result, so you should probably show it or do something with it
-- 	end
-- else
-- 	game.Players.LocalPlayer:Kick('You are not pending, please use the bot.')
-- 	--Get outta here
-- end
game:GetService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
