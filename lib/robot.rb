class Robot
  attr_reader :robots_positions

  def initialize(position, surface)
    raise ArgumentError if /^\d+\s\d+\s[neswNSEW]+$/.match(position).nil?
    @surface = surface
    ps = position.split
    @x, @y = ps[0].to_i, ps[1].to_i
    raise ArgumentError if @x > 50 || @y > 50
    @orientation = ps[2]
    @robots_positions = {}
    @robots_positions[self.object_id] = {last_known_position: position, state: :successful}
  end

  def position
    [@x,@y,@orientation].join(' ')
  end

  def last_position
    @robots_positions[self.object_id][:last_known_position] + (' LOST' if @robots_positions[self.object_id][:state] == :lost).to_s
  end

  def move(instructions)
    instructions.each_char do |char|
      new_x = @x
      new_y = @y
      if !(@robots_positions[self.object_id][:state] == :lost)
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
          if !@surface.out_of_bounds_coordinates.include?(@robots_positions[self.object_id][:last_known_position])
            case @orientation
            when 'N' then new_y+=1
            when 'S' then new_y-=1
            when 'E' then new_x+=1
            when 'W' then new_x-=1
            end
          end
        end
        if @surface.out_of_bounds?(new_x, new_y)
          @orientation+= ' LOST'
          @robots_positions[self.object_id][:state] = :lost
          @surface.save_out_of_bounds_coordinates(@robots_positions[self.object_id][:last_known_position])
        else
          @x = new_x
          @y = new_y
          @robots_positions[self.object_id] = {last_known_position: position, state: :successful}
        end
      end
    end
  end
end


