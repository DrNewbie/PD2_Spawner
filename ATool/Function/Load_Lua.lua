function A_Tool_4_Use:load_lua()
	local lua_list = {
		"Enemy_List",
		"Spawn_On_Crosshair",
		"Spawn_Enemy_Menu",
		"Main_Menu",
		"Remove_Unit",
		"Day_Night_Changes",
		"Remove_Units_Menu",
		"Give_Anim_To_Unit",
		"Give_Anim_To_Unit_Menu",
		"Fake_Upgrade",
		"Stop_Unit_Menu"
	}
	for _, lua_name in pairs(lua_list) do
		local path_now = self._path.."/Function/"..lua_name..".lua"
		self:Log("load_lua, "..path_now)
		dofile(path_now)
	end
end

function A_Tool_4_Use:post_load_lua(lua_list)
	for _, lua_name in pairs(lua_list) do
		local path_now = self._path..lua_name..".lua"
		self:Log("post_load_lua, "..path_now)
		dofile(path_now)
	end
	return
end

A_Tool_4_Use:load_lua()