----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 07 Mar 2015
-- Resource: GTIrentals/vehicle_table.slua
-- Version: 1.0
----------------------------------------->>

function vehiclesTable() 
	return vehicles 
end

function random() 
	return math.random(0, 255), math.random(0, 255), math.random(0,255) 
end

vehicles = {
	-- Bus
	{id=431, pos={218.9296875, -158.248046875, 1.6805469989777+0.1, 360}, res={"Bus Driver"},},  
	-- Trashmaster
	{id=408, pos={1298.8994140625, 187.109375, 20.038312911987+1, 116.17581176758}, res={"Basurero"},}, 
	-- Pizzero
	{id=448, pos={1362.33203125, 256.7607421875, 19.135593414307, 70}, res={"Pizzero"}},
	{id=448, pos={1362.33203125+0.9, 256.7607421875+2, 19.135593414307, 70}, res={"Pizzero"}},
	{id=448, pos={1362.33203125+1.8, 256.7607421875+4, 19.135593414307, 70}, res={"Pizzero"}},
	-- Tractors
	{id=531, pos={1043.6064453125, -349.5322265625, 73.563529968262+1.5, 90}, res={"Granjero"},},
	-- Combine Harvester
	{id=532, pos={1043.6064453125, -349.5322265625-10, 73.563529968262+1, 90}, res={"Granjero"},},
	-- Lumberjack (Angel Pine)
	{id=486, pos={-749.4833984375-10, -144.505859375, 65.930358886719+0.8, 195}, res={"Leñador"}},
	-- DFT-300
	{id=578, pos={-749.4833984375, -144.505859375, 65.930358886719+1, 195}, res={"Leñador"}},
	-- Flatbed
	{id=573, pos={2459.814453125, -262.2138671875, 26.948703765869+1, 180}, col={225,255,0,0,0,0}, res={"Minero"},},
}