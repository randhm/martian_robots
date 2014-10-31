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
    @robot.move('L')
    expect(@robot.last_position).to eq('5 3 W')
  end

  it 'orientation changes from N to E when receiving R command' do
    @robot.move('R')
    expect(@robot.last_position).to eq('5 3 E')
  end

  it 'coordinates change from 5 2 N to 5 3 N when receiving F command' do
    robot = Robot.new('5 2 N', @surface)
    robot.move('F')
    expect(robot.last_position).to eq('5 3 N')
  end

  it 'can take two commands in one go' do
    @robot.move('LF')
    expect(@robot.last_position).to eq('4 3 W')
  end

  it 'can take three commands in one go' do
    @robot.move('LFR')
    expect(@robot.last_position).to eq('4 3 N')
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
      expect { Robot.new('N 3 N', @surface) }.to raise_error(ArgumentError)
      expect { Robot.new('N N 3 ', @surface) }.to raise_error(ArgumentError)
      expect { Robot.new('N N N ', @surface) }.to raise_error(ArgumentError)
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

  describe 'leaving robot scent' do
    it 'should log the last known position if falls off the planet' do
      @robot.move('F')
      expect(@surface.out_of_bounds_coordinates).to eq(['5 3 N'])
    end

    it 'should not log the last known position if robot turns away from edge of surface' do
      @robot.move('L')
      expect(@surface.out_of_bounds_coordinates).to eq([])
    end

    it 'should ignore forward command when at the edge of the surface' do
      @robot.move('F')
      robot = Robot.new('5 3 N', @surface)
      robot.move('F')
      expect(robot.position).to eq('5 3 N')
    end
  end
end








