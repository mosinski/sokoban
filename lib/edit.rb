class Edit
  attr_accessor :marker

  def initialize
  end

  def key_up(_, event, parent_state)
    @state = parent_state

    case event.key.to_sym
    when :left then left
    when :right then right
    when :up then up
    when :down then down
    end
  end

  def marker_show
    @marker ||= [
      Line.new(x1: 1, y1: 1, x2: 58, y2: 1, width: 1, color: 'white', z: -1),
      Line.new(x1: 58, y1: 1, x2: 58, y2: 58, width: 1, color: 'white', z: -1),
      Line.new(x1: 58, y1: 58, x2: 1, y2: 58, width: 1, color: 'white', z: -1),
      Line.new(x1: 1, y1: 58, x2: 1, y2: 1, width: 1, color: 'white', z: -1)
    ]
    marker.each { |el| el.z = 1 }
  end

  private

  def left
    return if marker[0].x1 < 59 && marker[0].x2 < 59

    marker.each do |line|
      line.x1 -= 58
      line.x2 -= 58
    end
  end

  def right
    return if marker[0].x1 > 1084 && marker[0].x2 > 1084

    marker.each do |line|
      line.x1 += 58
      line.x2 += 58
    end
  end

  def up
    return if marker[0].y1 < 59 && marker[0].y2 < 59

    marker.each do |line|
      line.y1 -= 58
      line.y2 -= 58
    end
  end

  def down
    return if marker[0].y1 > 668 && marker[0].y2 > 668

    marker.each do |line|
      line.y1 += 58
      line.y2 += 58
    end
  end
end
