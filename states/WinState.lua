WinState = Class{__includes = BaseState}

function WinState:update(dt)
    -- do another game if the user presses enter
    if love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function WinState:render()
    -- still draw the board
    drawBoard()

    -- if there was no winner
    if gWhoWon == "" then
        love.graphics.printf("It's a draw!", 0, love.graphics:getHeight() - 100, love.graphics:getWidth(), 'center')
    else
        love.graphics.printf("Winner: " ..gWhoWon, 0, love.graphics:getHeight() - 100, love.graphics:getWidth(), 'center')
    end

    love.graphics.setFont(mediumFont)
    love.graphics.printf("Press Enter to play again!", 0, love.graphics:getHeight() - 40, love.graphics:getWidth(), 'center')
    love.graphics.setFont(hugeFont)
end