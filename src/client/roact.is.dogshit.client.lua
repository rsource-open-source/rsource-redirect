--[[

local PlayerGui = game:GetService('Players').LocalPlayer.PlayerGui
local Roact = require(game:GetService('ReplicatedStorage'):WaitForChild('Roact'))

function loadingthing(props)
	local text = props.text
	return Roact.createElement('TextLabel', {
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = rsource_colors('bluish'),
		BorderSizePixel = 2,
		BorderColor3 = rsource_colors('darker'),
		Text = text,
		TextColor3 = rsource_colors('white'),
		Size = UDim2.new(0.15, 0, 0.15, 0),
	})
end

local interface = Roact.createElement('ScreenGui', {
	Name = 'Interface',
	IgnoreGuiInset = true,
}, {
	background = Roact.createElement('Frame', {
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = rsource_colors('bg'),
	}, {
		text = Roact.createElement(loadingthing, {
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

]]
