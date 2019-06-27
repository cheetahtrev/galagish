extends Node

export (PackedScene) var GoodBullet
export (PackedScene) var Mob
var score

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
    # Set the mob's direction perpendicular to the path direction.
    var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
    # Set the mob's position to a random location.
    mob.position = $MobPath/MobSpawnLocation.position
    mob.rotation = direction
    # Set the velocity (speed & direction).
    mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
    mob.linear_velocity = mob.linear_velocity.rotated(direction)

func mobhit():
    score += 1
    $HUD.update_score(score)

func _on_Player_shoot():
    # Create a Mob instance and add it to the scene.
    var bullet = GoodBullet.instance()
    add_child(bullet)
    # Set the mob's direction perpendicular to the path direction.
    var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
    # Set the mob's position to a random location.
    bullet.position = $Player.position
    bullet.rotation = direction
    # Set the velocity (speed & direction).
    bullet.linear_velocity = Vector2(GoodBullet.speed, 0)
    bullet.linear_velocity = bullet.linear_velocity.rotated(direction)