extends Node

@export var tank_holders: Array[Node2D]
@export var win_panel: Panel
@export var win_label: Label

var tanks: Array[Tank]

func _ready():
	for holder in tank_holders:
		if (len(holder.get_children()) > 0):
			tanks.append(holder.get_children()[0] as Tank)
	
	if (len(tanks) == 2):
		tanks[0]._enemy_tank = tanks[1]
		tanks[1]._enemy_tank = tanks[0]

	for tank in tanks:
		if (tank == null):
			break

		tank._player_script.start(tank)

func _on_timeout():
	for i in (len(tanks)):
		if (i < len(tanks) and tanks[i] == null):
			tanks.remove_at(i)

	if (len(tanks) == 1):
		win_panel.show()
		win_label.text = str(tanks[0].name) + " wins"
	elif (len(tanks) == 0):
		win_panel.show()
		win_label.text = "draw"

	for tank in tanks:
		tank._actions = clampi(tank._actions + 1, 0, tank.MAX_STORED_ACTIONS)
		tank._player_script.on_turn(tank)
	
	for tank in tanks:
		for bullet in tank.get_bullets():
			bullet._on_turn()

	for tank in tanks:
		if (tank._hp <= 0):
			print(tank.name, ": damn")
			tank.queue_free()

		tank._position_history.append(tank.get_pos())
		tank._hp_label.text = str(tank._hp) + "/5hp"
