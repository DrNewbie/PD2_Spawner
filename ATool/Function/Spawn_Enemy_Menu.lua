function A_Tool_4_Use:Spawn_Enemy_Menu_In_Type_Done(enemy)
	if type(enemy) == "string" then
		self:Spawn_On_Crosshair(enemy, self._data.EnemyStates)
	else
		self:Log('Spawn_Enemy_Menu_In_Type_Done, type(enemy) == "string"')
		return
	end
end

function A_Tool_4_Use:Spawn_Enemy_Menu_In_Type(data)
	if type(data) ~= "table" then
		self:Log('Spawn_Enemy_Menu_In_Type, type(data) ~= "table"')
		return
	end
	local enemy = data.enemy or {}
	local index = data.index or 0
	if index < 0 then index = 0 end
	local j = 0
	local opts = {}
	if type(enemy) == "table" then
		for i, d in pairs(enemy) do
			if not self._data.SafeSpawn_Enable or (self._data.SafeSpawn_Enable and PackageManager:unit_data(Idstring(d))) then
				if i > index then
					local ey = string.split(d, "/")
					opts[#opts+1] = {text = "["..ey[#ey].."]", callback_func = callback(self, self, "Spawn_Enemy_Menu_In_Type_Done", d)}
					j = i
				end
				if #opts >= 12 then
					break
				end
			end
		end
	end
	opts[#opts+1] = {text = "[Next]", callback_func = callback(self, self, "Spawn_Enemy_Menu_In_Type", {enemy = data.enemy, index = j})}
	opts[#opts+1] = {text = "[Cancel]", is_cancel_button = true}
	managers.system_menu:show({
		title = "[List]",
		text = "Which one?",
		button_list = opts,
		id = "Random_Temp_Menu_"..Idstring(tostring(os.time())):key()
	})
end

function A_Tool_4_Use:Spawn_Enemy_Menu()
	if self:InGame() then
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
			id = "Random_Temp_Menu_"..Idstring(tostring(os.time())):key()
		})
	end
end