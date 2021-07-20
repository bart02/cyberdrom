-- количество светодиодов на основной плате пионера
local ledNumber = 4
-- создание порта управления светодиодами
local leds = Ledbar.new(ledNumber)
-- ассоциируем функцию распаковки таблиц из модуля table для упрощения
local unpack = table.unpack

-- переменная текущего состояния
local curr_state = "PREPARE_FLIGHT"

-- функция, изменяющая цвет 4-х RGB светодиодов на основной плате пионера
local function changeColor(color)
    -- проходим в цикле по всем светодиодам с 0 по 3
    for i=0, ledNumber - 1, 1 do
        leds:set(i, unpack(color))
    end
end
local magnet_state = false
local function toggleMagnet()
    if (magnet_state == true) then  -- Если магнит включен, то     выключаем его
        magnet:reset()
    else                            -- Если выключен, то включаем
        magnet:set()
    end
    magnet_state = not magnet_state -- Инвертируем переменную состояния
end




local pathBlue = {
	{0.1, 0.4,  0.5}, -- 1 2  
    { -0.1,  0.38,  0.5}, -- 4 2  --захват груза 1
    { -0.1,  0.38,  0.5},
    { -0.1,  0.38,  0.5},
    { -0.1,  0.38,  0.5},
    { -0.1,  0.38,  0.5},
    { -0.1,  0.38,  0.5},
    { -0.1,  0.38,  0.5},
    { -0.1,  0.38,  0.5},
    { -0.1,  0.38,  0.5},
    { -0.1,  0.38,  0.5}  -- возврат точка не определена???
}



