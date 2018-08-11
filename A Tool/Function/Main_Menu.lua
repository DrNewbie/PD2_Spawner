function A_Tool_4_Use:Main_Menu()
	local opts = {}
	opts[#opts+1] = {text = "Spawn Enemies", callback_func = callback(self, self, "Spawn_Enemy_Menu", {})}
	opts[#opts+1] = {text = "[Cancel]", is_cancel_button = true}
	managers.system_menu:show({
		title = "[List]",
		text = "Choose what you want.",
		button_list = opts,
		id = tostring(math.random(0,0xFFFFFFFF))
	})
end