class Box < Sprite
  def initialize(x, y)
    super(
      SPRITES_PATH,
      x:,
      y:,
      width: 59,
      height: 59,
      animations:
    )
  end

  private

  def animations
    {
      show: [{
        x: 192, y: 256,
        width: 63, height: 63,
        time: 300
      }],
      done: [{
        x: 257, y: 256,
        width: 63, height: 63,
        time: 300
      }]
    }
  end
end
