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

  def key_down(keys_pressed, event)
    return if (keys_pressed - [event.key.to_sym]).any?

    case event.key.to_sym
    when :left
      character.play animation: :walk_left, loop: true
      character.walk x: -1
      keys_pressed << :left
    when :right
      character.play animation: :walk_right, loop: true
      character.walk x: 1
      keys_pressed << :right
    when :up
      character.play animation: :walk_up, loop: true
      character.walk y: -1
      keys_pressed << :up
    when :down
      character.play animation: :walk_down, loop: true
      character.walk y: 1
      keys_pressed << :down
    end
  end

  def key_up(keys_pressed, event)
    case keys_pressed.delete(event.key.to_sym)
    when :left
      character.stop animation: :stand_left, loop: true
    when :right
      character.stop animation: :stand_right, loop: true
    when :up
      character.stop animation: :stand_up, loop: true
    when :down
      character.stop animation: :stand_down, loop: true
    end
  end

  def done?
    ends.all? do |object|
      boxes.any? { |box| box.contains?(object.x, object.y) }
    end
  end

  def remove
    walls.map(&:remove)
    boxes.map(&:remove)
    ends.map(&:remove)
    character.sprite.remove
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
