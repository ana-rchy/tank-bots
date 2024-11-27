class_name Bullet extends StaticBody2D

var _position_history: Array[Vector2i]
var _dir: Vector2i
var _damage := 1

@onready var collision_mask_backup := collision_mask

func _ready():
	collision_mask = 0
	_position_history.append(get_pos())

func _on_turn():
	var collision = move_and_collide(_dir)

	if (collision != null):
		var collider = collision.get_collider()

		if (collider is Tank):
			(collider as Tank)._hp -= _damage

		queue_free()
	
	collision_mask = collision_mask_backup

	_position_history.append(get_pos())



func get_pos() -> Vector2i:
	return global_position / Tank.SPRITE_SIZE as Vector2i

func get_pos_history() -> Array[Vector2i]:
	return _position_history

func get_dir() -> Vector2i:
	return _dir / Tank.SPRITE_SIZE as Vector2i
