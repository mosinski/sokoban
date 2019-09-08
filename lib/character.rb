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
      SPRITES_PATH,
      x: 0,
      y: 0,
      width: 39,
      height: 58,
      clip_width: 38,
      animations: {
        walk_right: [
          {
            x: 320, y: 244,
            width: 38, height: 60,
            time: 250
          },
          {
            x: 320, y: 128,
            width: 38, height: 58.5,
            time: 250
          }
        ],
        walk_left: [
          {
            x: 323, y: 185,
            width: 38, height: 60,
            time: 250
          },
          {
            x: 323, y: 302,
            width: 38, height: 59,
            time: 250
          }
        ],
        walk_down: [
          {
            x: 362, y: 247,
            width: 38, height: 60,
            time: 250
          },
          {
            x: 357, y: 360,
            width: 38, height: 60,
            time: 250
          },
          {
            x: 320, y: 361,
            width: 38, height: 60,
            time: 250
          }
        ],
        walk_up: [
          {
            x: 383, y: 0,
            width: 38, height: 61,
            time: 250
          },
          {
            x: 362, y: 128,
            width: 38, height: 60,
            time: 250
          },
          {
            x: 362, y: 187,
            width: 38, height: 61,
            time: 250
          },
        ],
        stand_right: [
          {
            x: 320, y: 244,
            width: 38, height: 60,
            time: 250
          }
        ],
        stand_left: [
          {
            x: 323, y: 185,
            width: 38, height: 60,
            time: 250
          }
        ],
        stand_down: [
          {
            x: 362, y: 247,
            width: 38, height: 60,
            time: 250
          }
        ],
        stand_up: [
          {
            x: 383, y: 0,
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
