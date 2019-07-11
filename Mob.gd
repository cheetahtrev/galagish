extends RigidBody2D

class_name Mob
export (PackedScene) var BadBullet
signal mobhit

export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.
var mob_types = ["walk", "swim", "fly"]

func _ready():
    $Timer.start()
    $AnimatedSprite.play()
    $AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

func _on_Visibility_screen_exited():
    queue_free()


func _bullethit():
    queue_free()
    emit_signal("mobhit")


func _on_Timer_timeout():
    var bullet = BadBullet.instance()
    get_parent().add_child(bullet)
    bullet.position = position