ASSETS_PATH = Dir.pwd + '/assets'

class Character
  DEFAULTS = { speed: 60 }.freeze

  attr_accessor :sprite, :x, :y, :walls, :boxes

  def initialize

    build
  end

  def play(args)
    sprite.play(**args)
  end

  def walk(x: 0, y: 0)
    x = x * DEFAULTS[:speed]
    y = y * DEFAULTS[:speed]

    unless wall_collision?(x, y) || box_collision?(x, y)
      self.sprite.x += x
      self.sprite.y += y
    end
  end

  def stop(args)
    sprite.stop
    sprite.play(**args)
  end

  private

  def build
    self.sprite = Sprite.new(
      ASSETS_PATH + '/character.png',
      x: 0,
      y: 0,
      width: 39,
      height: 59,
      clip_width: 38,
      animations: {
        walk_right: [
          {
            x: 0, y: 0,
            width: 38, height: 61,
            time: 250
          },
          {
            x: 40, y: 0,
            width: 38, height: 61,
            time: 250
          }
        ],
        walk_left: [
          {
            x: 317, y: 0,
            width: 38, height: 61,
            time: 250
          },
          {
            x: 354, y: 0,
            width: 38, height: 61,
            time: 250
          }
        ],
        walk_down: [
          {
            x: 80, y: 0,
            width: 38, height: 61,
            time: 250
          },
          {
            x: 118, y: 0,
            width: 38, height: 61,
            time: 250
          },
          {
            x: 155, y: 0,
            width: 38, height: 61,
            time: 250
          }
        ],
        walk_up: [
          {
            x: 197, y: 0,
            width: 38, height: 61,
            time: 250
          },
          {
            x: 233, y: 0,
            width: 38, height: 61,
            time: 250
          },
          {
            x: 273, y: 0,
            width: 38, height: 61,
            time: 250
          }
        ],
        stand_right: [
          {
            x: 0, y: 0,
            width: 38, height: 61,
            time: 250
          }
        ],
        stand_left: [
          {
            x: 354, y: 0,
            width: 38, height: 61,
            time: 250
          }
        ],
        stand_down: [
          {
            x: 80, y: 0,
            width: 38, height: 61,
            time: 250
          }
        ],
        stand_up: [
          {
            x: 197, y: 0,
            width: 38, height: 61,
            time: 250
          }
        ],
      }
    )
  end

  def collision?(objects, x, y)
    objects.select do |object|
      object.contains?(x, y)
    end.any?
  end

  def wall_collision?(x, y)
    x = self.sprite.x + x
    y = self.sprite.y + y

    collision?(walls, x, y)
  end

  def box_moveable?(box, x, y)
    x = box.x + x
    y = box.y + y

    if collision?(walls, x, y) || collision?(boxes, x, y)
      return false
    else
      box.x = x
      box.y = y
      return true
    end
  end

  def box_collision?(x, y)
    x1 = self.sprite.x + x
    y1 = self.sprite.y + y

    boxes.select do |box|
      box.contains?(x1, y1) && !box_moveable?(box, x, y)
    end.any?
  end
end
