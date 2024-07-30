require 'yaml'
require 'ruby2d'
require './lib/character'
require './lib/floor'
require './lib/splash'
require './lib/hallway'

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

state = :splash
level = 0
floor = Floor.new(**floors[level])
hallway = Hallway.new

score = Text.new('', x: 10, y: get(:height) - 30, color: 'red')
splash = Splash.new
splash.play animation: :walk
keys_pressed = []

on :key_down do |event|
  case state
  when :floor
    floor.key_down(keys_pressed, event)
  end
end

on :key_up do |event|
  case state
  when :splash
    splash.key_up
    state = :hallway
    hallway.show
  when :hallway
    hallway.key_up(keys_pressed, event, state)
  when :floor
    floor.key_up(keys_pressed, event)
  end
end

update do
  case state
  when :hallway
    state = hallway.state
  when :floor
    unless floor.done?
      floor.time += 1
      score.text = "#{format('%02d', level + 1)} | moves: #{floor.character.moves} | pushes: #{floor.character.pushes} | time: #{Time.at(floor.time / 60).utc.strftime("%M:%S:%L")}"
    else
      level += 1
      if (next_floor = floors[level])
        floor.remove
        floor = Floor.new(**next_floor)
      end
    end
  end
end

show
