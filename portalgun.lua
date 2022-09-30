name = "Portalgun script"
description = "Use an empty crossbow to shoot portals"

--[[
    made by helix
    
    TO DO LIST 
    -debloat
    -camera rotation (in the tp command), it will look so cool
    -the indicators u can see through walls (ez)
]]

function update(dt) --determins if the crossbow is held
    local inventory = player.inventory()
    local selected = inventory.at(inventory.selected)
    if ((selected ~= nil and (selected.id == 575))) then
        bowHeld = true
    else
        bowHeld = false
    end
    --print(player.selectedFace())
    --print(player.rotation())
end

fillBlue, fillOrange = 1, 1 --goes up to 3
bluePortal, orangePortal = false, false

event.listen("MouseInput", function(button, down)
    if bowHeld then
        if button == 1 and down then
            bluePortal = true
            fillBlue = 3
        elseif button == 2 and down then
            fillOrange = 3
            orangePortal = true
        else
            bluePortal, orangePortal = false, false
        end
    end
end)

function render(dt)
    local guiX, guiY = gui.width() / 2, gui.height() / 2
    if bowHeld then --renders the crosshair (not using an image rosie)
        gfx.color(0,105,209)
        gfx.drawRect(guiX - 10, guiY - 11, 5, 15, fillBlue)
        gfx.drawRect(guiX - 10, guiY - 11, 10, 5, fillBlue)
        gfx.color(232,131,0)
        gfx.drawRect(guiX + 3, guiY - 5, 5, 15, fillOrange)
        gfx.drawRect(guiX - 2, guiY + 5, 10, 5, fillOrange)
    end
end

--beware, spaghetti after this point

portalCords = {0,0,0,0,0,0,0,0,0,0,0,0}
portalX, portalY, portalZ = 0, 0, 0
blockFace = 0
bool = 0

function portalRot() --does a bunch of stuff 
    blockFace = player.selectedFace()
    --local yaw = player.rotation()
    portalX, portalY, portalZ = player.selectedPos()
    portalY = portalY - 1
    portalCords[1 + bool] = portalX
    portalCords[2 + bool] = portalY
    portalCords[3 + bool] = portalZ
    if blockFace == 1 then
        portalCords[2 + bool] = portalY + 2
        portalCords[4 + bool] = 2
        portalCords[5 + bool] = 0.1
        portalCords[6 + bool] = 1
    elseif blockFace == 2 then
        portalCords[3 + bool] = portalZ - 0.1
        portalCords[4 + bool] = 1
        portalCords[5 + bool] = 2
        portalCords[6 + bool] = 0.1
    elseif blockFace == 3 then
        portalCords[3 + bool] = portalZ + 1
        portalCords[4 + bool] = 1
        portalCords[5 + bool] = 2
        portalCords[6 + bool] = 0.1
    elseif blockFace == 4 then
        portalCords[1 + bool] = portalX - 0.1
        portalCords[4 + bool] = 0.1
        portalCords[5 + bool] = 2
        portalCords[6 + bool] = 1
    elseif blockFace == 5 then
        portalCords[1 + bool] = portalX + 1
        portalCords[4 + bool] = 0.1
        portalCords[5 + bool] = 2
        portalCords[6 + bool] = 1
    elseif blockFace == 0 and portalX ~= 0 and portalY ~= 0 and portalZ ~= 0 then
        portalCords[2 + bool] = portalY + 0.9
        portalCords[4 + bool] = 2
        portalCords[5 + bool] = 0.1
        portalCords[6 + bool] = 1
    end
end

x, y, z = 0, 0, 0
importLib("renderthreeD.lua")

function render3d(dt)
    if bluePortal then
        bool = 0
        portalRot()
    end
    gfx.color(30,144,255)
    cubexyz(portalCords[1], portalCords[2], portalCords[3], portalCords[4], portalCords[5], portalCords[6])
    if orangePortal then
        bool = 6
        portalRot()
    end
    gfx.color(255,140,0)
    cubexyz(portalCords[7], portalCords[8], portalCords[9], portalCords[10], portalCords[11], portalCords[12])

    local x, y, z = player.position()
    if x == portalCords[1] and y == portalCords[2] and z == portalCords[3] then
        client.execute("execute /tp @p ".. portalCords[7] .." ".. portalCords[8] + 1 .. " " .. portalCords[9])
    elseif x == portalCords[7] and y == portalCords[8] and z == portalCords[9] then 
        client.execute("execute /tp @p ".. portalCords[1] .." ".. portalCords[2] + 1 .. " " .. portalCords[3])
    end
end