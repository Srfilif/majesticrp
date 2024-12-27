JobInfo = {
["Bus Driver"] = {
    team="Civiles",
    employer="Transportation Ministry",
    skins={{253,"Driver 1"},{255,"Driver 2"}},
    wanted=20,
    desc="Soon.",
},

["Granjero"] = {
    team="Civiles",
    employer="Agriculture Ministry",
    divisions={{"Bail Farmer", 0}},
    skins={{158,"Old Farmer"},{159,"Hillbilly"},{160,"Bearded Farmer"},{161,"Male Farmer"},{157,"Female Farmer"},{162,"Shirtless Farmer"}},
    wanted=20,
    desc="Farmers farm buy seeds. once they buy seeds, they wait for a period of time before those seeds turn into plants. They then farm them and in return, earn a decent amount amount of money.",
},

["Leñador"] = {
    team="Civiles",
    skins={{27,"Winston Stafford"}, {260,"Allard Bradford"}},
    wanted=20,
    desc="Lumberjacks are workers in the logging industry \nwho perform the initial harvesting and transport of trees for ultimate processing into forest products. \nYour object is to use the Bulldozer to cut trees, anywhere in San Andreas \nthen afterwards use the DFT-30 to transport them to the Furniture Factory",
},

["Minero"] = {
    team="Civiles",
    employer="Distributed Mining Co.",
    skins={{27,"Miner 1"},{260,"Miner 2"}},
    wanted=20,
    desc="You'll need to rent a shovel (pickaxe). Quarry miners have the duty to smash big rocks into small fragements in order to extract elements. These elements can vary between Copper, Silver, Bronze, Iron, and Gold. Based on these elements, the pay will vary depending on what they find. The job may seem easy, but can also carry risks!",
},

["Pizzero"] = {
    team="Civiles",
    employer="The Well Stacked Pizza",
    --divisions={""},
    skins={{155,"Pizza Boy"}},
    wanted=20,
    desc="Deliver Pizzas from a pizza shop to customers arround cities.",
},

["Basurero"] = {
    team="Civiles",
    employer="RS Haul",
    --divisions={""},
    skins={{16,"Skin 1"}},
    wanted=20,
    desc="Recolecta la basura alrededor de LS, Cuando el camion este lleno, vuelve al basurero por tu paga.",
},
}

JobLoc = {
	{job="Bus Driver", mLoc={209.638671875, -163.00390625, 1.578125-1}, mCol={255, 200, 0}, blipLoc={209.638671875, -163.00390625}, blipID=56},
	{job="Leñador", mLoc={-748.337890625, -130.451171875, 65.828125-1}, mCol={255, 200, 0}, blipLoc={-748.337890625, -130.451171875}, blipID=56},
	{job="Pizzero", mLoc={377.966796875, -119.458984375, 1001.4921875-1, 5, 0}, mCol={255, 200, 0}, --[[blipLoc={2123.222, -1813.903, 5, 0}, blipID=56]]},
	{job="Basurero", mLoc={1291.2662353516, 194.93417358398, 20.484130859375-1}, mCol={255, 200, 0}, blipLoc={1291.2662353516, 194.93417358398}, blipID=56},
	{job="Granjero", mLoc={1106, -299.8056640625, 74.5390625-1}, mCol={255, 200, 0}, blipLoc={1106, -299.8056640625}, blipID=56},
	{job="Minero", mLoc={2461.7666015625, -295.44198608398, 27.284130096436-1}, mCol={255, 205, 0}, blipLoc={2461.7666015625, -295.44198608398}, blipID=56},
}

function getJobsTable(type)
    if (type == "locations") then
        return JobLoc
    else
        return JobInfo
    end
end