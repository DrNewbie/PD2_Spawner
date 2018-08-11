function A_Tool_4_Use:Give_Anim_To_Unit_Now(unit, loop_anim, variant)
	if CopActionAct and CopActionAct:_get_act_index(variant) and unit and unit.brain and unit:brain() then
		local variant = variant
		local action_data = { type = "act", body_part = 1, variant = variant, align_sync = true }
		unit:brain():action_request(action_data)
		if loop_anim then
			unit:brain().A_Tool_4_Use_Loop_Anim = action_data
		end
	end
end

function A_Tool_4_Use:Give_Anim_To_Enemies_Unit(loop_anim, variant)
	if managers.enemy then
		for _, data in pairs(managers.enemy:all_enemies()) do
			if data.unit then
				self:Give_Anim_To_Unit_Now(data.unit, loop_anim, variant)
			end
		end
	end
end

function A_Tool_4_Use:Give_Anim_To_Crosshair_Unit(loop_anim, variant)
	local unit = self:Get_Crosshair_Unit()
	self:Give_Anim_To_Unit_Now(unit, loop_anim, variant)
end