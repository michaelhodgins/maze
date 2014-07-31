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
    @camera.project @map, @canvas, @context
