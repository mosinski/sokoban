class Wall < Sprite
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
      show: [
        {
          x: 64, y: 0,
          width: 59,
          height: 59,
          time: 300
        }
      ]
    }
  end
end
