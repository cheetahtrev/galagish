extends Node

export (PackedScene) var GoodBullet
export (PackedScene) var Mob
var score = 0
var shooting

func _ready():
    randomize()

func game_over():
    $MobTimer.stop()
    print("Mob Timer Stopped")
    $HUD.show_game_over()

func new_game():
    print("New Game")
    score = 0
    $Player.start($StartPosition.position)
    $StartTimer.start()
    $HUD.update_score(score)
    $HUD.show_message("Get Ready")

func _on_StartTimer_timeout():
    $MobTimer.start()
    $StartTimer.stop()
    print("Start Timer Ended")

func _on_MobTimer_timeout():
    # Choose a random location on Path2D.
    $MobPath/MobSpawnLocation.set_offset(randi())
    # Create a Mob instance and add it to the scene.
    var mob = Mob.instance()
    add_child(mob)
    mob.connect("mobhit",self,"mobhit")
    # Set the mob's direction perpendicular to the path direction.
    var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
    # Set the mob's position to a random location.
    mob.position = $MobPath/MobSpawnLocation.position
    mob.rotation = direction
    # Set the velocity (speed & direction).
    mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
    mob.linear_velocity = mob.linear_velocity.rotated(direction)

func mobhit():
    print("mobhit")
    score += 1
    $HUD.update_score(score)

func _input(event):
    if event.is_action_pressed("ui_select"):
        shooting = true
    if event.is_action_released("ui_select"):
        shooting = false

func _process(delta):
    if (shooting):
        # Create a Mob instance and add it to the scene.
        var bullet = GoodBullet.instance()
        add_child(bullet)
        bullet.position = $Player.position
        shooting = false

