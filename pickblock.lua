name = "Pick Block"
description = "allows u to pick block in survival"

event.listen("MouseInput", function(button, down)
    x, y, z = player.selectedPos()
    block = dimension.getBlock(x, y, z)
    if button == 3 and down then
        if player.facingBlock() and player.gamemode() == 0 then
            client.execute("execute /give @p ".. block.name .." 64 ".. block.data)
        end
    end
end)