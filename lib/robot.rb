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
    @robots_positions[self.object_id][:last_known_position] + (' LOST' if @surface.out_of_bounds?(@x, @y)).to_s
  end



  def move(instructions)
    instructions.each_char do |char|
     # if @surface.out_of_bounds?(@x, @y)
      #  @surface.save_out_of_bounds_coordinate(@x, @y)
      if !@surface.out_of_bounds?(@x, @y)
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
          if !@surface.out_of_bounds_coordinates.include?(@robots_positions[self.object_id][:last_known_position])
            @robots_positions[self.object_id][:state] = :transferring
            case @orientation
            when 'N' then @y+=1
            when 'S' then @y-=1
            when 'E' then @x+=1
            when 'W' then @x-=1
            end
          end
        end
        # log with the surface that our move was successful (if it was! exit
          if @surface.out_of_bounds?(@x, @y)
            @orientation+= ' LOST'
            #@robots_positions[self.object_id][:state] = :lost
            @surface.save_out_of_bounds_coordinates(@robots_positions[self.object_id][:last_known_position])
          else
            @robots_positions[self.object_id] = {last_known_position: position, state: :successful}
          end #if @surface.out_of_bounds?(@x, @y)
        end # !@surface.out_of_bounds?(@x, @y)
      end #do
    end #move method
end #class


