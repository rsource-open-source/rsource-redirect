--# selene: allow(undefined_variable, unused_variable)
local http = game:GetService('HttpService')
local url = 'https://api.rsour.cf/v1/'
local apikey: string = require(script:WaitForChild('apikey'))
local TP = game:GetService('TeleportService')

function getPendingRequests(): table
	local res = http:RequestAsync({
		Url = url .. 'pending',
		Method = 'GET',
		Headers = {
			['Content-Type'] = 'application/json',
			['api-key'] = apikey,
		},
	})
	local data = res.Body
	if data ~= nil then
		return http:JSONDecode(data)
	else
		return {}
	end
end

-- decoded: (the response)
--[[
    decoded = {
        {UserID: number, PlaceID: number, ServerID: uuid, RequestID: uuid},
        {UserID: number, PlaceID: number, ServerID: uuid, RequestID: uuid},
        ...
    }
]]

function deletePendingID(id): boolean --(will make once we get everything working)
	-- local res = http:RequestAsync({
	-- 	Url = url .. 'pending/',
	-- 	Method = 'DELETE',
	-- 	Headers = {
	-- 		['Content-Type'] = 'application/json',
	-- 		['api-key'] = apikey,
	-- 		--	['delete-id'] = id,
	-- 	},
	-- 	Body = { ['delete-id'] = id },
	-- })
	-- local data = res.Body
	-- if data ~= nil then
	-- 	return http:JSONDecode(data)
	-- else
	-- 	return {}
	-- end
	return false
end

local isUserPending = Instance.new('RemoteFunction')
isUserPending.Name = 'is he?'
isUserPending.Parent = game:GetService('ReplicatedStorage')

local confirmTP = Instance.new('RemoteFunction')
confirmTP.Name = 'indeed i do'
confirmTP.Parent = game:GetService('ReplicatedStorage')

local ActiveTPs = {}

local example_pending = {
	{
		UserID = 145291526, --insyri
		PlaceID = 5315046213, --bhop
		ServerID = 'f34083ed-2345-4308-8853-da76e01739a4',
		RequestID = http:GenerateGUID(false), --up to you i guess could make it a uuid
	},
	{
		UserID = 1455906620,
		PlaceID = 5315046213,
		ServerID = 'f34083ed-2345-4308-8853-da76e01739a4',
		RequestID = http:GenerateGUID(false),
	},
}
isUserPending.OnServerInvoke = function(player)
	local pending = example_pending --getPendingRequests()
	for _, req in pairs(pending) do
		if req.UserID == player.UserId then
			ActiveTPs[player.UserId] = req --Store for the confirmation
			return true
		end
	end
	return false
end
confirmTP.OnServerInvoke = function(player)
	local tpInfo = ActiveTPs[player.UserId]
	if tpInfo then
		local settings = Instance.new('TeleportOptions')
		settings.ServerInstanceId = tpInfo.ServerID
		local success, result = pcall(function()
			TP:TeleportAsync(tpInfo.PlaceID, { player }, settings)
		end)
		if success then
			--Delete the RequestID here as TP succeeded
			deletePendingID(tpInfo.RequestID)
			ActiveTPs[player.UserId] = nil
			return true, nil
		end
		--No need to do anything extra on a fail, just let client realise it
		return false, result
	end
	return false, 'No TP Is ready for you'
end
