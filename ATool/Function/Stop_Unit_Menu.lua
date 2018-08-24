function A_Tool_4_Use:Stop_Unit_Menu()
	if Utils and managers.player and managers.player:player_unit() then
		local unit = self:Get_Crosshair_Unit()
		if unit and unit:brain() then
			local machine = unit:anim_state_machine()
			if machine then
				unit:brain().A_Tool_4_Use_SyncLoop_Anim = nil
				unit:brain().A_Tool_4_Use_SoloLoop_Anim = nil
				machine:set_enabled(false)
				machine:stop_segment(Idstring("base"))
			end
		end
	end
end