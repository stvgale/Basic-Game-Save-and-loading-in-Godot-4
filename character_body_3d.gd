extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _ready():
	load_player_state()
	
func _physics_process(delta):
	# Add gravity if the player is not on the floor.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input direction (WASD or arrow keys) and move the character.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		# If no input, smoothly decelerate.
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func save_player_state():
	if SaveSystem.current_data.has("player"):
		SaveSystem.current_data["player"].position = global_position
		SaveSystem.save_game()

func load_player_state():
	var data = SaveSystem.current_data.get("player", null)
	if data:
		global_position = data.position


func _on_save_pressed():
	save_player_state()

func _on_load_pressed():
	load_player_state()
