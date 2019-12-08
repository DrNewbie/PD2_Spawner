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
	name = tostring(name)
	if Utils and managers.player and managers.player:player_unit() and self:is_Enable() then
		local Pos = Utils:GetPlayerAimPos(managers.player:player_unit(), self.Aim_Far)
		if not tostring(Pos):find("Vector3") then
			return
		end
		if not DB:has("unit", name) then
			self:Log("DB:has false, "..name)
			return
		end
		Rot = Rot or self:turn(managers.player:player_unit():camera():rotation())
		local unit = safe_spawn_unit(Idstring(name), Pos, Rot)
		if unit then
			local _access = unit:base():char_tweak().access
			if _access == "civ_male" or _access == "civ_female" then
				if self._data.EnemyStates == 1 then
					unit:brain():set_spawn_ai({
						init_state = "idle",
						objective = {
							interrupt_health = 1,
							interrupt_dis = -1,
							type = "act",
							action = {
								align_sync = true,
								body_part = 1,
								type = "act",
								variant = self._Using_Anim or "cm_sp_stand_idle"
							}
						}
					})
					unit:brain():set_active(false, false)
				end
			else
				local team = _access == "gangster" and "gangster" or "combatant"
				local team_id = tweak_data.levels:get_default_team_ID(team)
				unit:movement():set_team(managers.groupai:state():team_data(team_id))
				self:Del_Fake_Upgrade("player", "convert_enemies_max_minions")
				if self._data.EnemyStates == 1 then
					unit:brain():set_spawn_ai({init_state = "idle"})
					unit:brain():set_active(false, false)
				elseif self._data.EnemyStates == 2 then
				
				elseif self._data.EnemyStates == 3 then
					self:Add_Fake_Upgrade("player", "convert_enemies_max_minions", 9999)
					team_id = tweak_data.levels:get_default_team_ID("player")
					unit:movement():set_team(managers.groupai:state():team_data(team_id))			
					managers.groupai:state():convert_hostage_to_criminal(unit)
				end
			end
			local u_key = tostring(unit:key())
			if self.Spawn_Unit[u_key] then
				self:Remove_One_Unit(nil, u_key)
			end
			self.Spawn_Unit[u_key] = unit
		end
	end
end