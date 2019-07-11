extends Area2D

signal hit
class_name BadBullet

var speed = 300
var velocity = Vector2(0,speed)

func _on_Visibility_screen_exited():
    queue_free()

func _on_Area2D_body_entered(body):
    #print("bb", get_parent(), body)
    if (body is Player):
        queue_free()
        body._bullethit()

func _process(delta):
    position += velocity * delta