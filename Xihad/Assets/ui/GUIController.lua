local GUIController = {}

G_CEGUISubscriberSlot = {
	CommandSelect = function (e) GUIController.Command:onSelect(e) end,
	CommandHover = function (e) GUIController.Command:onHover(e) end,
	CommandHoverNil = function (e) GUIController.Command:onHoverNil(e) end,
	
	ExchangeItemClick = function (e) GUIController.ParcelExchange:onItemClick(e) end,
	ExchangeItemHover = function (e) GUIController.ParcelExchange:onItemHover(e) end,
	ExchangeItemHoverNil = function (e) GUIController.ParcelExchange:onItemHoverNil(e) end,
	ExchangeComplete = function (e) GUIController.ParcelExchange:onComplete(e) end,
	ExchangeTidy = function (e) GUIController.ParcelExchange:onTidy(e) end,
	ExchangeCancel = function (e) GUIController.ParcelExchange:onCancel(e) end,
}

function GUIController:init()
	self.Command = require "ui.Command"
	self.MapTileInfo = require "ui.MapTileInfo"
	self.ParcelExchange = require "ui.ParcelExchange"
	self.Notification = require "ui.Notification"
end

--[[
AttackDamage	
		- args : { damage = 20, position = { x = 300, y = 200 } }

--]]
local function showAttackDamageLabel(args)
	local damage = args.damage
	local hundreds = math.floor(damage%1000/100)
	local tens = math.floor(damage%100/10)
	local units = damage%10

	local prefix = "RedNumber/"
	local one = hundreds > 0 and prefix..hundreds or (tens > 0 and prefix..tens or prefix..units) 
	local two = hundreds > 0 and prefix..tens or (tens > 0 and prefix..units or "")
	local three = hundreds > 0 and prefix..units or ""
	
	local label = findWindow("AttackDamageLabel")
	label:getChild("One"):setProperty("Image", one)
	label:getChild("Two"):setProperty("Image", two)
	label:getChild("Three"):setProperty("Image", three)

	label:setEnabled(true)
	return label
end

--------------------- Exposed Interface ---------------------
local function checkResult(prefix, result)
	if result then
		print(prefix.." event failed, only these event type available for this widget:", unpack(result))
	end
end

function GUIController:subscribeEvent(eventName, callback)
	local idx = string.find(eventName, "%.")
	local wnd = string.sub(eventName, 1, idx - 1)
	local result = self[wnd]:addListener(callback, string.sub(eventName, idx + 1))
	checkResult("Subscribe", result)
end

function GUIController:unsubscribeEvent(eventName, callback)
	local idx = string.find(eventName, "%.")
	local wnd = string.sub(eventName, 1, idx - 1)
	local result = self[wnd]:removeListener(callback, string.sub(eventName, idx + 1))
	checkResult("Unsubscribe", result)
end

--[[------------------------------------------------------------------------------
	StatusWindow
		- args : { "HP"=?, "MP"=?, "名字"=?, "职业"=?, "技能"={1,2,3}, }
	AttackDamage	
		- args : { damage = 20, position = { x = 300, y = 200 } }
--]]-------------------------------------------------------------------------------
function GUIController:showWindow(name, ...)
	return self[name]:show(...)
end

function GUIController:hideWindow(name)
	self[name]:close()
end

--------------------- EventHandler --------------------------

return GUIController