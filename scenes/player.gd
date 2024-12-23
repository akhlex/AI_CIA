extends CharacterBody2D


const SPEED = 300.0
@onready var actionable_finder: Area2D = $Direction/ActionableFinder


func _physics_process(delta):

	var dir_h = Input.get_axis("left", "right")
	var dir_v = Input.get_axis("up", "down")
	
	
	if dir_h:
		velocity.x = dir_h * SPEED
		$AnimatedSprite2D.play("run")
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
	elif dir_v:
		velocity.y = dir_v * SPEED
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")
		velocity.y = move_toward(velocity.y, 0, SPEED)
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return
		return
