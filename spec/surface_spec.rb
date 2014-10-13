require 'spec_helper'

describe 'surface' do
  it 'has a height' do
    surface = Surface.new
    surface.height = 5
    expect(surface.height).to eq(5)
  end

  it 'has a width' do
    surface = Surface.new
    surface.width = 10
    expect(surface.width).to eq(10)
  end



end
