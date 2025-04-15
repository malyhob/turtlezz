---@diagnostic disable: undefined-global=
if not turtle then
    error("not a turtle")
end

-- variables
local distance = 0
local direction = 0
local dug = 0

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

local function dig()
    turtle.dig()
    turtle.turnRight()
    turtle.dig()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.dig()
    turtle.turnRight()
end

local function move()
    dig()
    turtle.digUp()
    turtle.up()
    dig()
    turtle.down()

    turtle.forward()
end

local function forward()
	move()
	
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
        forward()
    until distance == 0
    swivel()
end

local function isWorkOver()
    if turtle.getItemCount(16) > 0 or turtle.getFuelLevel() <= distance then
        return true
    end
    return false
end

-- actual fun
local function begin()
    repeat
        forward()
        write(distance)
    until isWorkOver() or direction == 1
    goHome()
    write("im done!!")
    swivel()
end

-- simple input
write("begin, goHome")
write("\n")
turtle.refuel(turtle.getItemCount())
while true do
    local inp = read()
    if inp == "begin" then
        begin()
    elseif inp == "goHome" then
        goHome()
    end
end