# tic-tac-toe
## Video Demo: https://youtu.be/-2nX8c8pRnE
#### Description:
This is my take on a simple Tic-Tac-Toe game! It's a two player game where each one takes turns marking the spaces in a three-by-three grid with either an X or an O. The player who succeeds in placing three of their marks in a horizontal, vertical or diagonal row is the winner.

This is my first project done all by myself, which makes it an important one. It's written in Lua using the Love2D framework. 

I have played games for more than a decade and I have always wanted to create games of my own. Before finishing this course, I also took a C# and Unity course on 2D game development. Right before starting my final project, I decided to take start the GD50 course, that talks about game development in Lua and LOVE framework. The classes have the same quality as CS50 and, right after submiting the second project on that course, I jumped right into the final project for CS50 and finished it in about a week. It's not much, but it's honest work!

Firstly, I decided to take a minimalist approach to this project. I made simple sprites for the X and O player, drew the grid with Love2D's draw function and wrote some simple UI messages to guide the user. Although a final project, I reckon I shouldn't spend the next month tweaking and polishing this, as it should be a learning moment, not a frustrating and minucious one. That said, I had a lot of fun and went through some difficult moments trying to figure out the algorithm to check for a win, or how to place the markers correctly.

So, i've got a folder for the font I used, a folder for all the sprites - there's about three sprites for each player, each sprite was made by different people so each single single one has its' own personality - and a folder that holds the states this game has: start state, where the game initializes; the play state, where the game loop belongs; the win state, that comes up when someone wins a game or there's a draw; and a base state, that holds the information that every state needs to have and from whom they inherit them. This state machine concept was taken from the GD50 courses. I thought of making a simple state machine using strings as the states, but it turned out smoother to do the states like single classes. Not only it makes me practice state machines a bit, it also compartmentalizes everything a bit more and all the code looks cleaner - plus, it's not hard to implement!.

On the project's root folder, there's a "class" file, that let's us use our states as classes. The "StateMachine", then, makes it possible to create and manage states.
The "conf" file holds some information for the window size and title.

My next steps are going to include the GD50 course and i'm definitely going to start building my own projects from now on. It has been a pleasure being part of the CS50 community and I have to thank David and all the crew behind the classes for this amazing experience.

That concludes my first readme file aswell! I hope you enjoy this little project of mine, thank you for reading this!