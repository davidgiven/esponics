i2c.setup(0, 1, 2, i2c.SLOW)
local disp = u8g.sh1106_128x64_i2c(0x3c)

local screen = {}

local dirty = false
local redrawing = false

local redraw_cb
local start_redrawing_cb

start_redrawing_cb = function()
    print("redraw cycle")
    redrawing = true
    dirty = false
    disp:firstPage()
    node.task.post(redraw_cb)
end

redraw_cb = function()
    if not screencopy then
        screencopy = screen
    end
    
    disp:setFont(u8g.font_6x10)
    disp:setFontPosTop()
    for i = 1, 6 do
        disp:drawStr180(127, (7-i)*10, screen[i] or "")
    end
    
    if disp:nextPage() then
        node.task.post(redraw_cb)
    else
        if dirty then
            print("redrawing again due to dirty screen")
            start_redrawing_cb()
        else
            redrawing = false
        end
    end
end
    
local function redraw()
    if dirty then
        return
    end

    if redrawing then
        dirty = true
    else
        node.task.post(start_redrawing_cb)
    end
end

function message(line, msg)
    print(line, msg)
    screen[line] = msg
    redraw()
end
