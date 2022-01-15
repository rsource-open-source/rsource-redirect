local http = game:GetService('HttpService')
local url = 'https://api.rsour.cf/v1/'

function getPendingRequests(): table
	local res = http:RequestAsync({
		Url = url .. 'pending',
		Method = 'GET',
		Headers = {
			['Content-Type'] = 'application/json',
			['api-key'] = 'dawg.',
		},
	})
	local data = res.Body
	if data ~= nil then
		local decoded = http:JSONDecode(data)
		return decoded
	else
		return {}
	end
end

function deletePendingID(id) --?
	local res = http:RequestAsync({
		Url = url .. 'pending/' .. id,
		Method = 'DELETE',
		Headers = {
			['Content-Type'] = 'application/json',
			['api-key'] = 'dawg.',
		},
	})
	local data = res.Body
	if data ~= nil then
		local decoded = http:JSONDecode(data)
		return decoded
	else
		return {}
	end
end

game.Players.PlayerAdded:Connect(function(player)
	local pendingList = getPendingRequests()
	local ShouldBeDone = false
	for _, pending in next, pendingList do
		if pending.UserID == player.UserId then
			print('dawg this dude got a pending request')
			local ts = game:GetService('TeleportService')
			local teleportOptions = Instance.new('TeleportOptions')
			teleportOptions.ServerInstanceId = pending.ServerID
			ts:Teleport(pending.PlaceID, { player }, teleportOptions)
			deletePendingID(pending.RequestID)
			ShouldBeDone = true
		end
	end
	if not ShouldBeDone then
		print('dawg this dude got no pending requests')
		player:Kick('It appears as you have no reason to be in this place.')
	end
end)

-- decoded: (the response)
--[[
    decoded = {
        {UserID: number, PlaceID: number, ServerID: uuid, RequestID: uuid},
        {UserID: number, PlaceID: number, ServerID: uuid, RequestID: uuid},
        ...
    }
]]
