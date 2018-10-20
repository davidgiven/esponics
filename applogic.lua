-- All in seconds
FOGGER_STARTUP = 30
FOGGER_PERIOD = 30*60
FOGGER_ON = 1*60

PUMP_STARTUP = 60
PUMP_PERIOD = 24*3600
PUMP_ON = 5*60

FAN_STARTUP = 15
FAN_PERIOD = 1*3600
FAN_ON = 3

TICK = 2

local function supertimer(startup, period, ontime, off_cb, on_cb)
    local wait_tmr = tmr.create()
    local seconds = startup
    local onoff = true

    wait_tmr:alarm(TICK*1000, tmr.ALARM_AUTO,
        function()
            seconds = seconds - TICK
            local cb = onoff and on_cb or off_cb
            cb(seconds)
            if (seconds <= 0) then
                if onoff then
                    onoff = false
                    seconds = seconds + (period - ontime)
                else
                    onoff = true
                    seconds = seconds + ontime
                end
            end
        end)
end

local function rendertime(s)
    local min = math.floor(s / 60)
    local hour = math.floor(min / 60)
    min = min % 60
    local sec = s % 60
    return hour.."h"..min.."m"..sec.."s"
end

supertimer(FOGGER_STARTUP, FOGGER_PERIOD, FOGGER_ON,
    function(s)
        message(2, "Fogger off: "..rendertime(s))
        fogger_off()
    end,
    function(s)
        message(2, "Fogger on:  "..rendertime(s))
        fogger_on()
    end)    

supertimer(PUMP_STARTUP, PUMP_PERIOD, PUMP_ON,
    function(s)
        message(3, "Pump off:   "..rendertime(s))
        pump_off()
    end,
    function(s)
        message(3, "Pump on:    "..rendertime(s))
        pump_on()
    end)    

supertimer(FAN_STARTUP, FAN_PERIOD, FAN_ON,
    function(s)
        message(4, "Fan off:    "..rendertime(s))
        fan_off()
    end,
    function(s)
        message(4, "Fan on:     "..rendertime(s))
        fan_on()
    end)    
