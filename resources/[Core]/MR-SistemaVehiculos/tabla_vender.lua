local Markervender = {

{Posiciones={2557.9130859375, -1126.8994140625, 64.043228149414}, textoMarker="#FFFF00Para vender el vehículo al estado \n#FFFFFFusa #1B644A/vendervehestado", int = 0, dim = 0}, --TEMPLE
{Posiciones={1013.515625, -1007.08203125, 32.1015625}, textoMarker="#FFFF00Para vender el vehículo al estado \n#FFFFFFusa #1B644A/vendervehestado", int = 0, dim = 0}, --COLINAS
{Posiciones={1372.748046875, -1892.6298828125, 13.495409965515}, textoMarker="#FFFF00Para vender el vehículo al estado \n#FFFFFFusa #1B644A/vendervehestado", int = 0, dim = 0},
{Posiciones={1867.0068359375, -2381.333984375, 13.5546875}, textoMarker="#FFFF00Para vender el vehículo al estado \n#FFFFFFusa #1B644A/vendervehestado", int = 0, dim = 0},


{Posiciones={2131.7060546875, -1150.5327148438, 23.5}, textoMarker="#FFFFFFConcesionario de Jefferson\n#70FF00/vehiculos", int = 0, dim = 0},
{Posiciones={2475.7973632813, -1750.6513671875, 13}, textoMarker="#FFFFFFConcesionario de Motos\n#70FF00/vehiculos", int = 0, dim = 0},
{Posiciones={542.10986328125, -1292.8754882812, 17}, textoMarker="#FFFFFFConcesionario de Grotti\n#70FF00/vehiculos", int = 0, dim = 0},
{Posiciones={1097.763671875, -1370.8673095703, 13.5}, textoMarker="#FFFFFFConcesionario de Market\n#70FF00/vehiculos", int = 0, dim = 0},
{Posiciones={1897.4875488281, -2345.3630371094, 13}, textoMarker="#FFFFFFConcesionario de Los Santos International\n#70FF00/vehiculos", int = 0, dim = 0},
{Posiciones={723.11, -1494.55, 1.5}, textoMarker="#FFFFFFConcesionario de Barcos\n#70FF00/vehiculos", int = 0, dim = 0},
{Posiciones={1399.150390625, 456.26892089844, 19.5}, textoMarker="#FFFFFFConcesionario de Montgomery\n#70FF00/vehiculos", int = 0, dim = 0},
{Posiciones={824.251953125, 3.232421875, 1004.1796875}, textoMarker="#FFFFFF/anuncio", int = 3, dim = 0},
{Posiciones={1586.3447265625, -1690.1337890625, 16.1953125}, textoMarker="#FFFFFF/basurapd", int = 0, dim = 0},
{Posiciones={2447.947265625, -1963.1650390625, 13.546875}, textoMarker="#FFFF00/mercado", int = 0, dim = 0},
{Posiciones={772.822265625, 5.4150390625, 1000.7802124023}, textoMarker="#FFFF00/estilo", int = 5, dim = 0},
{Posiciones={772.9072265625, 3.046875, 1000.7178344727}, textoMarker="#FFFF00Para guardar tú estilo de pelea pon:\n/guardarestilo", int = 5, dim = 0},

}

addEventHandler("onResourceStart", resourceRoot, function()
    local markers = getMarkervender()
    for i, marker in ipairs(markers) do
        local posX, posY, posZ = unpack(marker.Posiciones)
        local blip = createBlip(1372.748046875, -1892.6298828125, 13.495409965515, 36, 2, 255, 255, 0, 255, 0)
        setBlipVisibleDistance(blip, 200)
    end
end)

function getMarkervender()

	return Markervender 

end