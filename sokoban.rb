require 'yaml'
require 'ruby2d'
require './lib/character'
require './lib/floor'

require 'active_support'
require 'active_support/core_ext/hash/keys'

FLOORS = './floors'.freeze
SPRITES_PATH = "#{Dir.pwd}/assets/sprites.png".freeze

##
# Window
##

set title: 'Sokoban',
    width: 1200,
    height: 768,
    resizable: false

floors = []

Dir.glob(File.join(FLOORS, '**', '*')).each do |file|
  File.open(file) do |file|
    floors << YAML.load(File.read(file).split.join(' ')).symbolize_keys
  end
end

floor = Floor.new(**floors[1])

score = Text.new('', x: 10, y: get(:height) - 30, color: 'red')
character = floor.character
keys_pressed = []

on :key_down do |event|
  if (keys_pressed - [event.key.to_sym]).empty?
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
end

on :key_up do |event|
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

update do
  floor.time += 1
  score.text = "01 | moves: #{floor.character.moves} | pushes: #{floor.character.pushes} | time: #{Time.at(floor.time / 60).utc.strftime("%M:%S:%L")}"
end

show
