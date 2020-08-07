local selected = ScenEdit_SelectedUnits()

if #selected.units ~= 1 then
    ScenEdit_MsgBox("More than one unit selected.\nSelect one unit only.",6)
else
    myUnit=ScenEdit_GetUnit({name=selected.units[1].name,guid=selected.units[1].guid})
    local p="n"
    for v,k in pairs(ScenEdit_GetContacts(ScenEdit_PlayerSide())) do
        local con=ScenEdit_GetContact({side=ScenEdit_PlayerSide(), guid=k.guid})
        if con.name==myUnit.name and con.longitude==myUnit.longitude and con.latitude==myUnit.latitude then
            p=con.posture
            break
        end
    end

    if p=="H" then
        local numHeli=0
        local numBoat=0
        for v,k in pairs(VP_GetSide({Side=ScenEdit_PlayerSide()}).units) do
            if Tool_Range(myUnit.guid,k.guid)<0.0539 then
                local unitInQ=ScenEdit_GetUnit({guid=k.guid})
                if unitInQ.type=="Aircraft" then
                    if unitInQ.altitude<60 and unitInQ.speed<5 then
                        numHeli=numHeli+1
                    end
                end
                if unitInQ.type=="Boat" then
                    numBoat=numBoat+1
                end
            end
        end

        local message="No applicable units in reange to board vessel with"
        if(numHeli>0 or numBoat>0) then
            mesage = "Attempt forceful boarding with "
            if numHeli>0 then
                message=mesage .. numHeli .. " helicopters"
            end
            if numBoat>0 then
                message=mesage .. numBoats .. " boats"
            end
        end
        if ScenEdit_MsgBox(message,4) == "Yes" then
            if(numHeli>0 or numBoat>0) then
               local x=numHeli+numBoat*2-1
               local p=1/(1+math.exp(-x))
               if(math.random()<p) then
                ScenEdit_SetUnitSide({side=myUnit.side,name=myUnit.name,newside=ScenEdit_PlayerSide()})
                ScenEdit_MsgBox("Sucessful Boarding",6)
               else
                ScenEdit_MsgBox("Boarding Failed",6)
               end
            end
        end
    else
        ScenEdit_MsgBox("Select a hostile unit",6)
    end
end
