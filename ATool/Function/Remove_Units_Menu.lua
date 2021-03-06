function A_Tool_4_Use:Remove_Units_Menu()
	if self:InGame() and self:is_Enable() then
		local opts = {}
		opts[#opts+1] = {text = "Spawned", callback_func = callback(self, self, "Remove_All_Unit", {})}
		opts[#opts+1] = {text = "Crosshair", callback_func = callback(self, self, "Remove_Crosshair_Unit", {})}
		opts[#opts+1] = {text = "Enemies", callback_func = callback(self, self, "Remove_Enemies_Unit", {})}
		opts[#opts+1] = {text = "Bodies", callback_func = callback(self, self, "Remove_Bodies_Unit", {})}
		opts[#opts+1] = {text = "[Cancel]", is_cancel_button = true}
		managers.system_menu:show({
			title = "[List]",
			text = "Which one?",
			button_list = opts,
			id = "Random_Temp_Menu_"..Idstring(tostring(os.time())):key()
		})
	end
end