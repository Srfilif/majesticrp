-- otro_script.lua
local db = exports["MR-Gamemode"]:getDatabase()

if db then
    local exito = dbExec(db, "INSERT INTO cuentas (nombre, pass, email) VALUES (?, ?, ?)", "usuarioNuevo", "contraseña123", "correo@example.com")
    if exito then
        outputDebugString("Usuario insertado correctamente.")
    else
        outputDebugString("Error al insertar el usuario.")
    end

    local queryHandle = dbQuery(db, "SELECT * FROM cuentas WHERE nombre = ?", "usuarioNuevo")
    if queryHandle then
        local result, rows, err = dbPoll(queryHandle, -1)
        if result then
            for _, fila in ipairs(result) do
                outputDebugString("Usuario: " .. fila.nombre .. ", Email: " .. fila.email)
            end
        else
            outputDebugString("Error en la consulta: " .. tostring(err))
        end
    end
else
    outputDebugString("La conexión a la base de datos no está disponible.")
end
