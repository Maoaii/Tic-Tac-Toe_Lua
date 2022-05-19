PlayState = Class{__includes = BaseState}



function PlayState:init()
    -- initialize table with different sprites
    xSquares = {
        love.graphics.newImage("sprites/x_square1.png"),
        love.graphics.newImage("sprites/x_square2.png"),
        love.graphics.newImage("sprites/x_square3.png")
    }

    oSquares = {
        love.graphics.newImage("sprites/o_square1.png"),
        love.graphics.newImage("sprites/o_square2.png"),
        love.graphics.newImage("sprites/o_square3.png")
    }
    
    -- assign a random sprite to the players
    xSquare = xSquares[math.random(1, #xSquares)]
    oSquare = oSquares[math.random(1, #oSquares)]

    -- to keep track of whose turn it is
    xTurn = true
    -- keep track if game ended
    gameOver = false
    -- to track how many turns have passed
    turn = 1
    -- to keep track of who won
    gWhoWon = ""

    -- board
    board = {
        {"", "", ""},
        {"", "", ""},
        {"", "", ""}
    }
end


function PlayState:update(dt)
    -- transition to win state when someone wins or there's a draw
    if gameOver then
        gStateMachine:change('win')
    end

    -- if there is a left mouse click, insert an "x" or an "o" on that square
    if love.mouse.wasPressed(1) then
        -- get mouse position
        xPos = love.mouse.getX()
        yPos = love.mouse.getY()
        
        -- iterate through the board
        for yAxis = 1, 3 do
            for xAxis = 1, 3 do
                -- if mouse click was inside a square and it is empty
                if isInsideSquare(xPos, yPos, xAxis, yAxis) and isEmpty(xAxis, yAxis) then
                    -- put an "x" on the square
                    if xTurn then
                        board[xAxis][yAxis] = 'x'
                        checkWin(xAxis, yAxis, 'x')  -- check if this move makes a win
                        xTurn = false
                    -- put an "o" on the square
                    else
                        board[xAxis][yAxis] = 'o'
                        checkWin(xAxis, yAxis, 'o')  -- check if this move makes a win
                        xTurn = true
                    end
                    turn = turn + 1
                end
            end
        end
    end
end

--[[
    Function that checks if there is a win whenever a play is made
]]
function checkWin(xAxis, yAxis, player)
    -- check if there is a win on the column
    for y = 1, 3 do
        if board[xAxis][y] ~= player then
            break
        end
        if y == 3 then
            gWhoWon = player
            gameOver = true
        end
    end


    -- check if there is a win on the row
    for x = 1, 3 do
        if board[x][yAxis] ~= player then
            break
        end
        if x == 3 then
            gWhoWon = player
            gameOver = true
        end
    end


    --[[
        Check diagonals. Check both diagonals and see if there is a win (can make this more efficient, only looking at 
        diagonals that matter).
    ]]
    -- first diag
    for d = 1, 3 do
        if board[d][d] ~= player then
            break
        end
        if d == 3 then
            gWhoWon = player
            gameOver = true
         end
    end        

    -- anti diag
    for d = 1, 3 do
        if board[d][4-d] ~= player then
            break
        end
        if d == 3 then
            gWhoWon = player
            gameOver = true
        end
    end


    -- there's a draw
    if turn == 9 then
        gameOver = true
    end
    
end


--[[
    Function that checks wheter the mouse click was inside a square on the board.
    Returns true if it was.
]]
function isInsideSquare(mouseX, mouseY, xAxis, yAxis)
    local screenWidth = love.graphics:getWidth()
    local screenHeight = love.graphics:getHeight() - 140

    return mouseX >= (yAxis-1)*screenWidth/3 and mouseX < yAxis*screenWidth/3 and 
           mouseY >= (xAxis-1)*screenHeight/3 and mouseY < xAxis*screenHeight/3
end

--[[
    Return true if a certain square is empty
]]
function isEmpty(xAxis, yAxis)
    return board[xAxis][yAxis] == ""
end


function PlayState:render()
    -- draw the board
    drawBoard()

    -- UI messages
    if xTurn then
        love.graphics.printf("X's turn", 0, love.graphics:getHeight() - 100, love.graphics:getWidth(), 'center')
    else
        love.graphics.printf("O's turn", 0, love.graphics:getHeight() - 100, love.graphics:getWidth(), 'center')
    end
end

--[[
    Function that draws the grid of a Tic-Tac-Toe game.
    Two vertical lines and two horizontal lines dividing the screen in 9 equal squares.

]]
function drawBoard()
    local screenWidth = love.graphics:getWidth()
    local screenHeight = love.graphics:getHeight() - 140

    -- draw a 3x3 board
    for i=1, 2 do
        -- vertical lines
        love.graphics.line(screenWidth*i/3, 0, screenWidth*i/3, screenHeight)
        -- horizontal lines
        love.graphics.line(0, screenHeight*i/3, screenWidth, screenHeight*i/3)
    end

    -- draw the x's and o's on the board
    for yAxis = 0, 2 do
        for xAxis = 0, 2 do
            tile = board[xAxis+1][yAxis+1]
            -- check board and draw blank, o, or x squares
            if tile == "x" then
                love.graphics.draw(xSquare, (yAxis*1.13 * xSquare:getWidth()), (xAxis*1.13 * xSquare:getHeight()))
            elseif tile == "o" then
                love.graphics.draw(oSquare, (yAxis*1.13 * oSquare:getWidth()), (xAxis*1.13 * oSquare:getHeight()))
            end 
        end
    end
end