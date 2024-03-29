extends CanvasLayer

signal start_game

func show_message(text):
    $MessageLabel.text = text
    $MessageLabel.show()
    $MessageTimer.start()

func show_game_over():
    show_message("Game Over")
    yield($MessageTimer, "timeout")
    $MessageLabel.text = "Shoot the aliens to get points. Don't get hit by anything. Arrows to move and Space to shoot."
    $MessageLabel.show()
    yield(get_tree().create_timer(1), 'timeout')
    $StartButton.show()

func update_score(score):
    $ScoreLabel.text = str(score)

func update_time(time):
    $TimeLabel.text = str(time)
    
func _on_StartButton_pressed():
    $StartButton.hide()
    emit_signal("start_game")

func _on_MessageTimer_timeout():
    $MessageLabel.hide()
