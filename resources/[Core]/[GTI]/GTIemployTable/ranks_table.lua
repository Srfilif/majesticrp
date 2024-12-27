Ranks = {
["Bus Driver"] = {
	[0] = {name="Trainee",                  promoTime=0},
	[1] = {name="Bus Driver",               promoTime=0.75},
	[2] = {name="Bus Driver I",             promoTime=3},
	[3] = {name="Bus Driver II",            promoTime=7},
	[4] = {name="Bus Driver III",           promoTime=13},
	[5] = {name="Bus Driver IV",            promoTime=20},
	[6] = {name="Bus Driver V",             promoTime=30},
	[7] = {name="Bus Driver VI",            promoTime=43},
	[8] = {name="Bus Driver VII",           promoTime=60},
	[9] = {name="Bus Driver IX",            promoTime=85},
	[10] = {name="Professional Driver",     promoTime=150},
},

["Granjero"] = {
	[0] = {name="Basic Farmer",         promoTime=0},
	[1] = {name="New Farmer",           promoTime=0.75},
	[2] = {name="Migrant Farmer",       promoTime=3},
	[3] = {name="Seasonal Farmer",      promoTime=7},
	[4] = {name="Yearly Farmer",        promoTime=13},
	[5] = {name="Botanical Maid",       promoTime=20},
	[6] = {name="Experienced Farmer",   promoTime=30},
	[7] = {name="Amish Son",            promoTime=43},
	[8] = {name="Amish Father",         promoTime=60},
	[9] = {name="Agricultural Madman",  promoTime=85},
	[10] = {name="Amish God",           promoTime=150},
},

["Leñador"] = {
	[0] = {name="Lumberjack",           promoTime=0},
	[1] = {name="Fast Chopper",         promoTime=5},
	[2] = {name="Slicer",               promoTime=10},
	[3] = {name="Expert Lumberjack",    promoTime=18},
	[4] = {name="Master Lumberjack",    promoTime=30},
},

["Pizzero"] = {
	[0] = {name="Trainee",                   promoTime=0},
	[1] = {name="Junior Pizza Boy",          promoTime=0.75},
	[2] = {name="Trained Pizza Boy",         promoTime=3},
	[3] = {name="Experienced Pizza Boy",     promoTime=7},
	[4] = {name="Senior Pizza Boy",          promoTime=13},
	[5] = {name="Professional Pizza Boy",    promoTime=20},
	[6] = {name="Expert Pizza Boy",          promoTime=30},
	[7] = {name="Executive Pizza Boy",       promoTime=43},
	[8] = {name="Addicted Pizza Boy",        promoTime=60},
	[9] = {name="Chief Pizza Boy",           promoTime=85},
	[10] = {name="God of Pizzas",            promoTime=150},
},

["Basurero"] = {
	[0] = {name="Trainee",              promoTime=0},
	[1] = {name="Junior Binman",        promoTime=0.75},
	[2] = {name="Senior Binman",        promoTime=3},
	[3] = {name="Assistant Specialist", promoTime=7},
	[4] = {name="Specialist Binman",    promoTime=13},
	[5] = {name="Professional Binman",  promoTime=20},
	[6] = {name="Expert Binman",        promoTime=30},
	[7] = {name="Chief Binman",         promoTime=43},
	[8] = {name="Executive Binman",     promoTime=60},
	[9] = {name="Trash Master",         promoTime=85},
	[10] = {name="God of Trash",        promoTime=150},
},

["Minero"] = {
	[0] = {name="Trainee",               promoTime=0},
	[1] = {name="Junior Miner",          promoTime=0.75},
	[2] = {name="Trained Miner",         promoTime=3},
	[3] = {name="Experienced Miner",     promoTime=7},
	[4] = {name="Senior Miner",          promoTime=13},
	[5] = {name="Professional Miner",    promoTime=20},
	[6] = {name="Expert Miner",          promoTime=30},
	[7] = {name="Executive Miner",       promoTime=43},
	[8] = {name="Addicted Miner",        promoTime=60},
	[9] = {name="Chief Miner",           promoTime=85},
	[10] = {name="God of the rock",      promoTime=150},
},
}

-- Job And Progress Auto-Balance
--------------------------------->>

RankBase = {
	["Bus Driver"] = {hProg=172, uName="Bus Stops", basePay=173},
	["Granjero"] = {hProg=1175, uName="Bails Harvested", basePay=76.74},
	["Minero"] = {hProg=34135, uName="Grams", basePay=1.05},
	["Leñador"] = {hProg=80, uName="Trees Cut", basePay=248},
	["Pizzero"] = {hProg=46, uName="Pizzas Delivered", basePay=0.7182},
	["Basurero"] = {hProg=83, uName="Trash Collected", basePay=360},
}

for job,_ in pairs(Ranks) do
    for lvl,tbl in pairs(Ranks[job]) do
        -- Insert Progress
        Ranks[job][lvl].progress = (RankBase[job].hProg)*tbl.promoTime
        Ranks[job][lvl].progress = math.floor(Ranks[job][lvl].progress)
    end
end

function getRanks()
    return Ranks
end

function getRankBase()
    return RankBase
end