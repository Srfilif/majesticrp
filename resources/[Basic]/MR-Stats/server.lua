
loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

permisos = {
["Admin"]=true,
["SuperModerador"]=true,
["Moderador"]=true,
["Sup.Staff"]=true,
["Sup.Facciones"]=true,
["Sup.Asesor"]=true,
["Sup.Grupos"]=true,
}






addCommandHandler("stats",function(player,cmd)
	local name = AccountName(player)
	local s = query("SELECT * FROM datos_personajes where Cuenta = ?", name)
	if not ( type( s ) == "table" and #s == 0 ) or not s then
		for i,v in ipairs(s) do
			triggerClientEvent(player,"winstats",player,personajes(player),v.Nacionalidad,v.Sexo,v.Edad)
		end
	end
end)

function personajes(source)
	local serial = source:getSerial()
	local s = query("SELECT * FROM datos_personajes where Serial = ?", serial)
	if not ( type( s ) == "table" and #s == 0 ) or not s then
		return s
	end
end
