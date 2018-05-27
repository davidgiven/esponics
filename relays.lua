gpio.mode(6, gpio.OUTPUT, gpio.FLOAT)
gpio.mode(7, gpio.OUTPUT, gpio.FLOAT)
gpio.mode(8, gpio.OUTPUT, gpio.FLOAT)
gpio.write(6, 1)
gpio.write(7, 1)
gpio.write(8, 1)

function fogger_onoff(state)
    gpio.write(8, state)
end

function fan_onoff(state)
    gpio.write(7, state)
end

function pump_onoff(state)
    gpio.write(6, state)
end

function fogger_on()  fogger_onoff(1) end
function fogger_off() fogger_onoff(0) end
function fan_on()     fan_onoff(1) end
function fan_off()    fan_onoff(0) end
function pump_on()    pump_onoff(1) end
function pump_off()   pump_onoff(0) end

fogger_off()
fan_off()
pump_off()
