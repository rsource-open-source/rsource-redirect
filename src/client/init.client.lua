--# selene: allow(undefined_variable, unused_variable, empty_if, incorrect_standard_library_use)

--[[
also under it there should be a subtitle a little more grayed out that says what exactly its doing like
"fetching user information for {playerid}... x seconds"
"submitting deletion request for {playerid}... x seconds"
"verifying deletion for {playerid}... x seconds"
(aidan) the above is done via a RemoteEvent that goes server -> client

--^ thoughts
-- todo:

	[x] Create the "Loading" text to have a looping ellipsis
	[ ] Create subtitle with set texts that will show depending on event
	[ ] d
]]

game:GetService('StarterGui'):SetCoreGuiEnabled(Enum.CoreGuiType.All, false) --literdally first line of code and doesnt fail Hi Insyri

local rsource_colors = setmetatable({
	white = Color3.fromRGB(199, 213, 224),
	darker = Color3.fromRGB(23, 26, 33),
	bluish = Color3.fromRGB(18, 26, 37),
	bg = Color3.fromRGB(27, 40, 56),
}, {
	__call = function(self, color)
		return self[color] or Color3.new()
	end,
})

--Main GUIs for the code to work with
local PlayerGui = game.Players.LocalPlayer.PlayerGui

local MainGUI = Instance.new('ScreenGui', PlayerGui)
MainGUI.IgnoreGuiInset = true

local BGFrame = Instance.new('Frame', MainGUI)
BGFrame.BackgroundColor3 = rsource_colors('bg')
BGFrame.BorderColor3 = rsource_colors('bg')
BGFrame.Size = UDim2.fromScale(1, 1)

local MainFrame = Instance.new('Frame', BGFrame)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = rsource_colors('bluish')
MainFrame.Position = UDim2.fromScale(0.5, 0.5)
MainFrame.Size = UDim2.fromScale(0.15, 0.15)
MainFrame.BorderColor3 = rsource_colors('white')

local LoadingText = Instance.new('TextLabel', MainFrame)
LoadingText.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingText.Position = UDim2.fromScale(0.5, 0.5)
LoadingText.Size = UDim2.fromScale(0.5, 0.5)
LoadingText.BackgroundTransparency = 1
LoadingText.Font = Enum.Font.Gotham
LoadingText.Text = 'Loading...'
LoadingText.TextSize = 18
LoadingText.TextColor3 = rsource_colors('white')

local SubText = Instance.new('TextLabel', MainFrame)
SubText.AnchorPoint = Vector2.new(0.5, 0.5)
SubText.BackgroundTransparency = 1
SubText.Size = UDim2.fromScale(1, 0.5)
SubText.Position = UDim2.fromScale(0.5, 1.25)
SubText.Text = 'test'

local FinishedLoading = false

spawn(function() --Loop the ellipsies on Loading
	repeat
		for i = 1, 3 do
			if not FinishedLoading then
				LoadingText.Text = 'Loading' .. string.rep('.', i)
				wait(0.75)
			end
		end
	until FinishedLoading
end)
local notifData = setmetatable({ text = '', time = 0 }, {
	__newindex = function(self, index, value) --Will do the one-time effect on text if transitioning from no text to text
		if index == 'text' then
			if self.index and not value then --If removing text
				--Tween it away (Transparency)
			elseif not self.index and value then --If adding text
				--Tween it in (Transparency)
			end
		end
		rawset(self, index, value)
	end,
})

spawn(function() --Constantly update the SubText to update the "TimeSince"
	while wait(0.1) do
		if notifData.Text then --If active notification
			SubText.Text = notifData.Text .. '{' .. math.floor(tick() - notifData.time) .. ' seconds}' --Bit messy but dw about it its finbe i think
		else
			SubText.Text = ''
		end
	end
end)
game:GetService('ReplicatedStorage'):WaitForChild('Info').OnClientEvent:Connect(function(info)
	notifData.text = info
	notifData.time = tick()
end)

--Guis and all the pre-processing stuff is done, so now we ask the server to check our status
local pendingStatus = game:GetService('ReplicatedStorage'):WaitForChild('is he?'):InvokeServer() -- what is "is he?" representing? like if there was an real input what would it look like?
--"is he?" is just the name for the RemoteFunction where the client asks the server "Hey, check if i have a TP"
--see the server.lua script for reference
if pendingStatus then
	--Expand the gui, specify that we are ok to continue
	-- FinishedLoading = true
	-- LoadingText.Text = 'Finished loading.'
	-- wait(1)
	-- MainFrame:TweenSize(UDim2.fromScale(0.75, 0.75), 'Out', 'Quad', 0.85)
else
	--Maybe like, make it thinner and wider, to support a long string saying "You need to sort your shit mate"
end
