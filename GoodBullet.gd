extends Area2D

class_name GoodBullet

var speed = 400
var velocity = Vector2(0,-speed)

func _on_Visibility_screen_exited():
    queue_free()

func _process(delta):
    position += velocity * delta

func die():
    queue_free()