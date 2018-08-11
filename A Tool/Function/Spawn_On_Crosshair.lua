A_Tool_4_Use.Spawn_Unit = A_Tool_4_Use.Spawn_Unit or {}

function A_Tool_4_Use:turn(rot)
	local l = rot:yaw()
	if l > 0 then
		l = l - 180
	else
		l = l + 180
	end
	return Rotation(l, 0, 0)
end

function A_Tool_4_Use:Spawn_On_Crosshair(name, active, Rot)
	if Utils and managers.player and managers.player:player_unit() then
		local Pos = Utils:GetPlayerAimPos(managers.player:player_unit(), A_Tool_4_Use.Aim_Far)
		Rot = Rot or self:turn(managers.player:player_unit():camera():rotation())
		local unit = safe_spawn_unit(Idstring(name), Pos, Rot)
		if unit then
			local team = unit:base():char_tweak().access == "gangster" and "gangster" or "combatant"
			local team_id = tweak_data.levels:get_default_team_ID(team)
			unit:movement():set_team(managers.groupai:state():team_data(team_id))
			A_Tool_4_Use:Del_Fake_Upgrade("player", "convert_enemies_max_minions")
			if self._data.EnemyStates == 1 then
				unit:brain():set_spawn_ai({init_state = "idle"})
				unit:brain():set_active(false, false)
			elseif self._data.EnemyStates == 2 then
			
			elseif self._data.EnemyStates == 3 then
				A_Tool_4_Use:Add_Fake_Upgrade("player", "convert_enemies_max_minions", 9999)
				team_id = tweak_data.levels:get_default_team_ID("player")
				unit:movement():set_team(managers.groupai:state():team_data(team_id))			
				managers.groupai:state():convert_hostage_to_criminal(unit)
			end
			local u_key = tostring(unit:key())
			if self.Spawn_Unit[u_key] then
				self:Remove_One_Unit(nil, u_key)
			end
			self.Spawn_Unit[u_key] = unit
		end
	end
end