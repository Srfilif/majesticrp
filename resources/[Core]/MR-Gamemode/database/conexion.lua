-- conexion.lua
db = dbConnect("mysql", "dbname=s6674_Greenwood;host=us-va-04.vexyhost.com;charset=utf8", "u6674_xlCq5g6NI1", "ce40lqlWCqvvBaAGA+HPeVe+")

if not db then
    outputDebugString("No se pudo conectar a la base de datos.", 1)
else
    outputDebugString("Conexión a la base de datos establecida.", 3)
end

-- Exportar la conexión
function getDatabase()
    return db
end

if db then
    dbExec(db, [[
        CREATE TABLE IF NOT EXISTS cuentas (
            id INT AUTO_INCREMENT PRIMARY KEY,
            nombre VARCHAR(50) NOT NULL UNIQUE,
            pass VARCHAR(255) NOT NULL,
            fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
            staff TINYINT(1) DEFAULT 0,
            vip TINYINT(1) DEFAULT 0,
            creditos INT DEFAULT 0,
            email VARCHAR(50) NOT NULL
        )
    ]])

    dbExec(db, [[
        CREATE TABLE IF NOT EXISTS personajes (
            id INT AUTO_INCREMENT PRIMARY KEY,
            cuenta_id INT NOT NULL,
            nombre_apellido VARCHAR(50) NOT NULL,
            pass VARCHAR(255) NOT NULL,
            fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
            dinero INT DEFAULT 0,
            nivel INT DEFAULT 1,
            experiencia INT DEFAULT 0,
            ubicacion_x FLOAT DEFAULT 0,
            ubicacion_y FLOAT DEFAULT 0,
            ubicacion_z FLOAT DEFAULT 0,
            salud FLOAT DEFAULT 100,
            armadura FLOAT DEFAULT 0,
            Sexo TEXT NOT NULL DEFAULT 'Masculino',
            TestRoleplay TEXT NOT NULL DEFAULT 'No',
            Nacionalidad TEXT NOT NULL,
            Edad INT NOT NULL,
            DNI INT NOT NULL,
            armas TEXT DEFAULT NULL,
            Trabajo TEXT NOT NULL,
            Skin INT NOT NULL DEFAULT 2,
            interior INT NOT NULL,
            dimencion INT NOT NULL,
            FOREIGN KEY (cuenta_id) REFERENCES cuentas(id) ON DELETE CASCADE
        )
    ]])
    dbExec(db, [[
    CREATE TABLE IF NOT EXISTS objetos_suelo (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        amount INT NOT NULL,
        x INT NOT NULL,
        y INT NOT NULL,
        z INT NOT NULL,
        interior INT NOT NULL,
        dimension INT NOT NULL
    )
]])
    dbExec(db, [[
    CREATE TABLE IF NOT EXISTS Inventario (
        Jugador TEXT,
        Item TEXT,
        Value INTEGER
    )
]])
end
