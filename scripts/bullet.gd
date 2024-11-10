extends Area2D

var damage := 1
var dir: Vector2

func _ready():
    position += dir

func _on_turn():
    position += dir

func _on_body_entered(body: Node2D):
    if (body is Tank):
        var tank = body as Tank

        tank._hp -= 1
    
    free()
