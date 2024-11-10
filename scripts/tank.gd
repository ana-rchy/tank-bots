class_name Tank extends StaticBody2D

enum Direction {UP, UP_RIGHT, RIGHT, DOWN_RIGHT, DOWN, DOWN_LEFT, LEFT, UP_LEFT}

@export var bullet_scene: PackedScene

var _hp := 5
var _charges := 0

func move(dir_enum: Direction):
    var dir = _dir_to_vector(dir_enum)

    position += dir

func shoot(dir_enum: Direction):
    var dir = _dir_to_vector(dir_enum)
    var bullet = bullet_scene.instantiate()
    
    bullet.dir = dir

    add_child(bullet)

func charge():
    _charges = mini(_charges + 1, 2)

func get_enemy_position() -> Vector2:
    return Vector2.ZERO

func _dir_to_vector(dir: Direction) -> Vector2:
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
