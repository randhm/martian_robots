require_relative './lib/robot'
require_relative './lib/surface'

@surface = Surface.new('5 3')



robot = Robot.new('1 1 E', @surface)
robot.move('RFRFRFRF')
puts robot.position

robot = Robot.new('3 2 N', @surface)
robot.move('FRRFLLFFRRFLL')
puts robot.position

robot = Robot.new('0 3 W', @surface)
robot.move('LLFFFLFLFL')
puts robot.position

