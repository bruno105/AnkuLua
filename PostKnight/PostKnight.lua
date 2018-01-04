Settings:setCompareDimension(true, 720)
Settings:setScriptDimension(true, 720)



function updateScript(currentVersion, currentImageVersion)
	httpGetAvailable, httpGetResult = pcall(httpGet, "https://raw.githubusercontent.com/bruno105/AnkuLua/master/PostKnight/version.lua")

	if (httpGetAvailable) then

		if(force_update) then
			toast("Network Functions enabled; repairing files...")
		else
			toast("Network Functions enabled; checking for updates...")
		end
		--Following update code provided by seebadoris.
		--Originally written by Paladiex: https://github.com/Paladiex
		--Used with permission.

		localPath = scriptPath()
		imagePath = (localPath .. "image/")

		--Don't need this currently.
		--commonLib = loadstring(httpGet("https://raw.githubusercontent.com/AnkuLua/commonLib/master/commonLib.lua"))()

		--- This checks the version number on github to see if an update is needed, then downloads the newest files ---
		getNewestVersion = loadstring(httpGetResult)
		latestVersion, latestImageVersion, patchNotes = getNewestVersion()
		--currentVersion = dofile(localPath .."version.lua")

		if (currentVersion >= latestVersion and force_update ~= true) then
			toast ("You are running the most current version!")
		else
			httpDownload("https://raw.githubusercontent.com/bruno105/AnkuLua/master/PostKnight/PostKnight.lua", localPath .."PostKnight.lua")
			if(force_update) then
				toast ("Repairing version "..latestVersion)
				print ("Repaired version "..currentVersion.." to version "..latestVersion)
			else
				toast ("Updating to version "..latestVersion)
				print ("Updated from version "..currentVersion.." to version "..latestVersion)
			end
			--print ("\n"..patchNotes.."\n")
			if ((currentImageVersion < latestImageVersion or force_update == true)) then
				httpDownload("https://raw.githubusercontent.combruno105/AnkuLua/master/PostKnight/updater.lua", localPath .."imageupdater.lua")
				if(force_update) then
					toast("Repair will redownload image directory. Stand by...")
				else
					toast ("Update requires re-download of image directory. Stand by...")
				end
				dofile(localPath .."updater.lua")
				--httpDownload("https://raw.githubusercontent.com/NonceCents/FFBEAutoZContinued/master/version.lua", localPath .."version.lua")
			end
			scriptExit("Press OK to exit, run script again to load new version.")
		end
	else
		toast("Unable to check for updates.")
		toast("Enable Network Functions in AnkuLua settings to allow update checks.")
	end
end

currentVersion = "0.0.0"
currentImageVersion = "0"
force_update = false
updateScript(currentVersion, currentImageVersion)





-- ===========Dialog=========== --
 
removePreference("spValueIndex")
dialogInit()
addTextView("Select mission what you want repeat")
newRow()
spinnerItems = {"Mission 1", "Mission 2", "Mission 3", "Mission 4", "Mission 5"}
addTextView("Select: ")
addSpinnerIndex("spValueIndex", spinnerItems, "Mission 5")

dialogShow("PostKnight by: Kryptor")

missionV = spValueIndex * 130
-- =============================== --


-- ===========Regions=========== --

str_reg = Region(46,963,59,66)
agi_reg = Region(203,961,44,68)
lobbyHp_reg = Region(197,897,84,53)
missionGo_reg = Region(505,655, 107, 55)
placa_reg = Region(302, 411, 68, 55)
route_reg = Region(79, 954, 256, 66)
hp_reg = Region(81,889,83,57)
level_reg = Region(92,830,57,46)
point_reg = Region(227,956,82,77)
endV1_reg = Region(308, 716, 84, 79)
loot_reg = Region(302, 841, 112, 54)
stage_reg = Region(132, 212, 149, 57)
exp_reg = Region(110, 520, 81, 63)
agi_reg = Region(206, 971, 73, 60)
endPlus_reg = Region(317, 714, 72, 86)
points_reg = Region(243, 367, 134, 48)
midPoint2_reg = Region(243, 974, 68, 66)
rest_reg = Region(225, 454, 118, 53)
fleur_reg = Region(312, 528, 73, 75)
merchant_reg = Region(304, 539, 85, 60)
magnolia1_reg = Region(313, 535, 63, 66)


-- ============================== --


-- ===========Location=========== --
go1 = Location(100,100)
go2 = Location(300,100)
mission5 = Location(320,170 + missionV )
placa = Location(350,450)
missionGo_click = Location(552,680)
skill1 = Location(170,1080)
skill2 = Location(360,1080)
skill3 = Location(550,1080)
endV2 = Location(430, 931)
endPlus_click = Location(360,770)
midx_click = Location(350,780)
skip1 = Location(350,780)
-- =============================== --

-- ===========Variaveis=========== --
st_mission = false
st_meio = 0
st_fim = 0
lobbyHp = Pattern("lobbyHp.png"):similar(0.7)
str = Pattern("str.png"):similar(0.6)
agi = Pattern("agi.png"):similar(0.5)
missionGo = Pattern("missionGo.png"):similar(0.9)
placa = Pattern("placa.png"):similar(0.6)
route = Pattern("route.png"):similar(0.8)
level = Pattern("level.png"):similar(0.6)
point = Pattern("point.png"):similar(0.9)
rest = Pattern("rest.png"):similar(0.7)
hp = Pattern("hp.png"):similar(0.6)
loot = Pattern("loot.png"):similar(0.7)
midPoint2 = Pattern("midPoint2.png"):similar(0.5)	
fleur = Pattern("fleur.png"):similar(0.6)
merchant = Pattern("merchant.png"):similar(0.6)
magnolia = Pattern("magnolia1.png"):similar(0.6)

-- =============================== --

function placa_()


if(placa_reg:exists(placa))then

click(placa)
if(route_reg:exists(route))then
click(mission5)
wait(5)

st_mission  = true
end
else
swipe(go1,go2)
end
end


function Skills_()
while(hp_reg:exists(hp)) do
click(skill1)
click(skill2)
click(skill3)
end
end

function fim_()
click(endPlus_click)
wait(2)
click(endV2)
wait(5)
st_mission = false
placa_()
end

function meio_()
click(skip1)
wait(0.5)
click(skip1)
wait(0.5)
if(rest_reg:exists(rest)) then
click(midx_click)
end
if(missionGo_reg:exists(missionGo)) then
click(missionGo)
wait(0.5)
Skills_()
end

end



while (true) do

if(st_mission == false) then

if(str_reg:exists(str) and agi_reg:exists(agi)) then
placa_()
end

else

if(loot_reg:exists(loot)) then
fim_()
end


if(hp_reg:exists(hp) and level_reg:exists(level)) then
Skills_()
end


if(rest_reg:exists(rest)) then
click(midx_click)
if(missionGo_reg:exists(missionGo)) then
click(missionGo)
wait(0.5)
click(missionGo_click)
end
end


if (midPoint2_reg:exists(midPoint2)) then
meio_()
end

if (fleur_reg:exists(fleur) or merchant_reg:exists(merchant) or magnolia1_reg:exists(magnolia)) then
 meio_()
end
end

end -- while end

 






