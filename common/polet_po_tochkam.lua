-- https://learnxinyminutes.com/docs/ru-ru/lua-ru/ ссылка для быстрого ознакомления с основами языка LUA
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

local points = {
    {0,1,0.8},
    {1,1,0.8},
    {1,-1,0.8},
    {-1,-1,0.8},
    {-1,1,0.8},
    {0,1,0.8},
    {0,0,0.8}
}

local curPoint = 1
local curColor = 1
local function nextPoint()
    curColor = (curPoint-1)%(#colors-2)+1
    changeColor(colors[curColor])
    if curPoint <= #points then
        Timer.callLater(2, function ()
            ap.goToLocalPoint(unpack(points[curPoint]))
            curPoint = curPoint + 1 
        end)
        
    else
        changeColor(colors[6]) -- смена цвета светодиодов на белый
        Timer.callLater(2, function ()
            ap.push(Ev.MCE_LANDING) -- отправка команды автопилоту на посадку
        end)
    end
end

-- функция обработки событий, автоматически вызывается автопилотом
function callback(event)
    -- если достигнута необходимая высота, то выполняем функцию из таблицы, соответствующую текущему состоянию
    if (event == Ev.TAKEOFF_COMPLETE) then
        changeColor(colors[5])
        nextPoint()
    end
    -- если пионер с чем-то столкнулся, то зажигаем светодиоды красным
    if (event == Ev.SHOCK) then
        changeColor(colors[1])

    end
    -- если пионер достигнул точки, то выполняем функцию из таблицы, соответствующую текущему состоянию
    if (event == Ev.POINT_REACHED) then
        nextPoint()
    end

    -- если пионер приземлился, то выключаем светодиоды
    if (event == Ev.COPTER_LANDED) then
        changeColor(colors[7])
    end

end

changeColor(colors[6]) -- смена цвета светодиодов на белый
Timer.callLater(2, function () ap.push(Ev.MCE_PREFLIGHT) end) -- через 2 секунды отправляем команду автопилоту на запуск моторов
Timer.callLater(4, function () ap.push(Ev.MCE_TAKEOFF) end) -- еще через 2 секунды (суммарно через 4 секундs) отправляем команду автопилоту на взлет
