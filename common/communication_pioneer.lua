-- https://learnxinyminutes.com/docs/ru-ru/lua-ru/ ссылка для быстрого ознакомления с основами языка LUA

-- This script changes LEDs colors in a random manner

-- Simplification and caching table.unpack calls
local unpack = table.unpack
-- Base pcb number of RGB LEDs
local ledNumber = 4
-- RGB LED control port initialize
local leds = Ledbar.new(ledNumber)

-- Function changes color on all LEDs
local function changeColor(col)
    for i=0, ledNumber - 1, 1 do
        leds:set(i, unpack(col))
    end
end



-- инициализируем Uart интерфейс
local uartNum = 4 -- номер Uart интерфейса (USART4)
local baudRate = 9600 -- скорость передачи данных
local dataBits = 8
local stopBits = 1
local parity = Uart.PARITY_NONE
local uart = Uart.new(uartNum, baudRate, parity, stopBits) -- создание протокола обмена


-- таблица цветов в формате RGB для передачи в функцию changeColor
local colors = {
        {1, 0, 0}, -- красный
        {0, 1, 0}, -- зеленый
        {1, 1, 0}, -- желтый
        {1, 0, 1}, -- фиолетовый
        {0, 0, 1}, -- синий
        {1, 1, 1}, -- белый
        {0, 0, 0}  -- черный/отключение светодиодов
}

local N = 10
local i = 7
local strUnpack = string.unpack
function getData() -- функция приёма байта данных
   i = i + 1
   if (i == N + 1) then i = 0 end
   buf = uart:read(uart:bytesToRead()) or '0'
   if (#buf == 0) then buf = '\0' end
   leds:set(1, 0, i/N, 0.5 - 0.5*i/10)
   if (strUnpack ~= nil) then
       local b = strUnpack("B", buf)
       return b -- примерно должно так работать
   else
       return 1
   end
end


-- Functions that stops LEDs Timer and switches all LEDs to red
local function emergency()
end

-- Event processing function called automatically by autopilot
function callback(event)
    -- Calls emergency() when voltage on the battery drops below Flight_com_landingVol value
    if (event == Ev.LOW_VOLTAGE2) then
        emergency()
    end
    end

-- Creating timer, that changes each LED value to a random value every second
timerRandomLED = Timer.new(0.25, function ()
    changeColor(colors[getData()%6+1])
end)
-- Starting timer created above
timerRandomLED:start()
