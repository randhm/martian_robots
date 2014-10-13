class Robot

  def initialize(position, surface)
    @surface = surface
    @x = position.split[0].to_i
    @y = position.split[1].to_i
    @orientation = position.split[2]
  end

  def position
    [@x,@y,@orientation].join(' ')
  end


  def move(instructions)
    if instructions == 'L' && @orientation == 'N'
      @orientation = 'W'
    end
  end


end
