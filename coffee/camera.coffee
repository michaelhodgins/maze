class Camera
  constructor: (@x = 100, @y = 600, @angle = 0)->
    @fov = 60
    @maxDistance = 1500

  project: (map, canvas, context) ->
    angle = @angle - (@fov / 2)
    angleIncrement = @fov / canvas.width
    distanceFromScreen = canvas.width / 2 / Math.tan(@fov / 2 * DEG)
    prevAlpha = context.globalAlpha
    for x in [0...canvas.width]
      distance = @castRay map, angle

      distance *= Math.cos((@angle - angle) * DEG)

      sliceHeight = map.wallHeight / distance * distanceFromScreen
      y = canvas.height / 2 - sliceHeight / 2

      context.fillStyle = '#C79926'
      context.fillRect x, y, 1, sliceHeight

      context.fillStyle = '#000'
      context.globalAlpha = distance / @maxDistance / 1.6
      context.fillRect x, y, 1, sliceHeight
      context.globalAlpha = prevAlpha

      angle += angleIncrement

  castRay: (map, angle) ->
    x = @x
    y = @y
    xIncrement = Math.cos angle * DEG
    yIncrement = Math.sin angle * DEG
    for length in [0...@maxDistance]
      x += xIncrement
      y += yIncrement
      hit = map.get x, y
      if hit
        return length

  move: (distance) ->
    @x += Math.cos(@angle * DEG) * distance
    @y += Math.sin(@angle * DEG) * distance

  strife: (distance) ->
    @x += Math.cos((@angle+90) * DEG) * distance
    @y += Math.sin((@angle+90) * DEG) * distance
