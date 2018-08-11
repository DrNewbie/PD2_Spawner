function A_Tool_4_Use:load_lua()
	local lua_list = {
		"Enemy_List",
		"Spawn_On_Crosshair",
		"Spawn_Enemy_Menu",
		"Main_Menu",
		"Remove_Unit",
		"Day_Night_Changes",
		"Remove_Units_Menu"
	}
	for _, lua_name in pairs(lua_list) do
		local path_now = self._path.."/Function/"..lua_name..".lua"
		self:Log(path_now)
		dofile(path_now)
	end
end

A_Tool_4_Use:load_lua()