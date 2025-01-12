settings = {
    ["Main"] = {
        ["showChat"] = true,
        ["musicVolume"] = 0.5, -- Este es el volumen en el cual se reproduce la musica [0-1]
        ["music"] = "https://samplelib.com/lib/preview/mp3/sample-15s.mp3" -- Este es el enlace de la musica, esta puede ser un enlace a un musica con los formatos soportados o a un path del mismo resource

    },
    ["Infos"] = {
            {title = "TIP", text = "¿No tienes dinero?, Puedes conseguir un poco trabajando de obrero", icon = "infos_1"},
            {title = "DATO CURIOSOS", text = "Greenwood Roleplay se distingue por su comunidad amigable y su compromiso con ofrecer actualizaciones constantes, garantizando siempre una experiencia única y envolvente.", icon = "background"},
            {title = "CURIOSIDADES 2", text = "¿Sabías que Greenwood Roleplay cuenta con sistemas exclusivos creados desde cero? Nuestro equipo trabaja constantemente para innovar y sorprender a nuestros jugadores.", icon = "infos_1"},
            {title = "CURIOSIDADES 3", text = "El servidor está pensado para ofrecer un entorno equilibrado donde cada jugador pueda desarrollar su historia dentro de un mundo inmersivo y bien estructurado.", icon = "infos_1"},
            {title = "CURIOSIDADES 4", text = "La idea de Greenwood Roleplay nació de la pasión por el Roleplay, y nuestro sueño siempre ha sido construir un espacio donde las historias de los jugadores cobren vida de manera única.", icon = "infos_1"}
    }
}

function addInfobox(element, type, msg, side)
    if side == "server" then
        triggerClientEvent(element, "Notify", element, type, msg)
    elseif side == "client" then
        triggerEvent("Notify", element, type, msg)
    end
end