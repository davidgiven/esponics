local CYCLE_INTERVAL = 60000
local FOGGER_ON_TIME = 30000
local FAN_ON_TIME = 2000

local timer = tmr.create()
local t = tmr:create()
timer:register(CYCLE_INTERVAL, tmr.ALARM_AUTO,
    function()
        message(2, "Running fogger")
        fogger_on()
        fan_off()

        t:alarm(FOGGER_ON_TIME, tmr.ALARM_SINGLE,
            function()
                message(2, "Running fan")
                fogger_off()
                fan_on()

                t:alarm(FAN_ON_TIME, tmr.ALARM_SINGLE,
                    function()
                        message(2, "Mist waiting")
                        fogger_off()
                        fan_off()
                    end)
            end)
    end)

message(2, "Mist waiting")
timer:start()
