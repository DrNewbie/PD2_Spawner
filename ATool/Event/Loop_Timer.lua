Hooks:Add("GameSetupUpdate", "A_Tool_4_Use_Loop_Timer", function(t, dt)
	if A_Tool_4_Use and A_Tool_4_Use._data and A_Tool_4_Use:InGame() then
		if A_Tool_4_Use.Loop_Delay then
			A_Tool_4_Use.Loop_Delay = A_Tool_4_Use.Loop_Delay - dt
			if A_Tool_4_Use.Loop_Delay < 0 then
				A_Tool_4_Use.Loop_Delay = nil
			end
		else
			A_Tool_4_Use.Loop_Delay = A_Tool_4_Use._data.AnimSyncLoop
			if managers.enemy then
				for _, data in pairs(managers.enemy:all_enemies()) do
					if data.unit and data.unit:brain() then
						if type(data.unit:brain().A_Tool_4_Use_SyncLoop_Anim) == "table" then
							data.unit:brain():action_request(data.unit:brain().A_Tool_4_Use_SyncLoop_Anim)
						end
					end
				end
			end
		end
		if managers.enemy then
			for _, data in pairs(managers.enemy:all_enemies()) do
				if data.unit and data.unit:brain() then
					if type(data.unit:brain().A_Tool_4_Use_SoloLoop_Anim) == "table" then
						local act = data.unit:brain().A_Tool_4_Use_SoloLoop_Anim
						if act._SoloLoopDelay then
							if not data.unit:brain()._SoloLoopDelay then
								data.unit:brain()._SoloLoopDelay = act._SoloLoopDelay
								data.unit:brain():action_request(act)
							else
								data.unit:brain()._SoloLoopDelay = data.unit:brain()._SoloLoopDelay - dt
								if data.unit:brain()._SoloLoopDelay < 0 then
									data.unit:brain()._SoloLoopDelay = nil
								end
							end
						end
					end
				end
			end
		end
	end
end)