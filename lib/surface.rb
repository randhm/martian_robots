class Surface
  attr_reader :height
  attr_reader :width

  def initialize(dimenions)
#    dimenions = '5 3'
    @width = dimenions.split.first.to_i
    @height = dimenions.split.last.to_i
  end



end
