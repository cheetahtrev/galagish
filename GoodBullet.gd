extends Area2D

class_name GoodBullet

var speed = 400
var velocity = Vector2(0,-speed)

func _on_Visibility_screen_exited():
    queue_free()

func _on_RigidBody2D_body_entered(body):
    print("gb", body)
    if (body is Mob):
        queue_free()
        body._bullethit()

func _process(delta):
    position += velocity * delta