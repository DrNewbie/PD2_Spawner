function A_Tool_4_Use:Spawn_Enemy_Menu_In_Type_Done(enemy)
	if type(enemy) == "string" then
		self:Spawn_On_Crosshair(enemy)
	else
		A_Tool_4_Use:Log('Spawn_Enemy_Menu_In_Type_Done, type(enemy) == "string"')
		return
	end
end

function A_Tool_4_Use:Spawn_Enemy_Menu_In_Type(data)
	if type(data) ~= "table" then
		A_Tool_4_Use:Log('Spawn_Enemy_Menu_In_Type, type(data) ~= "table"')
		return
	end
	local enemy = data.enemy or {}
	local index = data.index or 0
	local opts = {}
	if type(enemy) == "table" then
		for i, d in pairs(enemy) do
			if i > index and #opts < 12 then
				local ey = string.split(d, "/")
				opts[#opts+1] = {text = "["..ey[#ey].."]", callback_func = callback(self, self, "Spawn_Enemy_Menu_In_Type_Done", d)}
			end
		end		
	end
	opts[#opts+1] = {text = "[Back]", callback_func = callback(self, self, "Spawn_Enemy_Menu_In_Type", {enemy = d, index = i - 12})}
	opts[#opts+1] = {text = "[Next]", callback_func = callback(self, self, "Spawn_Enemy_Menu_In_Type", {enemy = d, index = i})}
	opts[#opts+1] = {text = "[Cancel]", is_cancel_button = true}
	managers.system_menu:show({
		title = "[List]",
		text = "Which one?",
		button_list = opts,
		id = tostring(math.random(0,0xFFFFFFFF))
	})
end

function A_Tool_4_Use:Spawn_Enemy_Menu()
	local enemy = self:Enemy_List()
	local opts = {}
	for i, d in pairs(enemy) do
		opts[#opts+1] = {text = "["..i.."]", callback_func = callback(self, self, "Spawn_Enemy_Menu_In_Type", {enemy = d})}
	end
	opts[#opts+1] = {text = "[Cancel]", is_cancel_button = true}
	managers.system_menu:show({
		title = "[List]",
		text = "Which one?",
		button_list = opts,
		id = tostring(math.random(0,0xFFFFFFFF))
	})
end