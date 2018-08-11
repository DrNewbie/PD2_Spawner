function A_Tool_4_Use:Enemy_List()
	local _char_map = tweak_data.character.character_map()
	local _using_map = {
		bulldozer = {
			"units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1",
			"units/payday2/characters/ene_bulldozer_2/ene_bulldozer_2",
			"units/payday2/characters/ene_bulldozer_3/ene_bulldozer_3"
		},
		favorite = {
			"units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1",
			"units/payday2/characters/ene_bulldozer_2/ene_bulldozer_2",
			"units/payday2/characters/ene_bulldozer_3/ene_bulldozer_3",
			"units/pd2_dlc_drm/characters/ene_bulldozer_medic/ene_bulldozer_medic",
			"units/pd2_dlc_drm/characters/ene_bulldozer_minigun/ene_bulldozer_minigun",
			"units/payday2/characters/ene_shield_1/ene_shield_1",
			"units/payday2/characters/ene_shield_2/ene_shield_2",
			"units/payday2/characters/ene_sniper_1/ene_sniper_1",
			"units/payday2/characters/ene_sniper_2/ene_sniper_2",
			"units/payday2/characters/ene_spook_1/ene_spook_1",
			"units/payday2/characters/ene_tazer_1/ene_tazer_1",
			"units/payday2/characters/ene_medic_m4/ene_medic_m4",
			"units/payday2/characters/ene_medic_r870/ene_medic_r870",
			"units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer_2/ene_zeal_bulldozer_2",
			"units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer_3/ene_zeal_bulldozer_3",
			"units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer/ene_zeal_bulldozer",
			"units/pd2_dlc_gitgud/characters/ene_zeal_cloaker/ene_zeal_cloaker",
			"units/pd2_dlc_gitgud/characters/ene_zeal_swat/ene_zeal_swat",
			"units/pd2_dlc_gitgud/characters/ene_zeal_swat_heavy/ene_zeal_swat_heavy",
			"units/pd2_dlc_gitgud/characters/ene_zeal_swat_shield/ene_zeal_swat_shield"
		},
		all_others = {}
	}
	local _bool_list = {}
	for _, _table in pairs(_using_map) do
		for _, _unit_name in pairs(_table) do
			_bool_list[_unit_name] = true
		end
	end
	for _, _table in pairs(_char_map) do
		if _table.path and _table.list then
			for _, _unit_name in pairs(_table.list) do
				local _full_unit_name = _table.path .. _unit_name .. "/" .. _unit_name
				if not _bool_list[_full_unit_name] then
					_bool_list[_full_unit_name] = true
					table.insert(_using_map.all_others, _full_unit_name)
				end
			end
		end
	end
	return _using_map
end