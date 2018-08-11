Hooks:Add("GameSetupUpdate", "A_Tool_4_Use_Loop_Timer", function(t, dt)
	if A_Tool_4_Use and A_Tool_4_Use:InGame() then
		if A_Tool_4_Use.Loop_Delay then
			A_Tool_4_Use.Loop_Delay = A_Tool_4_Use.Loop_Delay - dt
			if A_Tool_4_Use.Loop_Delay < 0 then
				A_Tool_4_Use.Loop_Delay = nil
			end
		else
			A_Tool_4_Use.Loop_Delay = 1
			if managers.enemy then
				for _, data in pairs(managers.enemy:all_enemies()) do
					if data.unit and data.unit:brain() and type(data.unit:brain().A_Tool_4_Use_Loop_Anim) == "table" then
						data.unit:brain():action_request(data.unit:brain().A_Tool_4_Use_Loop_Anim)
					end
				end
			end
		end
	end
end)