class_name PlayerScript extends Node

var counter = 0

func on_turn(tank: Tank):
	if (counter == 1):
		tank.shoot(Tank.Direction.UP_RIGHT)
		tank.move(Tank.Direction.DOWN_RIGHT)

	counter = (counter + 1) % 2
