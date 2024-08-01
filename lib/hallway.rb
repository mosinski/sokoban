class Hallway
  attr_accessor :action, :state

  def initialize
    @action = :play
    @state = :hallway
  end

  def key_up(_, event, parent_state)
    @state = parent_state

    case event.key.to_sym
    when :left then left
    when :right then right
    when :return then enter
    end
  end

  def show
    background.add
    elevators
    character.play(animation: :stand)
  end

  def hide
    background.remove
    elevators.values.map(&:remove)
    character.remove
  end

  private

  def background
    @background ||= Image.new(
      'assets/hallway.png',
      width: Window.width,
      height: Window.height + 238,
      show: false,
      y: 0,
      x: 0
    )
  end

  def elevators
    @elevators ||= {
      edit: elevator(y: 279, x: 390),
      play: elevator(y: 279, x: 702)
    }
  end

  def elevator(x:, y:)
    Sprite.new(
      'assets/elevator.png',
      width: 225,
      height: 270,
      clip_width: 684,
      y:,
      x:,
      animations: {
        open: [
          {
            width: 684,
            height: 746,
            time: 400
          },
          {
            x: 685,
            width: 684,
            height: 746,
            time: 400
          },
          {
            x: 1368,
            width: 684,
            height: 746,
            time: 400
          }
        ],
        close: [
          {
            x: 1368,
            width: 684,
            height: 746,
            time: 400
          },
          {
            x: 685,
            width: 684,
            height: 746,
            time: 400
          },
          {
            width: 684,
            height: 746,
            time: 400
          }
        ]
      }
    )
  end

  def character
    @character ||= Sprite.new(
      'assets/hallway.png',
      width: 128,
      height: 236,
      x: 830,
      y: 355,
      animations: {
        stand: [
          {
            y: 2129,
            width: 380,
            height: 648,
            time: 400
          }
        ],
        press: [
          {
            x: 386,
            y: 2132,
            width: 380,
            height: 648,
            time: 400
          }
        ],
        walk: [
          {
            x: 775,
            y: 2132,
            width: 330,
            height: 648,
            time: 400
          },
          {
            x: 1072,
            y: 2132,
            width: 380,
            height: 648,
            time: 400
          }
        ]
      }
    )
  end

  def left
    return if action == :exit

    character.play(animation: :walk) do
      case action
      when :play
        character.x -= 315
        @action = :edit
      when :edit
        character.x -= 340
        @action = :exit
      end
    end
  end

  def right
    return if action == :play

    character.play(animation: :walk, flip: :horizontal) do
      case action
      when :edit
        character.x += 315
        @action = :play
      when :exit
        character.x += 340
        @action = :edit
      end
    end
  end

  def enter
    character.x += 20
    character.play(animation: :press) do
      if (elevator = elevators[action])
        elevator.play(animation: :open, loop: false) do
          elevator.z = -1
          character.x -= 20
          @state = action == :play ? :floor : :edit
        end
      else
        Window.close
      end
    end
  end
end
