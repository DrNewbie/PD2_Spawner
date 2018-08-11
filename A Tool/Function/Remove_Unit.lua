A_Tool_4_Use.Spawn_Unit = A_Tool_4_Use.Spawn_Unit or {}

function A_Tool_4_Use:Remove_One_Unit(unit, u_key)
	if u_key or (unit and unit.key) then
		u_key = u_key or tostring(unit:key())
		if alive(self.Spawn_Unit[u_key]) then
			World:delete_unit(self.Spawn_Unit[u_key])
		end
		if alive(self.Spawn_Unit[u_key]) then
			self.Spawn_Unit[u_key]:set_slot(0)
		end
		if alive(unit) then
			World:delete_unit(unit)
		end
		if alive(unit) then
			unit:set_slot(0)
		end
		self.Spawn_Unit[u_key] = nil
	end
end

function A_Tool_4_Use:Remove_All_Unit()
	for _, unit in pairs(self.Spawn_Unit) do
		self:Remove_One_Unit(unit)
	end
end

function A_Tool_4_Use:Remove_Crosshair_Unit()
	if Utils and managers.player and managers.player:player_unit() then
		local camera = managers.player:player_unit():camera()
		local From = camera:position()
		local To = Vector3()
		mvector3.set(To, camera:forward())
		mvector3.multiply(To, 20000)
		mvector3.add(To, From)
		local Ray = World:raycast("ray", From, To, "slot_mask", managers.slot:get_mask("bullet_impact_targets"))
		if Ray and Ray.unit then
			self:Remove_One_Unit(Ray.unit)
		end
	end
end

function A_Tool_4_Use:Remove_Enemies_Unit()
	if managers.enemy then
		for _, data in pairs(managers.enemy:all_enemies()) do
			if data.unit then
				self:Remove_One_Unit(data.unit)
			end
		end
	end
end

function A_Tool_4_Use:Remove_Bodies_Unit()
	if managers.enemy then
		managers.enemy:dispose_all_corpses()
	end
end