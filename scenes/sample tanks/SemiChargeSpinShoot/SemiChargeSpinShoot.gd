extends PlayerScript

var dir := 0

func start(tank: Tank):
	pass

func on_turn(tank: Tank):
	if (tank.get_action_count() >= 2):
		while (tank.get_action_count() > 0):
			tank.shoot(dir)
			dir = (dir + 1) % 8
