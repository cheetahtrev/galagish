extends Area2D

class_name Player

signal hit

export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.

func _process(delta):
    position = get_viewport().get_mouse_position()
    var velocity = Vector2()  # The player's movement vector.
    if Input.is_action_pressed("ui_right"):
        velocity.x += 1
    if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
    if Input.is_action_pressed("ui_down"):
        velocity.y += 1
    if Input.is_action_pressed("ui_up"):
        velocity.y -= 1
    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        $AnimatedSprite.play()
    else:
        $AnimatedSprite.stop()
    position += velocity * delta
    position.x = clamp(position.x, 0, screen_size.x)
    position.y = clamp(position.y, 0, screen_size.y)
    if velocity.x != 0:
        $AnimatedSprite.animation = "right"
        $AnimatedSprite.flip_v = false
    # See the note below about boolean assignment
        $AnimatedSprite.flip_h = velocity.x < 0
    elif velocity.y != 0:
        $AnimatedSprite.animation = "up"
        $AnimatedSprite.flip_v = velocity.y > 0

func _ready():
    hide()
    screen_size = get_viewport_rect().size

func _die():
    hide()
    emit_signal("hit")
    $CollisionShape2D.set_deferred("disabled", true) # Replace with function body.

func start(pos):
    position = pos
    show()
    $CollisionShape2D.disabled = false
    
func _bullethit():
    _die()


func _on_Player_area_entered(area):
    if (area is Mob):
        _die()
