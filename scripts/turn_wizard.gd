extends Node

@export var tank_holders: Array[Node2D]

var tanks: Array[Tank]

func _ready():
	for holder in tank_holders:
		tanks.append(holder.get_children()[0] as Tank)
	
	tanks[0]._enemy_tank = tanks[1]
	tanks[1]._enemy_tank = tanks[0]

	for tank in tanks:
		if (tank == null):
			break

		tank._player_script.start(tank)

func _on_timeout():
	for tank in tanks:
		if (tank == null):
			break

		tank._actions = clampi(tank._actions + 1, 0, tank.MAX_STORED_ACTIONS)
		tank._player_script.on_turn(tank)
	
	for tank in tanks:
		if (tank == null):
			break

		for bullet in tank.get_bullets():
			bullet._on_turn()

	for tank in tanks:
		if (tank == null):
			break

		if (tank._hp <= 0):
			print(tank.name, ": damn")
			tank.queue_free()

		tank._position_history.append(tank.get_pos())
