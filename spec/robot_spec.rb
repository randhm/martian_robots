require 'spec_helper'

describe 'robot' do
  it 'can move' do
    robot = Robot.new
    expect(robot).to respond_to :move
  end

  it 'can move given an instrucion' do
    robot = Robot.new
    expect(robot).to respond_to(:move).with(1).argument
  end

  it 'has a position' do
    robot = Robot.new
    robot.position = [3,2, 'N']
    expect(robot.position).to eq([3,2, 'N'])
  end

  it 'has a position that is a coordinate and an orientation' do
    robot = Robot.new
    robot.position = [3,2, 'N']
    expect(robot.position.length).to eq(3)
  end

  it 'orientation changes from N to W when receiving L command' do
    #given
    robot = Robot.new
    robot.position = [3,2, 'N']

    #when
    robot.move('L')

    #then
    expect(robot.position).to eq([3,2, 'W'])
  end

end
