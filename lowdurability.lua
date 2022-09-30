name = "Low Durability Warning"
description = "Warns u if ur tool is about to break"

text = "Ayo ur item finna break"

function render(dt)
    font = gui.font()
    posX, posY = gui.width() / 2 - (font.width(text) / 2), gui.height() - 55
    local inventory = player.inventory()
    item = inventory.at(inventory.selected)
    if item ~= nil then 
        item = math.floor((item.durability / item.maxDamage) * 100)
        if item > 90 then
            gfx.color(0, 0, 0, 80)
            gfx.rect(posX - 2, posY - 2, font.width(text) + 4, font.height * 1 + 4)
            gfx.color(255, 255, 255)
            gfx.text(posX, posY, text)
        end
    end
end