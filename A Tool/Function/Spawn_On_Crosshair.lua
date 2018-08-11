A_Tool_4_Use.Spawn_Unit = A_Tool_4_Use.Spawn_Unit or {}

function A_Tool_4_Use:Spawn_On_Crosshair(name, active, Rot)
	if Utils and managers.player and managers.player:player_unit() then
		local Pos = Utils:GetPlayerAimPos(managers.player:player_unit(), A_Tool_4_Use.Aim_Far)
		Rot = Rot or Rotation()
		local unit = safe_spawn_unit(Idstring(name), Pos, Rot)
		if unit then
			local team = unit:base():char_tweak().access == "gangster" and "gangster" or "combatant"
			local team_id = tweak_data.levels:get_default_team_ID(team)
			unit:movement():set_team(managers.groupai:state():team_data(team_id))
			if not active then
				unit:brain():set_spawn_ai({init_state = "idle"})
				unit:brain():set_active(false, false)
			end
			if self.spawn_anim then
				--table.random(CopActionAct._act_redirects.SO)
				local variant = self.spawn_anim
				local action_data = { type = "act", body_part = 1, variant = variant, align_sync = true }
				unit:brain():action_request(action_data)
			end
			local u_key = tostring(unit:key())
			if self.Spawn_Unit[u_key] then
				self:Remove_One_Unit(nil, u_key)
			end
			self.Spawn_Unit[u_key] = unit
		end
	end
end