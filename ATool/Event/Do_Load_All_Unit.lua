Hooks:PostHook(MissionManager, "init", "Do_Load_All_Unit", function()
	if not Global.game_settings or not Global.game_settings.level_id then
		return
	end
	if A_Tool_4_Use and A_Tool_4_Use._data and A_Tool_4_Use._data.HeavyLoad_Enable and tweak_data and tweak_data.narrative and tweak_data.levels and PackageManager and
		PackageManager:loaded("packages/game_base_init") then
		if type(A_Tool_4_Use._data.HeavyLoad_List) == "table" then
			for lvl, bol in pairs(A_Tool_4_Use._data.HeavyLoad_List) do
				if tweak_data.levels[lvl] and bol then
					local _package = tweak_data.levels[lvl].package
					if _package then
						if type(_package) == "string" then
							_package = {_package}
						end
						if type(_package) == "table" then
							for kk, vv in pairs(_package) do
								if PackageManager:package_exists(vv) and not PackageManager:loaded(vv) then
									PackageManager:load(vv)
									A_Tool_4_Use:Log('load('..vv..')')
								end
							end
						end
					end
				end
			end
		end
	end
	if PackageManager:package_exists("packages/sm_wish") and not PackageManager:loaded("packages/sm_wish") then
		PackageManager:load("packages/sm_wish")
		A_Tool_4_Use:Log('load("packages/sm_wish")')
	end
end)