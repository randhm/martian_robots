class Surface
  attr_reader :height
  attr_reader :width
  #attr_reader :robots_positions

  def initialize(dimenions)
    raise ArgumentError if /^\d+\s\d+$/.match(dimenions).nil?
#    dimenions = '5 3'
    @width = dimenions.split.first.to_i
    @height = dimenions.split.last.to_i
    raise ArgumentError if @width > 50 || @height > 50

    @out_of_bounds_coordinates = []
  end

  def out_of_bounds?(x, y)
    @width < x || @height < y || y < 0 || x < 0
  end

  def save_out_of_bounds_coordinates(x, y)
    @out_of_bounds_coordinates << [x, y]
  end

# def return_all_out_of_bounds_coords
#   @out_of_bounds_coordinates
#   end

end