-- коптер синий
action = {
    ["PREPARE_FLIGHT"] = function(x)
        Timer.callLater(2, function () ap.push(Ev.MCE_PREFLIGHT) end) -- через 2 секунды отправляем команду автопилоту на запуск моторов
        Timer.callLater(6, function ()
            ap.push(Ev.MCE_TAKEOFF) -- еще через 2 секунды (суммарно через 6 секунд) отправляем команду автопилоту на взлет
            curr_state = "FLIGHT_TO_FIRST_POINT_TARGET" -- переход в следующее состояние
        end)
    end,
    
    ["FLIGHT_TO_FIRST_POINT_TARGET"] = function (x)
        Timer.callLater(2, function ()
            ap.goToLocalPoint(unpack(pathBlue[1])) -- отправка команды автопилоту на полет к точке с координатами (0 м, 1 м, 1 м)
            curr_state = "FLIGHT_TO_FIRST_TARGET_LANDING" -- переход в следующее состояние
        end)
    end,

    ["FLIGHT_TO_FIRST_TARGET_LANDING"] = function (x)
        Timer.callLater(2, function ()
            ap.goToLocalPoint(unpack(pathBlue[2])) -- отправка команды автопилоту на полет к точке взлета (0 м, 0 м, 0.8 м)
            curr_state = "PIONEER_LANDING1" -- переход в следующее состояние
        end)
    end,


    ["PIONEER_LANDING1"] = function (x)
        Timer.callLater(2, function ()
            ap.push(Ev.MCE_LANDING) -- отправка команды автопилоту на посадку
            curr_state = "TAKE_TARGET1"
        end)
    end,

    ["TAKE_TARGET1"] = function (x)
        Timer.callLater(2, function ()
            toggleMagnet()
        	curr_state = "PREPARE_FLIGHT1"
        end)
    end,
    -- надо уменьшить время подготовки
    ["PREPARE_FLIGHT1"] = function(x)
        Timer.callLater(2, function () ap.push(Ev.MCE_PREFLIGHT) end) -- через 2 секунды отправляем команду автопилоту на запуск моторов
        Timer.callLater(6, function ()
            ap.push(Ev.MCE_TAKEOFF) -- еще через 2 секунды (суммарно через 6 секунд) отправляем команду автопилоту на взлет
            curr_state = "FLIGHT_TO_BLUE_POINT_TARGET1" -- переход в следующее состояние
        end)
    end,
    
    ["FLIGHT_TO_BLUE_POINT_TARGET1"] = function (x)
        Timer.callLater(2, function ()
            ap.goToLocalPoint(unpack(pathBlue[3])) -- отправка команды автопилоту на полет к точке с координатами (0 м, 1 м, 1 м)
            curr_state = "PIONEER_LANDING2" -- переход в следующее состояние
        end)
    end,

    ["PIONEER_LANDING2"] = function (x)
        Timer.callLater(2, function ()
            ap.push(Ev.MCE_LANDING) -- отправка команды автопилоту на посадку
            curr_state = "DROP1"
        end)
    end,

    ["DROP1"] = function (x)
        Timer.callLater(2, function ()
            toggleMagnet()
        	curr_state = "PREPARE_FLIGHT2"
        end)
    end,

   -- надо уменьшить время подготовки
    ["PREPARE_FLIGHT2"] = function(x)
        Timer.callLater(2, function () ap.push(Ev.MCE_PREFLIGHT) end) -- через 2 секунды отправляем команду автопилоту на запуск моторов
        Timer.callLater(6, function ()
            ap.push(Ev.MCE_TAKEOFF) -- еще через 2 секунды (суммарно через 6 секунд) отправляем команду автопилоту на взлет
            curr_state = "FLIGHT_TO_BLUE_POINT_TARGET2" -- переход в следующее состояние
        end)
    end,
    
    ["FLIGHT_TO_BLUE_POINT_TARGET2"] = function (x)
        Timer.callLater(2, function ()
            ap.goToLocalPoint(unpack(pathBlue[4])) -- отправка команды автопилоту на полет к точке с координатами (0 м, 1 м, 1 м)
            curr_state = "PIONEER_LANDING3" -- переход в следующее состояние
        end)
    end,

    ["PIONEER_LANDING3"] = function (x)
        Timer.callLater(2, function ()
            ap.push(Ev.MCE_LANDING) -- отправка команды автопилоту на посадку
            curr_state = "TAKE_TARGET2"
        end)
    end,

    ["TAKE_TARGET2"] = function (x)
        Timer.callLater(2, function ()
            toggleMagnet()
        	curr_state = "PREPARE_FLIGHT3"
        end)
    end,

    ["PREPARE_FLIGHT3"] = function(x)
        Timer.callLater(2, function () ap.push(Ev.MCE_PREFLIGHT) end) -- через 2 секунды отправляем команду автопилоту на запуск моторов
        Timer.callLater(6, function ()
            ap.push(Ev.MCE_TAKEOFF) -- еще через 2 секунды (суммарно через 6 секунд) отправляем команду автопилоту на взлет
            curr_state = "FLIGHT_TO_BLUE_POINT_TARGET3" -- переход в следующее состояние
        end)
    end,
    
    ["FLIGHT_TO_BLUE_POINT_TARGET3"] = function (x)
        Timer.callLater(2, function ()
            ap.goToLocalPoint(unpack(pathBlue[5])) -- отправка команды автопилоту на полет к точке с координатами (0 м, 1 м, 1 м)
            curr_state = "PIONEER_LANDING4" -- переход в следующее состояние
        end)
    end,

    ["PIONEER_LANDING4"] = function (x)
        Timer.callLater(2, function ()
            ap.push(Ev.MCE_LANDING) -- отправка команды автопилоту на посадку
            curr_state = "DROP2"
        end)
    end,

    ["DROP2"] = function (x)
        Timer.callLater(2, function ()
            toggleMagnet()
        	curr_state = "PREPARE_FLIGHT4"
        end)
    end,


    ["PREPARE_FLIGHT4"] = function(x)
        Timer.callLater(2, function () ap.push(Ev.MCE_PREFLIGHT) end) -- через 2 секунды отправляем команду автопилоту на запуск моторов
        Timer.callLater(6, function ()
            ap.push(Ev.MCE_TAKEOFF) -- еще через 2 секунды (суммарно через 6 секунд) отправляем команду автопилоту на взлет
            curr_state = "FLIGHT_TO_BLUE_POINT_TARGET4" -- переход в следующее состояние
        end)
    end,

    ["FLIGHT_TO_BLUE_POINT_TARGET4"] = function (x)
        Timer.callLater(2, function ()
            ap.goToLocalPoint(unpack(pathBlue[6])) -- отправка команды автопилоту на полет к точке с координатами (0 м, 1 м, 1 м)
            curr_state = "PIONEER_LANDING5" -- переход в следующее состояние
        end)
    end,

    ["PIONEER_LANDING5"] = function (x)
        Timer.callLater(2, function ()
            ap.push(Ev.MCE_LANDING) -- отправка команды автопилоту на посадку
            curr_state = "TAKE_TARGET3"
        end)
    end,

    ["TAKE_TARGET3"] = function (x)
        Timer.callLater(2, function ()
            toggleMagnet()
        	curr_state = "PREPARE_FLIGHT5"
        end)
    end,

    ["PREPARE_FLIGHT5"] = function(x)
        Timer.callLater(2, function () ap.push(Ev.MCE_PREFLIGHT) end) -- через 2 секунды отправляем команду автопилоту на запуск моторов
        Timer.callLater(6, function ()
            ap.push(Ev.MCE_TAKEOFF) -- еще через 2 секунды (суммарно через 6 секунд) отправляем команду автопилоту на взлет
            curr_state = "FLIGHT_TO_BLUE_POINT_TARGET5" -- переход в следующее состояние
        end)
    end,

    ["FLIGHT_TO_BLUE_POINT_TARGET5"] = function (x)
        Timer.callLater(2, function ()
            ap.goToLocalPoint(unpack(pathBlue[7])) -- отправка команды автопилоту на полет к точке с координатами (0 м, 1 м, 1 м)
            curr_state = "PIONEER_LANDING6" -- переход в следующее состояние
        end)
    end,

    ["PIONEER_LANDING6"] = function (x)
        Timer.callLater(2, function ()
            ap.push(Ev.MCE_LANDING) -- отправка команды автопилоту на посадку
            curr_state = "DROP3"
        end)
    end,

    ["DROP3"] = function (x)
        Timer.callLater(2, function ()
            toggleMagnet()
        	curr_state = "PREPARE_FLIGHT6"
        end)
    end,

    ["PREPARE_FLIGHT6"] = function(x)
        Timer.callLater(2, function () ap.push(Ev.MCE_PREFLIGHT) end) -- через 2 секунды отправляем команду автопилоту на запуск моторов
        Timer.callLater(6, function ()
            ap.push(Ev.MCE_TAKEOFF) -- еще через 2 секунды (суммарно через 6 секунд) отправляем команду автопилоту на взлет
            curr_state = "FLIGHT_TO_BLUE_POINT_TARGET6" -- переход в следующее состояние
        end)
    end,

    ["FLIGHT_TO_BLUE_POINT_TARGET6"] = function (x)
        Timer.callLater(2, function ()
            ap.goToLocalPoint(unpack(pathBlue[8])) -- отправка команды автопилоту на полет к точке с координатами (0 м, 1 м, 1 м)
            curr_state = "PIONEER_LANDING7" -- переход в следующее состояние
        end)
    end,

    ["PIONEER_LANDING7"] = function (x)
        Timer.callLater(2, function ()
            ap.push(Ev.MCE_LANDING) -- отправка команды автопилоту на посадку
            curr_state = "TAKE_TARGET3"
        end)
    end,

    ["TAKE_TARGET3"] = function (x)
        Timer.callLater(2, function ()
            toggleMagnet()
        	curr_state = "PREPARE_FLIGHT7"
        end)
    end,

    ["PREPARE_FLIGHT7"] = function(x)
        Timer.callLater(2, function () ap.push(Ev.MCE_PREFLIGHT) end) -- через 2 секунды отправляем команду автопилоту на запуск моторов
        Timer.callLater(6, function ()
            ap.push(Ev.MCE_TAKEOFF) -- еще через 2 секунды (суммарно через 6 секунд) отправляем команду автопилоту на взлет
            curr_state = "FLIGHT_TO_BLUE_POINT_TARGET7" -- переход в следующее состояние
        end)
    end,

    ["FLIGHT_TO_BLUE_POINT_TARGET7"] = function (x)
        Timer.callLater(2, function ()
            ap.goToLocalPoint(unpack(pathBlue[9])) -- отправка команды автопилоту на полет к точке с координатами (0 м, 1 м, 1 м)
            curr_state = "PIONEER_LANDING8" -- переход в следующее состояние
        end)
    end,

    ["PIONEER_LANDING8"] = function (x)
        Timer.callLater(2, function ()
            ap.push(Ev.MCE_LANDING) -- отправка команды автопилоту на посадку
            curr_state = "DROP4"
        end)
    end,

	["DROP4"] = function (x)
        Timer.callLater(2, function ()
            toggleMagnet()
        	curr_state = "PREPARE_FLIGHT8"
        end)
    end,

    ["PREPARE_FLIGHT8"] = function(x)
        Timer.callLater(2, function () ap.push(Ev.MCE_PREFLIGHT) end) -- через 2 секунды отправляем команду автопилоту на запуск моторов
        Timer.callLater(6, function ()
            ap.push(Ev.MCE_TAKEOFF) -- еще через 2 секунды (суммарно через 6 секунд) отправляем команду автопилоту на взлет
            curr_state = "FLIGHT_TO_BLUE_POINT_TARGET8-- переход в следующее состояние
        end)
    end,

    ["FLIGHT_TO_BLUE_POINT_TARGET8"] = function (x)
        Timer.callLater(2, function ()
            ap.goToLocalPoint(unpack(pathBlue[10])) -- отправка команды автопилоту на полет к точке с координатами (0 м, 1 м, 1 м)
            curr_state = "FINISH" -- переход в следующее состояние
        end)
    end,


    ["FINISH"] = function (x)
        Timer.callLater(2, function ()
            curr_state = "FINISH"
        end)
    end
}

-- функция обработки событий, автоматически вызывается автопилотом
function callback(event)
    -- если достигнута необходимая высота, то выполняем функцию из таблицы, соответствующую текущему состоянию
    if (event == Ev.TAKEOFF_COMPLETE) then
        action[curr_state]()
    end
    -- если пионер с чем-то столкнулся, то зажигаем светодиоды красным
    if (event == Ev.SHOCK) then
        changeColor(colors[1])

    end
    -- если пионер достигнул точки, то выполняем функцию из таблицы, соответствующую текущему состоянию
    if (event == Ev.POINT_REACHED) then
        action[curr_state]()
    end

    -- если пионер приземлился, то выключаем светодиоды
    if (event == Ev.COPTER_LANDED) then
        action[curr_state]()
    end

end

-- включаем светодиод (красный цвет)
changeColor(colors[1])
-- запускаем одноразовый таймер на 2 секунды, а когда он закончится, выполняем первую функцию из таблицы (подготовка к полету)
Timer.callLater(2, function () action[curr_state]() end)