-- inherit atributes from 'BaseState'
StartState = Class{__includes = BaseState}

function StartState:update(dt)
    -- transition to play state when 'enter' pressed
    if love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end


function StartState:render()
    -- simple UI code
    love.graphics.printf('Press ENTER to start', 0, love.graphics:getHeight()/2 - 20, love.graphics:getWidth(), 'center')
end