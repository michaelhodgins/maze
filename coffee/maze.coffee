class Maze
  constructor: (@canvas, @fps = 60) ->
    @context = @canvas.getContext '2d'
    @width = @canvas.width
    @height = @canvas.height

    @desiredStep = 1000 / @fps
    @debug = false #set to true to see debug information about the game on the screen

    @keyPressed = #which keys are pressed
      shift: false

    #monitor the keys that are pressed.
    $(@canvas).on 'keydown keyup', (event) =>
      keyName = Maze.keys[event.which]

      if keyName
        @keyPressed[keyName] = event.type is 'keydown'
        event.preventDefault()
      @keyPressed.shift = event.shiftKey


  setMap: (@map) ->
    @camera?.map = @map

  setCamera: (@camera) ->
    @camera.map = @map if @map

  ###
  Called to start the game loop
  ###
  start: ->
    @recordUpdate()
    @frame =>
      @loop()


  ###
  Call to record when an update cycle was completed
  ###
  recordUpdate: ->
    @lastUpdate = new Date().getTime()


  ###
  Sets up the mechanism for repeatedly updating and drawing the game.
  ###
  frame: (callFrame) ->
    # does the browser have a native FPS system?
    if window.requestAnimationFrame
      window.requestAnimationFrame =>
        callFrame()
        @frame callFrame
      # no, so fall back on using setInterval()
    else
      interval = 1000 / @fps
      setInterval ->
        callFrame()
      , interval

  ###
  Execute one update and drawing loop.
  ###
  loop: ->
    #calculate how much time has passed since the last update
    startTime = new Date().getTime()
    timePassed = startTime - @lastUpdate
    steps = @desiredStep / timePassed
    @update steps
    @draw()
    @recordUpdate()

  ###
  Update all the entities once.
  ###
  update: (steps) ->
    if @keyPressed.up
      @camera.move 15
    else if @keyPressed.down
      @camera.move -15

    if @keyPressed.left
      if @keyPressed.shift
        @camera.strife -15
      else
        @camera.angle -= 1.3
    else if @keyPressed.right
      if @keyPressed.shift
        @camera.strife 15
      else
        @camera.angle += 1.3

  ###
  Draw each entity.
  ###
  draw: ->
    # draw the sky...
    gradient = @context.createLinearGradient 0, 0, 0, @canvas.height / 2
    gradient.addColorStop 0, '#6698FF'
    gradient.addColorStop 1, '#2554C7'
    @context.fillStyle = gradient
    @context.fillRect 0, 0, @canvas.width, @canvas.height / 2

    #... and the ground
    gradient = @context.createLinearGradient 0, 0, 0, @canvas.height
    gradient.addColorStop 0, '#254117'
    gradient.addColorStop 1, '#4AA02C'
    @context.fillStyle = gradient
    @context.fillRect 0, @canvas.height / 2, @canvas.width, @canvas.height

    # draw the map
    @camera.project @canvas, @context

  ###
  Constants for some keys we're interesting in
  ###
  @keys:
    32: "space"
    37: "left"
    38: "up"
    39: "right"
    40: "down"
    80: "P"
    83: "S"