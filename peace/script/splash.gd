extends CanvasLayer

func _ready():
	# เชื่อมสัญญาณ animation finish
	$Animator.animation_finished.connect(_on_animation_finished)
	$Fader.modulate = Color(0, 0, 0, 1)  # เริ่มจอดำ
	$Fader.create_tween().tween_property($Fader, "modulate", Color(0, 0, 0, 0), 1.0)

	await get_tree().create_timer(3.0).timeout
	$Fader.create_tween().tween_property($Fader, "modulate", Color(0, 0, 0, 1), 1.0)

	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://main.tscn")
	

func _on_animation_finished(anim_name: String):
	if anim_name == "fade_in":
		$SplashTimer.start()  # เริ่มจับเวลาหลัง fade_in เสร็จ
	elif anim_name == "fade_out":
		get_tree().change_scene_to_file("res://main.tscn")

func _on_splash_timer_timeout():
	$Animator.play("fade_out")


func _input(event):
	if event.is_action_pressed("ui_cancel"): 
		get_tree().quit()
