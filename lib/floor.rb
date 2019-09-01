ASSETS_PATH = Dir.pwd + '/assets'

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
      Sprite.new(
        ASSETS_PATH + '/wall.png',
        x: wall['x'],
        y: wall['y'],
        width: 59,
        height: 59
      )
    end
    self.boxes = boxes.map do |box|
      Sprite.new(
        ASSETS_PATH + '/box.png',
        x: box['x'],
        y: box['y'],
        width: 59,
        height: 59
      )
    end
    character.sprite.x = start['x']
    character.sprite.y = start['y']
    character.walls = walls
    character.boxes = boxes
  end
end
