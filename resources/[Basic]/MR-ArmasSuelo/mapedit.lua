weaponsIDS = {
	--0
	[1] = 331,
	--1
	[2] = 333,
	[3] = 334,
	[4] = 335,
	[5] = 336,
	[6] = 337,
	[7] = 338,
	[8] = 339,
	[9] = 341,
	--2
	[22] = 346,
	[23] = 347,
	[24] = 348,
	--3
	[25] = 349,
	[26] = 350,
	[27] = 351,
	--4
	[28] = 352,
	[29] = 353,
	[32] = 372,
	--5
	[30] = 355,
	[31] = 356,
	--6
	[33] = 357,
	[34] = 358,
	--7
	[35] = 359,
	[36] = 360,
	[37] = 361,
	[38] = 362,
	--8
	[16] = 342,
	[17] = 343,
	[18] = 344,
	[39] = 363,
	--9
	[41] = 365,
	[42] = 366,
	[43] = 367,
	--10
	[10] = 321,
	[11] = 322,
	[12] = 323,
	[13] = 324,
	[14] = 325,
	[15] = 326,
	--11
	[44] = 368,
	[45] = 369,
	[46] = 371,
	--12
	[40] = 364
}

addEventHandler ( "onElementCreated", root,
	function ( propertyName )
		if getElementType(source) == "groundweapon" and propertyName == "weaponid" then
			local pickupType = exports.edf:edfGetElementProperty ( source, "weaponid" )
			local object = getRepresentation(source, "object")
			if object then
				setElementModel( object, weaponsIDS[pickupType])
			end
		end
	end
)

addEventHandler ( "onElementPropertyChanged", root,
	function ( propertyName )
		if getElementType(source) == "groundweapon" and propertyName == "weaponid" then
			local pickupType = exports.edf:edfGetElementProperty ( source, "weaponid" )
			local object = getRepresentation(source, "object")
			if object then
				setElementModel( object, weaponsIDS[pickupType])
			end
		end
	end
)

function getRepresentation(element,type)
	for i,elem in ipairs(getElementsByType(type,element)) do
		if elem ~= exports.edf:edfGetHandle ( elem ) then
			return elem
		end
	end
	return false
end
