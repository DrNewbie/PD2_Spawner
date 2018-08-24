function A_Tool_4_Use:Main_Menu()
	local opts = {}
	opts[#opts+1] = {text = managers.localization:text("A_Tool_4_Use_SpawnEnemy_title"), callback_func = callback(self, self, "Spawn_Enemy_Menu", {})}
	opts[#opts+1] = {text = managers.localization:text("A_Tool_4_Use_RemoveUnit_title"), callback_func = callback(self, self, "Remove_Units_Menu", {})}
	opts[#opts+1] = {text = managers.localization:text("A_Tool_4_Use_GiveAnimToUnit_title"), callback_func = callback(self, self, "Give_Anim_To_Unit_Menu", {})}
	opts[#opts+1] = {text = managers.localization:text("A_Tool_4_Use_StopUnit_title"), callback_func = callback(self, self, "Stop_Unit_Menu", {})}
	opts[#opts+1] = {text = "[Cancel]", is_cancel_button = true}
	managers.system_menu:show({
		title = "[List]",
		text = "Choose what you want.",
		button_list = opts,
		id = "Random_Temp_Menu_"..Idstring(tostring(os.time())):key()
	})
end