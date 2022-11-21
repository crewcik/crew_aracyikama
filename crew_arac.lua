obje = {}
function arabaYikamaFonksiyonu(localPlayer, komut, aracID)
    if not aracID then
        outputChatBox("[CREW]:#ffffff Taşıt ID girmediniz!",localPlayer, 225, 0, 0, true)
    return end
    
    if getElementData(localPlayer, "aracyikiyor") == true then
        outputChatBox("[CREW]:#FFFFFF Zaten şuanda araç yıkama işlemi gerçekleştiriyorsunuz!",localPlayer, 225, 0, 0, true)
    return end

    local theVehicle = exports.pool:getElement("vehicle", aracID)
    if getElementData(localPlayer, "loggedin") == 1 then -- Karaktere giriş yaptıysa.
        if not getPedOccupiedVehicle(localPlayer) then -- Araç içerisinde değilse.
            local x,y,z = getElementPosition(localPlayer)
            local xv,yv,zv = getElementPosition(theVehicle)
            local int = getElementInterior(localPlayer)
            local dim = getElementDimension(localPlayer)
            if getDistanceBetweenPoints3D(x,y,z,xv,yv,zv) < 2 then -- Karakter ile Araç birbirine yakınsa.
                --if exports.global:hasItem(localPlayer, 10035, 1) then -- Yıkama süngeri varsa.
                    exports.global:sendLocalDoAction(localPlayer, "Sağ elinde yıkama süngeri bulunmaktadır.")
                    exports.global:sendLocalMeAction(localPlayer, "Sağ elindeki süngeri kovaya sokar ve aracı yıkamaya başlar.")
                    setElementData(localPlayer, "aracyikiyor", true)
                    obje[localPlayer] = createObject(1778,x,y+1.5,z-1)
                    setElementInterior(obje[localPlayer], int)
                    setElementDimension(obje[localPlayer], dim)
                    setElementFrozen(localPlayer, true)
                    exports.global:applyAnimation(localPlayer, "bar", "barserve_bottle", -1, true, false, false) -- Kaynak yap animasyonu
                    triggerClientEvent("aracYikamaGonderildi", localPlayer, localPlayer, theVehicle)
                    outputChatBox("[CREW]:#FFFFFF Aracı temizlemeye başladınız!",localPlayer, 225, 0, 0, true)
                    setTimer(function()
                        exports.global:sendLocalDoAction(localPlayer, "Aracın temizlendiği görünmektedir.")
                        destroyElement(obje[localPlayer])
                        obje[localPlayer] = nil
                        outputChatBox("[CREW]:#FFFFFF Aracın temizliğini tamamladınız!",localPlayer, 225, 0, 0, true)
                        setElementFrozen( localPlayer, false )
                        setPedAnimation(localPlayer, "", "")
                        setElementData(localPlayer, "aracyikiyor", nil)
                    end,10000,1)
                --else
                    --outputChatBox("[CREW]:#FFFFFF Aracı yıkamak için [ Yıkama Süngeri ] adlı eşyaya ihtiyacınız bulunmakta!",localPlayer, 225, 0, 0, true)
                --end
            else
                outputChatBox("[CREW]:#FFFFFF [ID: "..tonumber(aracID).."] taşıtın yakınında değilsiniz!",localPlayer, 225, 0, 0, true)
            end
        else
            outputChatBox("[CREW]:#FFFFFF Araç içerisindeyken araç temizleme işlemini yapamazsınız!",localPlayer, 225, 0, 0, true)
        end
    end
end
addCommandHandler("aracyikama", arabaYikamaFonksiyonu)