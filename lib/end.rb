class End < Sprite
  def initialize(x, y)
    super(
      SPRITES_PATH,
      x:,
      y:,
      z: -1,
      width: 20,
      height: 20,
      animations:
    )
  end

  private

  def animations
    {
      show: [
        {
          x: 0, y: 385,
          width: 31,
          height: 36,
          time: 300
        }
      ]
    }
  end
end
