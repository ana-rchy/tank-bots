class_name Tank extends StaticBody2D

enum Direction {UP, UP_RIGHT, RIGHT, DOWN_RIGHT, DOWN, DOWN_LEFT, LEFT, UP_LEFT}
enum MoveResult { OK, OUT_OF_ACTIONS, BESIDE_WALL, HIT_WALL, HIT_TANK }
enum ShootResult { OK, OUT_OF_ACTIONS }

const SPRITE_SIZE = 32
const MAX_STORED_ACTIONS = 3
const CONTACT_DAMAGE = 2

@export var _player_script: PlayerScript
@export var _bullets_holder: Node2D
@export var _bullet_scene: PackedScene
@export var _name_label: Label
@export var _hp_label: Label
@export var _body_anim_tree: AnimationTree
@export var _turret_anim_tree: AnimationTree

var _enemy_tank: Tank
var _position_history: Array[Vector2i]
var _hp := 5
var _actions := 0

func _ready():
	_position_history.append(get_pos())

	_name_label.text = name



func move(dir_enum: Direction) -> MoveResult:
	if (_actions <= 0):
		return MoveResult.OUT_OF_ACTIONS

	var prev_pos = global_position

	_actions -= 1

	var dir = dir_to_vector(dir_enum) * SPRITE_SIZE
	var collision = move_and_collide(dir)
	
	if (collision != null):
		if (collision.get_collider() is Tank):
			_hp -= CONTACT_DAMAGE
			return MoveResult.HIT_TANK
		else:
			if (global_position != prev_pos):
				return MoveResult.BESIDE_WALL
			else:
				return MoveResult.HIT_WALL
	
	_body_anim_tree["parameters/blend_position"] = dir

	return MoveResult.OK

func shoot(dir_enum: Direction) -> ShootResult:
	if (_actions <= 0):
		return ShootResult.OUT_OF_ACTIONS

	_actions -= 1

	var bullet = _bullet_scene.instantiate()
	
	bullet._dir = dir_to_vector(dir_enum) * SPRITE_SIZE
	bullet.global_position = global_position

	_bullets_holder.add_child(bullet)

	_turret_anim_tree["parameters/blend_position"] = bullet._dir

	return ShootResult.OK



func get_pos() -> Vector2i:
	return global_position / SPRITE_SIZE as Vector2i

func get_enemy_pos() -> Vector2i:
	if (_enemy_tank != null):
		return _enemy_tank.get_pos()
	else:
		return Vector2i(-1, -1)

func get_pos_history() -> Array[Vector2i]:
	return _position_history

func get_enemy_pos_history() -> Array[Vector2i]:
	if (_enemy_tank != null):
		return _enemy_tank.get_pos_history()
	else:
		return []

func get_bullets() -> Array[Bullet]:
	var bullets: Array[Bullet]
	var bullet_nodes = _bullets_holder.get_children()

	for node in bullet_nodes:
		bullets.append(node as Bullet)

	return bullets

func get_enemy_bullets() -> Array[Bullet]:
	return _enemy_tank.get_bullets()

func get_hp() -> int:
	return _hp

func get_enemy_hp() -> int:
	return _enemy_tank.get_hp()

func get_action_count() -> int:
	return _actions



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
