extends Area2D

class_name Mob
export (PackedScene) var BadBullet
signal mobhit
const hover_speed = 100
const hover_height = 150
const speed = 200
var velocity = Vector2(0,speed)
const mob_types = ["walk", "swim", "fly"]
enum MM {DROP, HOVER, DIVE}
var mob_mode = MM.DROP
var difficulty = 2.34


func _ready():
    $BulletTimer.wait_time = difficulty
    print("dif", difficulty)
    $BulletTimer.start()
    $AnimatedSprite.play()
    $AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

func _on_Visibility_screen_exited():
    queue_free()

func _on_Timer_timeout():
    var bullet = BadBullet.instance()
    get_parent().add_child(bullet)
    bullet.position = position
    bullet.velocity = bullet.velocity.rotated(rand_range(-PI/8, PI/8))

func _process(delta):
    if (mob_mode == MM.DROP):
        position += velocity * delta
        if (position.y >= hover_height):
            position.y = hover_height
            mob_mode = MM.HOVER
            velocity = Vector2(hover_speed,0)
    if (mob_mode == MM.HOVER):
        position += velocity * delta
        if (position.x >= 1014):
            velocity.x = -hover_speed
        if (position.x <= 10):
            velocity.x = hover_speed
    if (mob_mode == MM.DIVE):
        position += velocity * delta

func dive():
    velocity.x = 0
    velocity.y = speed
    velocity = velocity.rotated(rand_range(-PI/6, PI/6))
    $DirectionTimer.start()

func _bullethit(area):
    if (area is GoodBullet):
        queue_free()
        emit_signal("mobhit")
        area.die()

func hit():
    queue_free()


func _on_DirectionTimer_timeout():
    velocity = velocity.rotated(rand_range(-PI/8, PI/8))
