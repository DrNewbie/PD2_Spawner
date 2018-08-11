Hooks:PostHook(MissionManager, "init", "Do_Load_All_Unit", function()
	if tweak_data and tweak_data.narrative and tweak_data.levels and PackageManager and
		PackageManager:loaded("packages/game_base_init") and
		Global.game_settings and Global.game_settings.level_id then
		--[[
		local _search_in_leveltweak = {}
		local _jobs_index = tweak_data.narrative._jobs_index or {}
		for _, v in pairs(_jobs_index) do
			if tweak_data.narrative.jobs[v] then
				local _package = tweak_data.narrative.jobs[v].package
				if _package then
					if not PackageManager:loaded(_package) then
						PackageManager:load(_package)
						A_Tool_4_Use:Log('load('.._package..')')
					end
				else
					table.insert(_search_in_leveltweak, tostring(v))
				end
			end
		end
		for k, v in pairs(_search_in_leveltweak) do
			if tweak_data.levels[v] then
				local _package = tweak_data.levels[v].package
				if _package then
					if type(_package) == "string" then
						_package = {_package}
					end
					if type(_package) == "table" then
						for kk, vv in pairs(_package) do
							if not PackageManager:loaded(vv) then
								PackageManager:load(vv)
								A_Tool_4_Use:Log('load('..vv..')')
							end
						end
					end
				end
			end
		end
		local _heavy_loaded_patch = {"packages/lvl_mad", "packages/narr_born_1", "packages/lvl_chew"}
		for _, _package in pairs(_heavy_loaded_patch) do
			if PackageManager:package_exists(_package) and not PackageManager:loaded(_package) then
				PackageManager:load(_package)
				A_Tool_4_Use:Log('load('.._package..')')
			end
		end
		]]
	end
	if PackageManager:package_exists("packages/sm_wish") and not PackageManager:loaded("packages/sm_wish") then
		PackageManager:load("packages/sm_wish")
		A_Tool_4_Use:Log('load("packages/sm_wish")')
	end
end)