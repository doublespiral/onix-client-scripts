name = "Particle Trail"
description = "gives you a costumizable trail of render 3d blocks"

--[[
    spaghetti'd by helix
    i stole code from mcbe craft lol (thank)
]]

--super secret settings below
particleSize = 0.1 --size of part (default: 0.1)
length = 1 -- determins in sec when list should be cleared (default: 1) [has to be whole number]

client.settings.addAir(8)
color = {255, 255, 255, 100}
client.settings.addColor("Particle color", "color")

a = math.floor(os.clock())
startRemove = false

b = a + length
function update(dt)
    if startRemove == false then
        a = math.floor(os.clock())
        if a == b then
            startRemove = true
        end
    end
end

importLib("renderthreeD.lua")

particlePos = {}
function render3d(dt)
    if player.perspective() ~= 0 then
        x, y, z = player.pposition()
    else
        x, y, z = gfx.origin()
    end
    gfx.color(color.r, color.g, color.b, color.a)
    table.insert(particlePos, {x-0.05, y-1.6, z-0.05})
    for i, value in ipairs(particlePos) do
        cube(value[1], value[2], value[3], particleSize)
    end
    if startRemove == true then
        table.remove(particlePos, 1)
    end
end

--yo waddup