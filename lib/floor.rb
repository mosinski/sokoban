class Floor
  attr_accessor :start, :ends, :boxes, :walls, :character

  def initialize(start:, ends:, boxes:, walls:)
    @start = start
    @ends = ends
    @boxes = boxes
    @walls = walls
    @character = Character.new

    build
  end

  private

  def build
    self.walls = walls.map do |wall|
      wall = Sprite.new(
        SPRITES_PATH,
        x: wall['x'],
        y: wall['y'],
        width: 59,
        height: 59,
        animations: {
          show: [
            {
              x: 64, y: 0,
              width: 59,
              height: 59,
              time: 300
            }
          ]
        }
      )
      wall.play(animation: :show, loop: true)
      wall
    end
    self.boxes = boxes.map do |box|
      box = Sprite.new(
        SPRITES_PATH,
        x: box['x'],
        y: box['y'],
        width: 59,
        height: 59,
        animations: {
          show: [
            {
              x: 192, y: 256,
              width: 63,
              height: 63,
              time: 300
            }
          ],
          done: [
            {
              x: 257, y: 256,
              width: 63,
              height: 63,
              time: 300
            }
          ]
        }
      )
      box.play(animation: :show, loop: true)
      box
    end
    self.ends = ends.map do |e|
      e = Sprite.new(
        SPRITES_PATH,
        x: e['x'],
        y: e['y'],
        z: -1,
        width: 20,
        height: 20,
        animations: {
          show: [
            {
              x: 0, y: 385,
              width: 31,
              height: 36,
              time: 300
            }
          ]
        }
      )
      e.play(animation: :show, loop: true)
      e
    end
    character.sprite.x = start['x']
    character.sprite.y = start['y']
    character.walls = walls
    character.boxes = boxes
    character.ends = ends
    character.stop animation: :stand_down, loop: true
  end
end
