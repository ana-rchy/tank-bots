extends PlayerScript

var move_dir := Tank.Direction.UP
var shoot_dir: Tank.Direction

func start(tank: Tank):
	var pos = tank.get_pos()
	var enemy_pos = tank.get_enemy_pos()

	if (pos.x < enemy_pos.x):
		shoot_dir = Tank.Direction.RIGHT
	else:
		shoot_dir = Tank.Direction.LEFT

func on_turn(tank: Tank):
	if (tank.get_action_count() >= 2):
		var move_res = tank.move(move_dir)
		tank.shoot(shoot_dir)

		if (move_res == Tank.MoveResult.BESIDE_WALL):
			move_dir = (move_dir + 4) % 8 as Tank.Direction
