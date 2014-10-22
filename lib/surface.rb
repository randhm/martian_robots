class Surface
  attr_reader :height
  attr_reader :width
  attr_reader :robots_positions

  def initialize(dimenions)
    raise ArgumentError if /^\d+\s\d+$/.match(dimenions).nil?
#    dimenions = '5 3'
    @width = dimenions.split.first.to_i
    @height = dimenions.split.last.to_i
    raise ArgumentError if @width > 50 || @height > 50
    @robots_positions = {}
  end




end
