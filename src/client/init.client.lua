--# selene: allow(undefined_variable, unused_variable, empty_if)

local amIPending = game:GetService('ReplicatedStorage'):WaitForChild('is he?')
local sendMeOff = game:GetService('ReplicatedStorage'):WaitForChild('indeed i do')
local LetsSee = amIPending:InvokeServer()
if LetsSee then
	-- warnUI('You are currently awaiting teleport, do you wish to confirm?') --template or something idk lol
	-- Send to alternate universe
	--[[
		notes:
		add config where u can auto teleport
	]]
	local success, result = sendMeOff:InvokeServer() --This confirms the TP
	if success then
		--Show the TP Worked (If even needed). Result has no use here
	else
		--We screwed up, oh boy (not supposed to happen)
		--Just make the UI mention it failed or something idk
		--The error will be within result, so you should probably show it or do something with it
	end
else
	game.Players.LocalPlayer:Kick('You are not pending, please use the bot.')
	--Get outta here
end
-- https://roblox.github.io/roact/api-reference/
