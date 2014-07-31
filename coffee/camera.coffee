class Camera
  constructor: (@x = 0, @y = 600, @angle = 0)->
    @fov = 60
    @maxDistance = 1500

  project: (map, canvas, context) ->
    angle = @angle - (@fov / 2)
    angleIncrement = @fov / canvas.width
    distanceFromScreen = canvas.width / 2 / Math.tan(@fov / 2 * DEG)
    for x in [0...canvas.width]
      distance = @castRay map, angle
      sliceHeight = map.wallHeight / distance * distanceFromScreen
      y = canvas.height / 2 - sliceHeight / 2

      context.fillStyle = '#F0F'
      context.fillRect x, y, 1, sliceHeight

      context.fillStyle = '#000'
      context.globalAlpha = distance / @maxDistance
      context.fillRect x, y, 1, sliceHeight

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
