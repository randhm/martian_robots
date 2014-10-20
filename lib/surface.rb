class Surface
  attr_reader :height
  attr_reader :width
  attr_reader :robots_positions

  def initialize(dimenions)
#    dimenions = '5 3'
    @width = dimenions.split.first.to_i
    @height = dimenions.split.last.to_i
    @robots_positions = {}
  end




end
