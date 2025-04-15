---@diagnostic disable: undefined-global=
if not turtle then
    error("not a turtle")
end

-- variables
local distance = 0
local direction = 0
local dug = 0
local maxDug = 0

-- names
local names = http.get("https://raw.githubusercontent.com/malyhob/turtlezz/refs/heads/main/names.json")
local name = names[math.random(50)]

os.setComputerLabel(name)

-- helper funcs

local function swivel()
    turtle.turnRight()
    turtle.turnRight()
    if direction == 0 then
        direction = 1
    else
        direction = 0
    end
end

local function dig(doDanceRoutine)
    turtle.dig()
    if doDanceRoutine == true then
        turtle.turnRight()
        turtle.dig()
        turtle.turnLeft()
        turtle.turnLeft()
        turtle.dig()
        turtle.turnRight()
    end
end

local function move(doDanceRoutine)
    dig(doDanceRoutine)
    turtle.digUp()
    turtle.up()
    dig(doDanceRoutine)
    turtle.down()

    turtle.forward()
end

local function forward(doDanceRoutine)
	move(doDanceRoutine)
	
	if direction == 0 then
		distance = distance + 1 
        dug = dug + 1
	else
		distance = distance - 1 
	end	
end

local function goHome()
    swivel()
    repeat
        forward(false)
    until distance == 0
    swivel()
end

local function isWorkOver()
    if turtle.getItemCount(16) > 0 or turtle.getFuelLevel() <= distance or dug > maxDug then
        return true
    end
    return false
end

-- actual fun
local function begin()
    repeat
        forward(true)
        write(distance)
    until isWorkOver() or direction == 1
    goHome()
    write("im done!!")
    swivel()
end

-- simple input
write("begin, limit [n]")
write("\n")
turtle.refuel(turtle.getItemCount())
while true do
    local inp = read()
    if inp == "begin" then
        begin()
    elseif string.sub(inp,1,5) == "limit" then
        local limit = tonumber(string.sub(inp,7))
        if limit then
            maxDug = limit
        end
    end
end