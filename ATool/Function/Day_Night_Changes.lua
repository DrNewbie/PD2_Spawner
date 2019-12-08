function A_Tool_4_Use:Day_Night_Changes()
	self:Log("Day_Night_Changes, "..self._data.DayNight)
	if tweak_data.levels and self._data.DayNight ~= 1 then
		if not PackageManager:loaded("levels/instances/unique/hlm_random_right003/world") then
			PackageManager:load("levels/instances/unique/hlm_random_right003/world")
		end
		if not PackageManager:loaded("levels/instances/unique/hox_fbi_armory/world") then
			PackageManager:load("levels/instances/unique/hox_fbi_armory/world")
		end
		if not PackageManager:loaded("levels/instances/unique/hlm_vault/world") then
			PackageManager:load("levels/instances/unique/hlm_vault/world")
		end
		if not PackageManager:loaded("levels/instances/unique/hlm_gate_base/world") then
			PackageManager:load("levels/instances/unique/hlm_gate_base/world")
		end
		if not PackageManager:loaded("levels/instances/unique/hlm_reader/world") then
			PackageManager:load("levels/instances/unique/hlm_reader/world")
		end
		if not PackageManager:loaded("levels/instances/unique/hlm_door_wooden_white_green/world") then
			PackageManager:load("levels/instances/unique/hlm_door_wooden_white_green/world")
		end
		if not PackageManager:loaded( "levels/narratives/vlad/ukrainian_job/world_sounds" ) then
			PackageManager:load( "levels/narratives/vlad/ukrainian_job/world_sounds" )
			PackageManager:load( "levels/narratives/vlad/jewelry_store/world_sounds" )
		end
		local time_settings = {
			"",
			"environments/pd2_env_hox_02/pd2_env_hox_02",
			"environments/pd2_env_morning_02/pd2_env_morning_02",
			"environments/pd2_env_arm_hcm_02/pd2_env_arm_hcm_02",
			"environments/pd2_env_n2/pd2_env_n2"
		}
		local environment_name = time_settings[self._data.DayNight]
		tweak_data.levels[Global.game_settings.level_id].env_params = {environment = environment_name}
	end
end

A_Tool_4_Use:Day_Night_Changes()