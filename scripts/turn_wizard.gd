extends Node

@export var tanks: Array[Tank]

func _on_timeout():
	for tank in tanks:
		if (tank == null):
			break

		tank._actions = clampi(tank._actions + 1, 0, tank.MAX_STORED_ACTIONS)
		tank._player_script.on_turn(tank)
	
	for tank in tanks:
		if (tank == null):
			break

		for bullet in tank.get_own_bullets():
			bullet.on_turn()

	for tank in tanks:
		if (tank == null):
			break

		if (tank._hp <= 0):
			print(tank.name, ": damn")
			tank.queue_free()
