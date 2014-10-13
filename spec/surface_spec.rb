require 'spec_helper'

describe 'surface' do
  it 'has a height' do
    surface = Surface.new('5 3')
    expect(surface.height).to eq(3)
  end

  it 'has a width' do
    surface = Surface.new('5 3')
    expect(surface.width).to eq(5)
  end

  it 'should record all previous robots last positions'

  describe 'invalid initialization values' do
    describe 'something other than two numbers seperated by a string' do
      it 'should handle one number'
      it 'should handle three numbers'
      it 'should handle random gibberish'
    end

    describe 'both dimensions need to be no more than 50' do
      it 'handles when :x > 50'
      it 'handles when :y > 50'
    end

  end

end
