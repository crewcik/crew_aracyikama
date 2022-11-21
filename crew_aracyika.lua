function aracTemizlemeEfektFonksiyonu(theVehicle)
    local x,y,z = getElementPosition(theVehicle)
    efekt = createEffect("waterfall_end",x,y,z-2,0,0,0)
    setTimer(function()
        destroyElement(efekt)
    end,10000,1)
end
addEvent( "aracYikamaGonderildi", true )
addEventHandler( "aracYikamaGonderildi", root, aracTemizlemeEfektFonksiyonu )