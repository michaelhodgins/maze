class Camera
  constructor: (@x = 100, @y = 600, @angle = 0)->
    @fov = 60
    @maxDistance = 1500

  project: (canvas, context) ->
    angle = @angle - (@fov / 2)
    angleIncrement = @fov / canvas.width
    distanceFromScreen = canvas.width / 2 / Math.tan(@fov / 2 * DEG)
    prevAlpha = context.globalAlpha
    for x in [0...canvas.width]
      ray = @castRay angle
      distance = ray.length

      distance *= Math.cos((@angle - angle) * DEG)

      sliceHeight = @map.wallHeight / distance * distanceFromScreen
      y = canvas.height / 2 - sliceHeight / 2

      context.fillStyle = if ray.wall is 1 then '#C79926' else '#ADA96E'
      context.fillRect x, y, 1, sliceHeight

      context.fillStyle = '#000'
      context.globalAlpha = distance / @maxDistance / 1.6
      context.fillRect x, y, 1, sliceHeight
      context.globalAlpha = prevAlpha

      angle += angleIncrement

  castRay: (angle) ->
    x = @x
    y = @y
    xIncrement = Math.cos angle * DEG
    yIncrement = Math.sin angle * DEG
    for length in [0...@maxDistance]
      x += xIncrement
      y += yIncrement
      wall = @map.get x, y
      if wall
        return {
          length
          wall
        }

  move: (distance) ->
    #only move if there's nothing in front of or behind the camera
    movementAngle = if distance > 0 then @angle else @angle+180
    wallDistance = @distanceInArc movementAngle

    if distance > 0
      if distance is wallDistance
        distance = distance - 10
      else
        distance = Math.min distance, wallDistance
    else
      distance = Math.max distance, -wallDistance

    if Math.abs(distance) > 12
      @x += Math.cos(@angle * DEG) * distance
      @y += Math.sin(@angle * DEG) * distance

  strife: (distance) ->
    movementAngle = if distance > 0 then @angle+90 else @angle-90
    wallDistance = @distanceInArc movementAngle

    if distance > 0
      distance = Math.min distance, wallDistance
    else
      distance = Math.max distance, -wallDistance

    if Math.abs(distance) > 12
      @x += Math.cos((@angle+90) * DEG) * distance
      @y += Math.sin((@angle+90) * DEG) * distance

  distanceInArc: (centreAngle) ->
    leftHandAngle = centreAngle - @fov / 3
    rightHandAngle = centreAngle + @fov / 3
    ray0 = @castRay centreAngle
    ray1 = @castRay leftHandAngle
    ray2 = @castRay rightHandAngle
    Math.min ray0.length, ray1.length, ray2.length