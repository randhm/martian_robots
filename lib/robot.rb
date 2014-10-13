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
    instructions.each_char do |char|
      if char == 'L'
        @orientation = case @orientation
        when 'N' then 'W'
        when 'S' then 'E'
        when 'E' then 'N'
        when 'W' then 'S'
        end
      end
      if char == 'R'
        @orientation = case @orientation
        when 'N' then 'E'
        when 'S' then 'W'
        when 'E' then 'S'
        when 'W' then 'N'
        end
      end
      if char == 'F'
        case @orientation
        when 'N' then @y+=1
        when 'S' then @y-=1
        when 'E' then @x=+1
        when 'W' then @x-=1

        end
      end






    end

  end


end
