local fogger_wait = tmr.create()
local fogger_run = tmr.create()
message(2, "Fogger startup")
fogger_on()
fogger_wait:alarm(10*1000, tmr.ALARM_AUTO,
    function()
        fogger_wait:interval(60*1000)
        message(2, "Running fogger")
        fogger_on()

        fogger_run:alarm(5*1000, tmr.ALARM_SINGLE,
            function()
                message(2, "Fogger off")
                fogger_off()
            end)
    end)

local pump_wait = tmr.create()
local pump_run = tmr.create()
pump_on()
message(3, "Pump startup")
pump_wait:alarm(30*1000, tmr.ALARM_AUTO,
    function()
        pump_wait:interval(11*60*1000)
        message(3, "Running pump")
        pump_on()

        pump_run:alarm(2*1000, tmr.ALARM_SINGLE,
            function()
                message(3, "Pump off")
                pump_off()
            end)
    end)

local fan_wait = tmr.create()
local fan_run = tmr.create()
message(4, "Fan startup")
fan_on()
fan_wait:alarm(10*1000, tmr.ALARM_AUTO,
    function()
        fan_wait:interval(10*60*1000)
        message(4, "Running fan")
        fan_on()

        fan_run:alarm(4*1000, tmr.ALARM_SINGLE,
            function()
                message(4, "Fan off")
                fan_off()
            end)
    end)
