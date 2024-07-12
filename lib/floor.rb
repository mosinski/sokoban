require './lib/box'
require './lib/wall'
require './lib/end'

class Floor
  attr_accessor :start, :ends, :boxes, :walls, :character, :time

  def initialize(start:, ends:, boxes:, walls:)
    @start = start
    @ends = ends
    @boxes = boxes
    @walls = walls
    @character = Character.new
    @time = 0

    build
  end

  private

  def build
    self.walls = walls.map do |wall|
      wall = Wall.new(wall['x'], wall['y'])
      wall.play(animation: :show, loop: true)
      wall
    end
    self.boxes = boxes.map do |box|
      box = Box.new(box['x'], box['y'])
      box.play(animation: :show, loop: true)
      box
    end
    self.ends = ends.map do |e|
      e = End.new(e['x'], e['y'])
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
