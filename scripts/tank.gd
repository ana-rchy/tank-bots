class_name Tank extends StaticBody2D

enum Direction {UP, UP_RIGHT, RIGHT, DOWN_RIGHT, DOWN, DOWN_LEFT, LEFT, UP_LEFT}
enum MoveResult { OK, OUT_OF_ACTIONS, HIT_WALL, HIT_TANK }
enum ShootResult { OK, OUT_OF_ACTIONS }

const SPRITE_SIZE = 32
const MAX_STORED_ACTIONS = 3
const CONTACT_DAMAGE = 2

@export var _player_script: PlayerScript
@export var _bullets_holder: Node2D
@export var _bullet_scene: PackedScene

var _enemy_tank: Tank
var _hp := 5
var _actions := 0

func _on_timeout():
	_actions = clampi(_actions + 1, 0, MAX_STORED_ACTIONS)

	_player_script.on_turn(self)

	for bullet in get_own_bullets():
		bullet.on_turn()

func move(dir_enum: Direction) -> MoveResult:
	if (_actions <= 0):
		return MoveResult.OUT_OF_ACTIONS

	_actions -= 1

	var dir = dir_to_vector(dir_enum) * SPRITE_SIZE
	var collision = move_and_collide(dir)
	
	if (collision != null):
		if (collision.get_collider() is Tank):
			_hp -= CONTACT_DAMAGE
			return MoveResult.HIT_TANK
		else:
			return MoveResult.HIT_WALL

	return MoveResult.OK

func shoot(dir_enum: Direction) -> ShootResult:
	if (_actions <= 0):
		return ShootResult.OUT_OF_ACTIONS

	_actions -= 1

	var dir = dir_to_vector(dir_enum) * SPRITE_SIZE
	var bullet = _bullet_scene.instantiate()
	
	bullet.dir = dir
	bullet.global_position = global_position

	_bullets_holder.add_child(bullet)

	return ShootResult.OK

func get_own_position() -> Vector2i:
	return position / SPRITE_SIZE as Vector2i

func get_enemy_position() -> Vector2i:
	if (_enemy_tank != null):
		return _enemy_tank.get_own_position()
	else:
		return Vector2i(-1, -1)

func get_own_bullets() -> Array[Bullet]:
	var bullets: Array[Bullet]
	var bullet_nodes = _bullets_holder.get_children()

	for node in bullet_nodes:
		bullets.append(node as Bullet)

	return bullets

func get_enemy_bullets() -> Array[Bullet]:
	return _enemy_tank.get_own_bullets()

func dir_to_vector(dir: Direction) -> Vector2:
	match dir:
		Direction.UP:
			return Vector2.UP
		Direction.UP_RIGHT:
			return Vector2(1, -1)
		Direction.RIGHT:
			return Vector2.RIGHT
		Direction.DOWN_RIGHT:
			return Vector2(1, 1)
		Direction.DOWN:
			return Vector2.DOWN
		Direction.DOWN_LEFT:
			return Vector2(-1, 1)
		Direction.LEFT:
			return Vector2.LEFT
		_:
			return Vector2(-1, -1)
