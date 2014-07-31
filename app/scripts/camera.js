// Generated by CoffeeScript 1.7.1
var Camera;

Camera = (function() {
  function Camera(x, y, angle) {
    this.x = x != null ? x : 100;
    this.y = y != null ? y : 600;
    this.angle = angle != null ? angle : 0;
    this.fov = 60;
    this.maxDistance = 1500;
  }

  Camera.prototype.project = function(canvas, context) {
    var angle, angleIncrement, distance, distanceFromScreen, prevAlpha, ray, sliceHeight, x, y, _i, _ref, _results;
    angle = this.angle - (this.fov / 2);
    angleIncrement = this.fov / canvas.width;
    distanceFromScreen = canvas.width / 2 / Math.tan(this.fov / 2 * DEG);
    prevAlpha = context.globalAlpha;
    _results = [];
    for (x = _i = 0, _ref = canvas.width; 0 <= _ref ? _i < _ref : _i > _ref; x = 0 <= _ref ? ++_i : --_i) {
      ray = this.castRay(angle);
      distance = ray.length;
      distance *= Math.cos((this.angle - angle) * DEG);
      sliceHeight = this.map.wallHeight / distance * distanceFromScreen;
      y = canvas.height / 2 - sliceHeight / 2;
      context.fillStyle = ray.wall === 1 ? '#C79926' : '#ADA96E';
      context.fillRect(x, y, 1, sliceHeight);
      context.fillStyle = '#000';
      context.globalAlpha = distance / this.maxDistance / 1.6;
      context.fillRect(x, y, 1, sliceHeight);
      context.globalAlpha = prevAlpha;
      _results.push(angle += angleIncrement);
    }
    return _results;
  };

  Camera.prototype.castRay = function(angle) {
    var length, wall, x, xIncrement, y, yIncrement, _i, _ref;
    x = this.x;
    y = this.y;
    xIncrement = Math.cos(angle * DEG);
    yIncrement = Math.sin(angle * DEG);
    for (length = _i = 0, _ref = this.maxDistance; 0 <= _ref ? _i < _ref : _i > _ref; length = 0 <= _ref ? ++_i : --_i) {
      x += xIncrement;
      y += yIncrement;
      wall = this.map.get(x, y);
      if (wall) {
        return {
          length: length,
          wall: wall
        };
      }
    }
  };

  Camera.prototype.move = function(distance) {
    var movementAngle, wallDistance;
    movementAngle = distance > 0 ? this.angle : this.angle + 180;
    wallDistance = this.distanceInArc(movementAngle);
    if (distance > 0) {
      if (distance === wallDistance) {
        distance = distance - 10;
      } else {
        distance = Math.min(distance, wallDistance);
      }
    } else {
      distance = Math.max(distance, -wallDistance);
    }
    if (Math.abs(distance) > 12) {
      this.x += Math.cos(this.angle * DEG) * distance;
      return this.y += Math.sin(this.angle * DEG) * distance;
    }
  };

  Camera.prototype.strife = function(distance) {
    var movementAngle, wallDistance;
    movementAngle = distance > 0 ? this.angle + 90 : this.angle - 90;
    wallDistance = this.distanceInArc(movementAngle);
    if (distance > 0) {
      distance = Math.min(distance, wallDistance);
    } else {
      distance = Math.max(distance, -wallDistance);
    }
    if (Math.abs(distance) > 12) {
      this.x += Math.cos((this.angle + 90) * DEG) * distance;
      return this.y += Math.sin((this.angle + 90) * DEG) * distance;
    }
  };

  Camera.prototype.distanceInArc = function(centreAngle) {
    var leftHandAngle, ray0, ray1, ray2, rightHandAngle;
    leftHandAngle = centreAngle - this.fov / 3;
    rightHandAngle = centreAngle + this.fov / 3;
    ray0 = this.castRay(centreAngle);
    ray1 = this.castRay(leftHandAngle);
    ray2 = this.castRay(rightHandAngle);
    return Math.min(ray0.length, ray1.length, ray2.length);
  };

  return Camera;

})();
