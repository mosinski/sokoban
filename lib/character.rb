class Character
  DEFAULTS = { speed: 60 }.freeze

  attr_accessor :sprite, :x, :y, :walls, :boxes, :ends, :moves, :pushes

  def initialize
    build
  end

  def play(args)
    sprite.play(**args)
  end

  def walk(x: 0, y: 0)
    x *= DEFAULTS[:speed]
    y *= DEFAULTS[:speed]

    return if wall_collision?(x, y) || box_collision?(x, y)

    step.play

    self.moves += 1
    self.sprite.x += x
    self.sprite.y += y
  end

  def stop(args)
    sprite.stop
    sprite.play(**args)
  end

  private

  def step
    @step = Sound.new('assets/sounds/footstep.wav')
  end

  def push
    @step = Sound.new('assets/sounds/woodpush.wav')
  end

  def build
    self.moves = 0
    self.pushes = 0
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
          }
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
        ]
      }
    )
  end

  def collision?(objects, x, y)
    objects.select do |object|
      object.contains?(x, y)
    end.any?
  end

  def done?(objects, box)
    objects.select do |object|
      box.contains?(object.x, object.y)
    end.any?
  end

  def wall_collision?(x, y)
    x += sprite.x
    y += sprite.y

    collision?(walls, x, y)
  end

  def box_moveable?(box, x, y)
    x += box.x
    y += box.y

    return false if collision?(walls, x, y) || collision?(boxes, x, y)

    box.x = x
    box.y = y

    self.pushes += 1
    push.play

    box.play(animation: done?(ends, box) ? :done : :show, loop: true)

    true
  end

  def box_collision?(x, y)
    x1 = sprite.x + x
    y1 = sprite.y + y

    boxes.select do |box|
      box.contains?(x1, y1) && !box_moveable?(box, x, y)
    end.any?
  end
end
