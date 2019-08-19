extends Node

export (PackedScene) var GoodBullet
export (PackedScene) var Mob
export (PackedScene) var Player
var score = 0
var highscore = 0
var time = 0
var hightime = 0
var shooting
signal dive
var difficulty = 2.34
var mobtimerwaittime = 0.5

func _ready():
    randomize()

func game_over():
    $MobTimer.stop()
    $HUD.show_game_over()
    $ScoreTimer.stop()
    $DifficultyTimer.stop()
    if (score > highscore):
        highscore = score
    if (time > hightime):
        hightime = time

func new_game():
    score = 0
    time = 0
    difficulty = 2.34
    mobtimerwaittime = 0.5
    $Player.start($StartPosition.position)
    $StartTimer.start()
    $HUD.update_score(score)
    $HUD.update_time(time)
    $HUD.show_message("Get Ready")

func _on_StartTimer_timeout():
    $ScoreTimer.start()
    $MobTimer.start()
    $StartTimer.stop()
    $DiveTimer.start()
    $DifficultyTimer.start()

func _on_MobTimer_timeout():
    # Choose a random location on Path2D.
    $MobPath/MobSpawnLocation.set_offset(randi())
    # Create a Mob instance and add it to the scene.
    var mob = Mob.instance()
    mob.difficulty = difficulty
    add_child(mob)
    mob.connect("mobhit",self,"mobhit")
    $Player.connect("hit", mob, "hit")
    connect("dive", mob, "dive")
    mob.position = $MobPath/MobSpawnLocation.position
    mob.rotation = PI/2

func mobhit():
    score += 1
    $HUD.update_score(score)

func _input(event):
    if event.is_action_pressed("ui_select"):
        shooting = true
    if event is InputEventScreenTouch:
        if event.is_pressed():
            shooting = true

func _process(delta):
    if (shooting):
        # Create a Mob instance and add it to the scene.
        var bullet = GoodBullet.instance()
        add_child(bullet)
        bullet.position = $Player.position
        shooting = false


func _on_DiveTimer_timeout():
    emit_signal("dive")
    difficulty *= 0.9
    $DiveTimer.start()

func _on_ScoreTimer_timeout():
    time += 1
    $HUD.update_time(time)

func _on_DifficultyTimer_timeout():
    $MobTimer.wait_time = mobtimerwaittime * 0.95
