---@diagnostic disable: undefined-global=
if not turtle then
    error("not a turtle")
end

-- variables
local distance = 0
local direction = 0
local dug = 0

-- say

local chatBox = peripheral.find("chatbox")

function say(message)
	print(message)
	
	if chatBox then
		pcall(chatBox.say, message)
	end
end

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

local function move(moveFunc, digFunc, attackFunc)
    local failCount = 0
    
    digFunc()
    
    while not moveFunc() do
        digFunc()
        sleep(0.25)
        
        failCount = failCount + 1
        
        if failCount == 100 then
            say("Unable to move")
        end
    end
end

local function forward()
	move(turtle.forward, turtle.dig)
	
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
    if turtle.getItemCount(16) > 0 or turtle.getFuelLevel() < 5 then
        return true
    end
    return false
end

-- actual fun
local function begin()
    repeat
        forward()
        say(distance)
    until isWorkOver() or direction == 1
    goHome()
    say("im done!!")
    swivel()
end

-- simple input
write("begin, goHome\n")
while true do
    local inp = read()
    if inp == "begin" then
        begin()
    elseif inp == "goHome" then
        goHome()
    end
end