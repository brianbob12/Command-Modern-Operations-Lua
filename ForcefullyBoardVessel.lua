local selUnits = ScenEdit_SelectedUnits().units
if #selUnits ~= 1 then
    ScenEdit_MsgBox("More than one unit selected.\nSelect one unit only.",6)
elseif selUnits[1].side==nil then
    ScenEdit_MsgBox("Select a hostile unit",6)
elseif ScenEdit_GetSidePosture(ScenEdit_PlayerSide(),selUnits[1].side) == "H" then
    local chosen=selUnits[1]
    local rp=ScenEdit_AddReferancePoint({side=ScenEdit_PlayerSide (),longitude=chosen.logitude,latitude=chosen.latitude})
    if ScenEdit_MsgBox("Ready to go!",4) == 1 then
        ScenEdit_MsgBox("Done")
    end
else
    ScenEdit_MsgBox("Select a hostile unit",6)
end
