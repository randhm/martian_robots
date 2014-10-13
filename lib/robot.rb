class Robot
  attr_accessor :position #attr_accessors defined at the beginning, expect private methods

def orientation
  position.last
end

def orientation=(new_orientation)
  position[2] = new_orientation #third element (the last one) should have the value new_orientation
end

  def move(instructions)
    if instructions == 'L' && self.orientation == 'N'
      self.orientation = 'W'
    end
  end


end
