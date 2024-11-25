extends PlayerScript

func on_turn(tank: Tank):
	tank.shoot(Tank.Direction.RIGHT)
