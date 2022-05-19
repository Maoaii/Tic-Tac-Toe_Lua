-- the "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods
--
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'class'

-- a basic StateMachine class which will allow us to transition to and from
-- game states smoothly and avoid monolithic code in one file
require 'StateMachine'

-- all states our StateMachine can transition between
require 'states/BaseState'
require 'states/StartState'
require 'states/PlayState'
require 'states/WinState'


function love.load()
    -- initialize our nearest-neighbor filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- seed the random function
    math.randomseed(os.time())

    -- initialize our nice-looking retro text fonts
    smallFont = love.graphics.newFont('fonts/font.ttf', 8)
    mediumFont = love.graphics.newFont('fonts/font.ttf', 14)
    hugeFont = love.graphics.newFont('fonts/font.ttf', 40)
    love.graphics.setFont(hugeFont)

    -- set background color
    love.graphics.setBackgroundColor(30/255, 30/255, 30/255)

    -- initialize state machine with all state-returning functions
    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        ['win'] = function() return WinState() end,
    }
    gStateMachine:change('start')
    
    
    -- initialize input table
    love.keyboard.keysPressed = {}


    -- initialize mouse input table
    love.mouse.buttonsPressed = {}
end


function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

--[[
    LÖVE2D callback fired each time a mouse button is pressed; gives us the
    X and Y of the mouse, as well as the button in question.
]]
function love.mousepressed(x, y, button)
    love.mouse.buttonsPressed[button] = true
end

--[[
    Custom function to extend LÖVE's input handling; returns whether a given
    key was set to true in our input table this frame.
]]
function love.keyboard.wasPressed(key)
	return love.keyboard.keysPressed[key]
end


--[[
    Equivalent to our keyboard function from before, but for the mouse buttons.
]]
function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end


function love.update(dt)

    gStateMachine:update(dt)

    -- clean up tables for the next frame
    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

function love.draw()
    gStateMachine:render()
end

