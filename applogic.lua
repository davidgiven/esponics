-- All in seconds
FOGGER_STARTUP = 30
FOGGER_PERIOD = 3*60
FOGGER_ON = 5

PUMP_STARTUP = 10
PUMP_PERIOD = 30*60
PUMP_ON = 1*60

FAN_STARTUP = 15
FAN_PERIOD = 60*60
FAN_ON = 3

local fogger_wait = tmr.create()
local fogger_run = tmr.create()
message(2, "Fogger startup")
fogger_on()
fogger_wait:alarm(FOGGER_STARTUP*1000, tmr.ALARM_AUTO,
    function()
        fogger_wait:interval(FOGGER_PERIOD*1000)
        message(2, "Running fogger")
        fogger_on()

        fogger_run:alarm(FOGGER_ON*1000, tmr.ALARM_SINGLE,
            function()
                message(2, "Fogger off")
                fogger_off()
            end)
    end)

local pump_wait = tmr.create()
local pump_run = tmr.create()
pump_on()
message(3, "Pump startup")
pump_wait:alarm(PUMP_STARTUP*1000, tmr.ALARM_AUTO,
    function()
        pump_wait:interval(PUMP_PERIOD*1000)
        message(3, "Running pump")
        pump_on()

        pump_run:alarm(PUMP_ON*1000, tmr.ALARM_SINGLE,
            function()
                message(3, "Pump off")
                pump_off()
            end)
    end)

local fan_wait = tmr.create()
local fan_run = tmr.create()
message(4, "Fan startup")
fan_on()
fan_wait:alarm(FAN_STARTUP*1000, tmr.ALARM_AUTO,
    function()
        fan_wait:interval(FAN_PERIOD*1000)
        message(4, "Running fan")
        fan_on()

        fan_run:alarm(FAN_ON*1000, tmr.ALARM_SINGLE,
            function()
                message(4, "Fan off")
                fan_off()
            end)
    end)
