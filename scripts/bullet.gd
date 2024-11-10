class_name Bullet extends StaticBody2D

var damage := 1
var dir: Vector2i
@onready var collision_mask_backup := collision_mask

func _ready():
	collision_mask = 0

func on_turn():
	var collision = move_and_collide(dir)

	if (collision != null):
		var collider = collision.get_collider()

		if (collider is Tank):
			(collider as Tank)._hp -= damage

		queue_free()
	
	collision_mask = collision_mask_backup
