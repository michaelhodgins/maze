DEG = Math.PI / 180 # 1 deg is pi/180 radians

#Some browsers have the requestAnimationFrame function, but give it an experiment prefix.
window.requestAnimationFrame = window.requestAnimationFrame or window.mozRequestAnimationFrame or window.webkitRequestAnimationFrame or window.msRequestAnimationFrame

#get the game canvas
canvas = $('#maze')[0]

#make the game
game = new Maze canvas
game.setMap new Map()
game.setCamera new Camera()


#start the game
game.start()

#make sure that the game has focus so that the player doesn't have to click on it.
canvas.focus()
