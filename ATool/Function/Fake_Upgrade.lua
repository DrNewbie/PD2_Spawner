if PlayerManager and A_Tool_4_Use and self:is_Enable() then
	A_Tool_4_Use.Fake_upgrade_List = A_Tool_4_Use.Fake_upgrade_List or {}

	function A_Tool_4_Use:Get_Fake_Upgrade(category, upgrade)
		self.Fake_upgrade_List[category] = self.Fake_upgrade_List[category] or {}
		return self.Fake_upgrade_List[category][upgrade] or nil
	end

	function A_Tool_4_Use:Add_Fake_Upgrade(category, upgrade, value)
		self.Fake_upgrade_List[category] = self.Fake_upgrade_List[category] or {}
		self.Fake_upgrade_List[category][upgrade] = value
	end

	function A_Tool_4_Use:Del_Fake_Upgrade(category, upgrade)
		self.Fake_upgrade_List[category] = self.Fake_upgrade_List[category] or {}
		self.Fake_upgrade_List[category][upgrade] = nil
	end
	
	Fake_upgrade_value = Fake_upgrade_value or PlayerManager.upgrade_value
	function PlayerManager:upgrade_value(category, upgrade, ...)
		return A_Tool_4_Use:Get_Fake_Upgrade(category, upgrade) or Fake_upgrade_value(self, category, upgrade, ...)
	end	
	Fake_has_category_upgrade = Fake_has_category_upgrade or PlayerManager.has_category_upgrade
	function PlayerManager:has_category_upgrade(category, upgrade, ...)
		return A_Tool_4_Use:Get_Fake_Upgrade(category, upgrade) and true or Fake_has_category_upgrade(self, category, upgrade, ...)
	end	
end