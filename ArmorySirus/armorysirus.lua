local dbLink = "https://sirus.su/base/character/x"
local serverName = GetCVar("realmName")
local serverNumber = serverName:match("x1") and 1 or
                     serverName:match("x2") and 2 or
                     serverName:match("x5") and 5


local armoryButton = CreateFrame("Button","armoryButton",UIParent,"UIPanelButtonTemplate") --создание фрейма кнопки
armoryButton:SetPoint("CENTER", 0,200) -- позиция кнопки
armoryButton:SetWidth(80) -- установка ширины кнопки
armoryButton:SetHeight(23) -- установка высоты кнопки
armoryButton:SetText("Закрыть");  -- текст кнопки
armoryButton:Hide()


local normalFontName, normalFontSize, normalFontFlags = GameFontNormal:GetFont();
local armoryEditBox = CreateFrame("EditBox","armoryEditBox",UIParent,"InputBoxTemplate")
armoryEditBox:SetWidth("500")
armoryEditBox:SetHeight("40")
armoryEditBox:SetFont("Interface\\AddOns\\ArmorySiru\\arial.ttf", 11, "OUTLINE, MONOCHROME")
armoryEditBox:SetPoint("CENTER", 0,225)
armoryEditBox:Hide()


local DropdownMenuList = {"PLAYER","RAID_PLAYER","PARTY","TEAM","FRIEND","RAID",}

local function menuButtonFunction(self)	
    if self.value == "Armory" then
        local dropdownFrame = _G["UIDROPDOWNMENU_INIT_MENU"]
        local targetName = dropdownFrame.name
        local targetID = tonumber(UnitGUID(targetName))
        local armoryLink = table.concat({dbLink, serverNumber, targetID or targetName}, "/")
        armoryButton:Show()
        armoryEditBox:Show()
        armoryEditBox:SetText(armoryLink)
        armoryEditBox:HighlightText()
    end
end

UnitPopupButtons["Armory"] = {
    icon = "Interface\\GroupFrame\\UI-Group-LeaderIcon",
    text = "Оружейная",
    dist = 0,
}


for i,dropdownMenu in pairs(DropdownMenuList) do
    table.insert(UnitPopupMenus[dropdownMenu],"Armory")
end

hooksecurefunc("UIDropDownMenuButton_OnClick",menuButtonFunction)


armoryButton:SetScript("OnMouseDown",
    function(self,button,...) 
        if (button=="LeftButton") then
            armoryEditBox:Hide()
            armoryButton:Hide() 
        end
    end
);
