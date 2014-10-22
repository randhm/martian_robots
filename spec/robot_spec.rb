require 'spec_helper'

describe 'robot' do

  before(:each) do
    @surface = Surface.new('5 3')
    @robot = Robot.new('5 3 N', @surface)
  end

  it 'can move' do
    expect(@robot).to respond_to :move
  end

  it 'can move given an instrucion' do
    expect(@robot).to respond_to(:move).with(1).argument
  end

  it 'has a position' do
    expect(@robot.position).to eq('5 3 N')
  end

  it 'orientation changes from N to W when receiving L command' do
    #given

    #when
    @robot.move('L')

    #then
    expect(@robot.last_position).to eq('5 3 W')
  end

  it 'can take two moves in one go' do
    @robot.move('LF')
    expect(@robot.last_position).to eq('4 3 W')
  end

  it 'logs that it is LOST' do
    @robot.move('FF')
    expect(@robot.last_position).to eq('5 3 N LOST')
  end


  describe 'invalid initialization values' do

    it 'should not accept less than three arguments' do
      expect { Robot.new('', @surface) }.to raise_error(ArgumentError)
      expect { Robot.new('5', @surface) }.to raise_error(ArgumentError)
      expect { Robot.new('5 3', @surface) }.to raise_error(ArgumentError)
      expect { Robot.new('5 3 N', @surface) }.not_to raise_error()
    end
    it 'should not accept more than three arguments' do
      expect { Robot.new('5 3 3 N', @surface) }.to raise_error(ArgumentError)
    end

    it 'should accept number number letter' do
      #expect { Robot.new('2 4 E', @surface) }.to eq('2 4 E')
      expect { Robot.new('N 3 N', @surface) }.to raise_error(ArgumentError)
      expect { Robot.new('N N 3 ', @surface) }.to raise_error(ArgumentError)
      expect { Robot.new('N N N ', @surface) }.to raise_error(ArgumentError)
      #extend test to cater for symbols, invalid data etc.
    end

    it 'should raise error when :x > 50' do
      expect { Robot.new('51 3 N', @surface) }.to raise_error(ArgumentError)
    end

    it 'should raise error handles when :y > 50' do
      expect { Robot.new('5 63 N', @surface) }.to raise_error(ArgumentError)
    end

    it 'should only allow N W E S as values' do
      expect { Robot.new('5 3 N', @surface) }.not_to raise_error()
      expect { Robot.new('5 3 W', @surface) }.not_to raise_error()
      expect { Robot.new('5 3 S', @surface) }.not_to raise_error()
      expect { Robot.new('5 3 E', @surface) }.not_to raise_error()
      expect { Robot.new('5 3 G', @surface) }.to raise_error()
    end
  end
end




  # describe 'validating sample data from Red Badger' do
  #   it 'works :-)' do
  #     @surface = Surface.new('5 3')

  #     robot = Robot.new('1 1 E', @surface)
  #     robot.move('RFRFRFRF')
  #     expect(robot.position).to eq('1 1 E')

  #     robot = Robot.new('3 2 N', @surface)
  #     robot.move('FRRFLLFFRRFLL')
  #     expect(robot.position).to eq('3 3 N LOST')

  #     robot = Robot.new('0 3 W', @surface)
  #     robot.move('LLFFFLFLFL')
  #     expect(robot.position).to eq('2 3 S')
  #   end
  # end



