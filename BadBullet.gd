extends RigidBody2D

class_name BadBullet

export var speed = 300

func _on_Visibility_screen_exited():
    queue_free()

func _on_RigidBody2D_body_entered(body):
    queue_free()
