class Map
  constructor: ->
    @grid = [
      #0  1  2  3  4  5  6  7  8  9
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0 # 0
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0 # 1
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0 # 2
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0 # 3
      0, 0, 0, 0, 1, 0, 0, 0, 1, 0 # 4
      0, 0, 0, 0, 1, 0, 0, 0, 1, 0 # 5
      0, 0, 0, 0, 0, 0, 0, 0, 1, 1 # 6
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0 # 7
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0 # 8
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0 # 9
    ]
    @width = 1000
    @height = 1000
    @blockSize = 100
    @wallHeight = @blockSize

  get: (x, y) ->
    if x < 0 or x >= @width or y < 0 or y >= @height
      return 1
    x = Math.floor x / @blockSize
    y = Math.floor y / @blockSize

    @grid[x + y * @width / @blockSize]
