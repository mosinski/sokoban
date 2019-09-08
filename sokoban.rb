require 'yaml'
require 'ruby2d'
require './lib/character.rb'
require './lib/floor.rb'

require 'active_support'
require 'active_support/core_ext/hash/keys'

FLOORS = './floors'

SPRITES_PATH = Dir.pwd + '/assets/sprites.png'

##
# Window
##

set title: 'Sokoban',
    width: 1024,
    height: 768,
    resizable: false

floor = nil

Dir.glob(File.join(FLOORS, '**', '*')).each do |file|
  File.open(file) do |file|
    settings = YAML.load(File.read(file).split.join(' ')).symbolize_keys
    floor = Floor.new(**settings)
  end
end

character = floor.character
keys_pressed = Array.new

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
end

show
