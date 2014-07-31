// Generated by CoffeeScript 1.7.1
var Map;

Map = (function() {
  function Map() {
    this.grid = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    this.width = 1000;
    this.height = 1000;
    this.blockSize = 100;
    this.wallHeight = this.blockSize;
  }

  Map.prototype.get = function(x, y) {
    if (x < 0 || x >= this.width || y < 0 || y >= this.height) {
      return 1;
    }
    x = Math.floor(x / this.blockSize);
    y = Math.floor(y / this.blockSize);
    return this.grid[x + y * this.width / this.blockSize];
  };

  return Map;

})();
