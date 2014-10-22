require 'spec_helper'

describe 'surface' do
  before(:each) do
    @surface = Surface.new('5 3')
  end
  it 'has a height' do
    expect(@surface.height).to eq(3)
  end

  it 'has a width' do
    expect(@surface.width).to eq(5)
  end

  it 'should record all previous robots last positions' do
    robot = Robot.new('0 0 N', @surface)
    robot.move('FF')
    expect(@surface.robots_positions[robot.object_id]).to eq({last_known_position: '0 2 N', state: :successful})
  end

  describe 'invalid initialization values' do
      it 'should not handle one number' do
        expect { Surface.new('5') }.to raise_error(ArgumentError)
      end
      it 'should not handle three numbers' do
        expect { Surface.new('5 3 3') }.to raise_error(ArgumentError)
      end
      it 'should not handle random gibberish' do
        expect { Surface.new('53%$%£') }.to raise_error(ArgumentError)
      end
    end

    describe 'both dimensions need to be no more than 50' do
      it 'handles when :x > 50' do
        expect { Surface.new('51 3') }.to raise_error(ArgumentError)
      end
      it 'handles when :y > 50' do
        expect { Surface.new('3 73') }.to raise_error(ArgumentError)
      end
    end

  end


