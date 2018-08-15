A_Tool_4_Use = A_Tool_4_Use or {}
A_Tool_4_Use._path = ModPath
A_Tool_4_Use._data_path = A_Tool_4_Use._path.."Save.txt"
A_Tool_4_Use._log_path = A_Tool_4_Use._path.."Logs.txt"
A_Tool_4_Use._data = {
		DayNight = 1,
		EnemyStates = 1,
		AnimSyncLoop = 1,
		AnimSoloLoop = 1,
		HeavyLoad_Enable = false,
		HeavyLoad_List = {}
	}

A_Tool_4_Use.Aim_Far = 10000

function A_Tool_4_Use:save(ask_reboot)
	local xfile = io.open(self._data_path, "w+")
	if xfile then
		xfile:write(json.encode(self._data))
		xfile:close()
	end
	self.ask_reboot = ask_reboot
end

function A_Tool_4_Use:load()
	local xfile = io.open(self._data_path, "r")
	if xfile then
		self._data = json.decode(xfile:read("*all"))
		xfile:close()
	end
end

function A_Tool_4_Use:Log(msg)
	msg = tostring(msg)
	local xfile = io.open(self._log_path, "a")
	if xfile then
		xfile:write(tostring(os.date("!%H:%M:%S")).."\t"..msg.."\n")
		xfile:close()
	end
	log(msg)
end

function A_Tool_4_Use:Ask_Reboot_Yes()
	managers.game_play_central:restart_the_game()
end

function A_Tool_4_Use:Get_Crosshair_Unit()
	if self:InGame() and managers.player and managers.player:player_unit() then
		local camera = managers.player:player_unit():camera()
		local From = camera:position()
		local To = Vector3()
		mvector3.set(To, camera:forward())
		mvector3.multiply(To, 20000)
		mvector3.add(To, From)
		local Ray = World:raycast("ray", From, To, "slot_mask", managers.slot:get_mask("bullet_impact_targets"))
		if Ray and Ray.unit then
			return Ray.unit
		end
	end
	return nil
end

function A_Tool_4_Use:InGame()
	if Utils and (Utils:IsInHeist() or Utils:IsInGameState()) then
		return true
	end
	return false
end

function A_Tool_4_Use:Ask_Reboot()
	if self:InGame() then
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
	function MenuCallbackHandler:A_Tool_4_Use_SpawnEnemy_Menu()
		A_Tool_4_Use:Spawn_Enemy_Menu()
	end
	function MenuCallbackHandler:A_Tool_4_Use_ReLoadLua()
		A_Tool_4_Use:Init()
	end
	function MenuCallbackHandler:A_Tool_4_Use_RemoveUnit()
		A_Tool_4_Use:Remove_Units_Menu()
	end
	function MenuCallbackHandler:A_Tool_4_Use_GiveAnimToUnit()
		A_Tool_4_Use:Give_Anim_To_Unit_Menu()
	end
	function MenuCallbackHandler:A_Tool_4_Use_DayNight(item)
		A_Tool_4_Use._data.DayNight = item:value()
		A_Tool_4_Use:save(true)
	end
	function MenuCallbackHandler:A_Tool_4_Use_EnemyType(item)
		A_Tool_4_Use._data.EnemyStates = item:value()
		A_Tool_4_Use:save()
	end
	function MenuCallbackHandler:A_Tool_4_Use_AnimSyncLoop(item)
		A_Tool_4_Use._data.AnimSyncLoop = item:value()
		A_Tool_4_Use:save()
	end
	function MenuCallbackHandler:A_Tool_4_Use_AnimSoloLoop(item)
		A_Tool_4_Use._data.AnimSoloLoop = item:value()
		A_Tool_4_Use:save()
	end
	function MenuCallbackHandler:A_Tool_4_Use_HeavyLoad_Enable(item)
		A_Tool_4_Use._data.HeavyLoad_Enable = tostring(item:value()) == "on" and true or false
		A_Tool_4_Use:save()
	end
	
	MenuHelper:LoadFromJsonFile(A_Tool_4_Use._path.."Menu/Menu.json", A_Tool_4_Use, A_Tool_4_Use._data)
	MenuHelper:LoadFromJsonFile(A_Tool_4_Use._path.."Menu/HeavyLoad.json", A_Tool_4_Use, A_Tool_4_Use._data.HeavyLoad_List)
	
	if tweak_data.levels then
		local xfile = io.open(A_Tool_4_Use._path.."Menu/HeavyLoad.json", "w+")
		if xfile then 
			local A_Tool_4_Use_HeavyLoad_List = {}
			table.insert(A_Tool_4_Use_HeavyLoad_List, {
				["type"] = "toggle",
				["id"] = "A_Tool_4_HeavyLoad_Enable_Menu",
				["title"] = "A_Tool_4_HeavyLoad_Enable_title",
				["desc"] = "A_Tool_4_Use_empty_desc",
				["callback"] = "A_Tool_4_Use_HeavyLoad_Enable",
				["value"] = "HeavyLoad_Enable",
				["default_value"] = false
			})
			table.insert(A_Tool_4_Use_HeavyLoad_List, {
				["type"] = "divider",
				["size"] = 40
			})
			for id, lvl in ipairs(tweak_data.levels._level_index) do
				local cbk = "Cbk_"..Idstring("A_Tool_4_Use_HeavyLoad_"..lvl):key()
				MenuCallbackHandler[cbk] = function(self, item)			
					A_Tool_4_Use._data.HeavyLoad_List[lvl] = tostring(item:value()) == "on" and true or false
					A_Tool_4_Use:save()
				end
				table.insert(A_Tool_4_Use_HeavyLoad_List, {
					["type"] = "toggle",
					["id"] = "Menu_"..Idstring("A_Tool_4_Use_HeavyLoad_"..lvl):key(),
					["title"] = tweak_data.levels[lvl].name_id,
					["desc"] = "A_Tool_4_Use_empty_desc",
					["callback"] = cbk,
					["value"] = lvl,
					["default_value"] = false
				})
			end
			xfile:write('{\n')
			xfile:write('	"menu_id":"A_Tool_4_HeavyLoad_Menu",\n')
			xfile:write('	"parent_menu_id":"A_Tool_4_Use_menu_id",\n')
			xfile:write('	"title":"A_Tool_4_HeavyLoad_title",\n')
			xfile:write('	"description":"A_Tool_4_Use_empty_desc",\n')
			xfile:write('	"back_callback":"A_Tool_4_Use_back_callback",\n')
			xfile:write('	"items":'..json.encode(A_Tool_4_Use_HeavyLoad_List)..'\n')
			xfile:write('}\n')
			xfile:close()
		end
	end
end)

function A_Tool_4_Use:Init()
	self:load()
	local path_now = self._path.."/Function/Load_Lua.lua"
	dofile(path_now)
end

A_Tool_4_Use:Init()