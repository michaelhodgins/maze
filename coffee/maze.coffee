class Maze
  constructor: (@canvas, @fps = 60) ->
    @context = @canvas.getContext '2d'
    @width = @canvas.width
    @height = @canvas.height

    @desiredStep = 1000 / @fps
    @debug = false #set to true to see debug information about the game on the screen

  setMap: (@map) ->

  setCamera: (@camera) ->

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

  ###
  Draw each entity.
  ###
  draw: ->
    # draw the sky and ground
    gradient = @context.createLinearGradient 0, 0, 0, @canvas.height / 2
    gradient.addColorStop 0, '#6698FF'
    gradient.addColorStop 1, '#2554C7'
    @context.fillStyle = gradient
    @context.fillRect 0, 0, @canvas.width, @canvas.height / 2


    gradient = @context.createLinearGradient 0, 0, 0, @canvas.height
    gradient.addColorStop 0, '#254117'
    gradient.addColorStop 1, '#4AA02C'
    @context.fillStyle = gradient
    @context.fillRect 0, @canvas.height / 2, @canvas.width, @canvas.height
    # draw the map
    @camera.project @map, @canvas, @context
