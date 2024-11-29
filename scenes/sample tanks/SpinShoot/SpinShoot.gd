extends PlayerScript

var i := 0

func start(tank: Tank):
	pass

func on_turn(tank: Tank):
	tank.shoot(i)

	i = (i + 1) % 8
