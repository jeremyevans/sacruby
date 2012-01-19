!SLIDE center

# Quinto
.notes Quinto is an old 3M board game that was released in the mid 1960's.  There's not a lot of information about it online.  I only know about it because I came across it in a thrift store and bought it for a few dollars.  The simplest description of it is it is Scrabble with numbers and sums instead of letters and words.

!SLIDE center
.notes Quinto is played on a 17x17 square board.

# Board

!SLIDE center
.notes Each game is played with 90 tiles, with values on the tiles from 1 to 10.

# Tiles

!SLIDE center
.notes There are only a few rules in Quinto.

# Rules

!SLIDE center
.notes The main rule is that each horizontal or vertical consecutive run of tiles must have the sum of the tiles equal a multiple of 5.

# Sum to Multiple of 5

!SLIDE center
.notes The secondary rule is that no more than 5 tiles may be placed consecutively.

# No More Than 5 Consecutive Tiles

!SLIDE center
.notes The first move must include a tile in the center square.

# First Player Must Play in Center Square

!SLIDE center
.notes All following moves must include a tile that is played adjacent to an existing tile.

# All Following Moves Must Have a Tile Adjacent to an Existing Tile

!SLIDE center
.notes At any point, you can pass instead of making a move.

# Passing

!SLIDE center
.notes Scoring is like Scrabble, in that you add the sums of all runs you have made or extended.

# Scoring

!SLIDE center
.notes The game ends when there are no remaining tiles and one player is out of tiles in their rack.

# End Game

!SLIDE center
.notes Let's try a quick demo

# Demo

!SLIDE center
.notes The app is designed with 4 main parts: game logic, server logic, persistence logic, and client logic, all pure coffeescript files

# Design

!SLIDE center
.notes I originally started developing the game as a command line program, so I worked on the game logic first.

# quinto.coffee - Game Logic

!SLIDE center
.notes My main design choice was to model the game as a sequence of states, with the last state being the current state of the game.  This makes it so you don't have to worry about overwriting any information, on a move or pass, you just append the new state to the list of game states.

# Main Datastructure - GameState

!SLIDE center
.notes The server logic is just a bunch of routes that you can get or post to, and it's not very interesting.  It's mostly gluing the game logic to the persistence logic and running commands based on user input.

# app.coffee - Server Logic

!SLIDE center
.notes I'm planning to enable multiple persistence schemes.  I chose to do the simplest first, which is a simple directory tree of JSON files.  PostgreSQL support is planned next, to make it easy to host on Heroku.

# persist\_json.coffee - Persistence Logic

!SLIDE center
.notes All client logic is in client.coffee.  Quinto is designed as a single-page application.  When the server starts up, it precompiles the quinto.coffee and client.coffee files into a single javascript file which is referenced in the index.html page.

# client.coffee - Client Logic

!SLIDE center
.notes As you saw in the demo, signup uses a password.  We are using bcrypt password hashing, which is much more secure than using a standard cryptographic hash like sha1.  

# Password Security - bcrypt

!SLIDE center
.notes What probably wasn't obvious in the demo is that we are not using sessions or cookies.  After logging in, each user is provided an API token, which they must send with all requests.  Currently, the token is per user, but it could easily be made per user and per game later.  This basically eliminates CSRF attacks.

# Request Security - API tokens

!SLIDE center
.notes Other than the initial html page, all server responses are a JSON array.  Each entry in the array is an object with an action entry, describing the action to take.  The client just does a loop over this array, with each action calling a method.

# Data Transfer - JSON

!SLIDE center
.notes Currently, the client does simple old fashioned polling every 10 seconds for new data if it is not their turn.  That could be switched to long polling or websockets in the future.

# Event Handling - Polling

!SLIDE center
.notes Most of the action handler methods just use standard JQuery for the DOM updates, though JQueryUI is also used for drag-drop.

# DOM Updates - JQuery

!SLIDE center
.notes Any questions about Quinto before I move on?

# Questions 
