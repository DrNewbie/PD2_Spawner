A_Tool_4_Use = A_Tool_4_Use or {
	_path = ModPath,
	_data_path = SavePath.."A_Tool_4_Use.txt",
	_data = {
		DayNight = 1
	}
}

A_Tool_4_Use.Aim_Far = 10000

function A_Tool_4_Use:save(ask_reboot)
	local file = io.open(self._data_path, "w+")
	if file then
		file:write(json.encode(self._data))
		file:close()
	end
	self.ask_reboot = ask_reboot
end

function A_Tool_4_Use:load()
	local file = io.open(self._data_path, "r")
	if file then
		self._data = json.decode(file:read("*all"))
		file:close()
	end
end

function A_Tool_4_Use:Log(msg)
	log("[Tool] "..tostring(msg))
end

function A_Tool_4_Use:Ask_Reboot_Yes()
	managers.game_play_central:restart_the_game()
end

function A_Tool_4_Use:Ask_Reboot()
	if Utils and (Utils:IsInHeist() or Utils:IsInGameState()) then
		local opts = {}
		opts[#opts+1] = {text = "[Yes]", callback_func = callback(self, self, "Ask_Reboot_Yes", {})}
		opts[#opts+1] = {text = "[No]", is_cancel_button = true}
		managers.system_menu:show({
			title = "[!!!]",
			text = "You change some core settings, do you want to restart the heist?",
			button_list = opts,
			id = tostring(math.random(0,0xFFFFFFFF))
		})
	end
end

Hooks:Add("LocalizationManagerPostInit", "LocManPosIni_g145Menu", function(self)
	self:load_localization_file(A_Tool_4_Use._path.."EN.json")
end)

Hooks:Add("MenuManagerInitialize", "MenManIni_g145Menu", function(menu_manager)
	function MenuCallbackHandler:A_Tool_4_Use_back_callback()
		if A_Tool_4_Use.ask_reboot then
			A_Tool_4_Use.ask_reboot = nil
			A_Tool_4_Use:Ask_Reboot()
		end
		A_Tool_4_Use:save()
	end
	function MenuCallbackHandler:A_Tool_4_Use_Main_Menu()
		A_Tool_4_Use:Main_Menu()
	end
	function MenuCallbackHandler:A_Tool_4_Use_ReLoadLua()
		A_Tool_4_Use:Init()
	end
	function MenuCallbackHandler:A_Tool_4_Use_RemoveUnit()
		A_Tool_4_Use:Remove_Units_Menu()
	end
	function MenuCallbackHandler:A_Tool_4_Use_DayNight(item)
		A_Tool_4_Use._data.DayNight = item:value()
		A_Tool_4_Use:save(true)
	end
	MenuHelper:LoadFromJsonFile(A_Tool_4_Use._path.."Menu.json", A_Tool_4_Use, A_Tool_4_Use._data)
end)

function A_Tool_4_Use:Init()
	self:load()
	local path_now = self._path.."/Function/Load_Lua.lua"
	dofile(path_now)
	self:Log(path_now)
end

A_Tool_4_Use:Init()