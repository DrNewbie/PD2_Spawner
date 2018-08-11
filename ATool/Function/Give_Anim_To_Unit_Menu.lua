function A_Tool_4_Use:Give_Repeat_Anim_Unit_Yes(data)
	if data.ask == 1 then
		self:Give_Anim_To_Crosshair_Unit(true, self._Using_Anim)
	elseif data.ask == 2 then
		self:Give_Anim_To_Enemies_Unit(true, self._Using_Anim)
	end
end

function A_Tool_4_Use:Give_Repeat_Anim_Unit_No(data)
	if data.ask == 1 then
		self:Give_Anim_To_Crosshair_Unit(false, self._Using_Anim)
	elseif data.ask == 2 then
		self:Give_Anim_To_Enemies_Unit(false, self._Using_Anim)
	end
end

function A_Tool_4_Use:Give_Repeat_Anim_Unit(data)
	if type(data) == "table" then
		local opts = {}
		opts[#opts+1] = {text = "[Yes]", callback_func = callback(self, self, "Give_Repeat_Anim_Unit_Yes", data)}
		opts[#opts+1] = {text = "[No]", callback_func = callback(self, self, "Give_Repeat_Anim_Unit_No", data)}
		opts[#opts+1] = {text = "[Close]", is_cancel_button = true}
		managers.system_menu:show({
			title = "[Animation]",
			text = "Repeat the anim?",
			button_list = opts,
			id = "Random_Temp_Menu_"..Idstring(tostring(os.time())):key()
		})
	end
end

function A_Tool_4_Use:Set_Using_Anim(data)
	self._Using_Anim = data
	self:Give_Anim_To_Unit_Menu()
end

function A_Tool_4_Use:Change_Using_Anim_InType(data)
	local anim_data = data.data or {}
	local index = data.index or 0
	if index < 0 then index = 0 end
	local opts = {}
	local j = 0
	for i, d in pairs(anim_data) do
		if i > index then
			opts[#opts+1] = {text = "["..d.."]", callback_func = callback(self, self, "Set_Using_Anim", d)}
			j = i
		end
		if #opts >= 12 then
			break
		end
	end
	opts[#opts+1] = {text = "[Next]", callback_func = callback(self, self, "Change_Using_Anim_InType", {name = data.name, data = anim_data, index = j})}
	opts[#opts+1] = {text = "[Close]", is_cancel_button = true}
	managers.system_menu:show({
		title = "[List]",
		text = "Curret Type: "..tostring(data.name),
		button_list = opts,
		id = "Random_Temp_Menu_"..Idstring(tostring(os.time())):key()
	})
end

function A_Tool_4_Use:Change_Using_Anim()
	local opts = {}
	opts[#opts+1] = {text = "None", callback_func = callback(self, self, "Set_Using_Anim", "")}
	for name, data in pairs(CopActionAct._act_redirects) do
		opts[#opts+1] = {text = "["..name.."]", callback_func = callback(self, self, "Change_Using_Anim_InType", {data = data, name = name})}
	end
	opts[#opts+1] = {text = "[Close]", is_cancel_button = true}
	managers.system_menu:show({
		title = "[List]",
		text = "Choose one",
		button_list = opts,
		id = "Random_Temp_Menu_"..Idstring(tostring(os.time())):key()
	})
end

function A_Tool_4_Use:Give_Anim_To_Unit_Menu()
	if self:InGame() then
		local opts = {}
		opts[#opts+1] = {text = "Change Anim", callback_func = callback(self, self, "Change_Using_Anim", {})}
		opts[#opts+1] = {text = "Crosshair", callback_func = callback(self, self, "Give_Repeat_Anim_Unit", {ask = 1})}
		opts[#opts+1] = {text = "Enemies", callback_func = callback(self, self, "Give_Repeat_Anim_Unit", {ask = 2})}
		opts[#opts+1] = {text = "[Close]", is_cancel_button = true}
		managers.system_menu:show({
			title = "[List]",
			text = "Curret Anim: "..tostring(self._Using_Anim),
			button_list = opts,
			id = "Random_Temp_Menu_"..Idstring(tostring(os.time())):key()
		})
	end
end