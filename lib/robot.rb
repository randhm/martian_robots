class Robot

  def initialize(position, surface)
    @surface = surface
    ps = position.split
    raise ArgumentError if ps.length != 3
    # right_char_order = position
    # raise ArgumentError if right_char_order !=~ /^\d+\d+[neswNSEW]+$/

    # if !(/^\d+\d+[neswNSEW]+$/.match(position))
    #   raise ArgumentError
    # end
    @x = ps[0].to_i
    @y = ps[1].to_i
    @orientation = ps[2]
    @surface.robots_positions[self.object_id] = {last_known_position: position, state: :successful}
  end

  def position
    [@x,@y,@orientation].join(' ')
  end

  def last_position
    @surface.robots_positions[self.object_id][:last_known_position] + (' LOST' if out_of_bounds?).to_s
  end

  def out_of_bounds?
    @surface.width < @x || @surface.height < @y || @y < 0 || @x < 0
  end

  def move(instructions)
    instructions.each_char do |char|
      if !out_of_bounds?
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
          # if no other robots have fallen off the planet going here...
          # log with the surface that we're about to move
          @surface.robots_positions[self.object_id][:state] = :transferring
          case @orientation
          when 'N' then @y+=1
          when 'S' then @y-=1
          when 'E' then @x=+1
          when 'W' then @x-=1
          end
        end
        # log with the surface that our move was successful (if it was! exit
          if out_of_bounds?
            @orientation+= ' LOST'
          else
            @surface.robots_positions[self.object_id] = {last_known_position: position, state: :successful}
          end
        end
      end
    end
  end



