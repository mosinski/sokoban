class Splash < Sprite
  def initialize
    super(
      'assets/splash-sprite.jpeg',
      width: Window.width,
      height: Window.height,
      x: 0,
      y: 0,
      clip_width: 1665,
      loop: true,
      animations:
    )
  end

  def hide
    stop
    sleep 1
    remove
  end

  def animations
    {
      walk: [
        {
          x: 0,
          y: 0,
          width: 1665,
          height: 900,
          time: 300
        },
        {
          x: 1668,
          y: 0,
          width: 1665,
          height: 900,
          time: 300
        },
        {
          x: 3335,
          y: 0,
          width: 1665,
          height: 900,
          time: 300
        },
        {
          x: 5002,
          y: 0,
          width: 1665,
          height: 900,
          time: 300
        },
        {
          x: 0,
          y: 900,
          width: 1665,
          height: 900,
          time: 300
        },
        {
          x: 1668,
          y: 900,
          width: 1665,
          height: 900,
          time: 300
        },
        {
          x: 3335,
          y: 900,
          width: 1665,
          height: 900,
          time: 300
        },
        {
          x: 5002,
          y: 900,
          width: 1665,
          height: 900,
          time: 300
        },
        {
          x: 0,
          y: 1800,
          width: 1665,
          height: 900,
          time: 300
        },
        {
          x: 1668,
          y: 1800,
          width: 1665,
          height: 900,
          time: 300
        },
        {
          x: 3335,
          y: 1800,
          width: 1665,
          height: 900,
          time: 300
        }
      ]
    }
  end

  def key_down
    hide
  end

  def key_up
    hide
  end
end
