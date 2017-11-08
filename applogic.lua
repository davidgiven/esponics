local CYCLE_INTERVAL = 60000
local FOGGER_ON_TIME = 30000

fan_on()

local timer = tmr.create()
local t = tmr:create()
timer:register(CYCLE_INTERVAL, tmr.ALARM_AUTO,
    function()
        message(2, "Running fogger")
        fogger_on()

        t:alarm(FOGGER_ON_TIME, tmr.ALARM_SINGLE,
            function()
                message(2, "Fogger off")
                fogger_off()
                fan_on()
            end)
    end)

message(2, "Waiting for startup")
timer:start()
