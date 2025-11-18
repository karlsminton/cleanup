extends CharacterBody3D
# Camera
const LOOKAROUND_SPEED = 0.001;
var rot_x = 0;
var rot_y = 0;
# PlayerMovement
var target_velocity: Vector3; 
var max_speed: int = 5;


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	target_velocity = Vector3.ZERO;

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		rot_x += event.relative.x * LOOKAROUND_SPEED;
		
		# todo - check these clamp values, difficult to determine at this time
		if rot_y + event.relative.y * LOOKAROUND_SPEED > -1.8 and rot_y + event.relative.y * LOOKAROUND_SPEED < 1.8:
			rot_y += event.relative.y * LOOKAROUND_SPEED;
		
		$View.transform.basis = Basis();
		$Node3D.transform.basis = Basis();
		
		$View.rotate_object_local(Vector3(0, 1, 0), rot_x);
		$View.rotate_object_local(Vector3(1, 0, 0), rot_y);
		
		$Node3D.rotate_object_local(Vector3(0, 1, 0), $View.rotation.y);
	
	if is_instance_of(event, InputEventKey):
		var key = getKey(event);

		if key == 'Escape':
# 		# todo - this kills the game, we need this to display over the top of the current scene
			get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn");
		

func getKey(event: InputEventKey) -> String:
	var keycode = DisplayServer.keyboard_get_keycode_from_physical(event.physical_keycode)
	return OS.get_keycode_string(keycode);

func _physics_process(_delta) -> void:
	var direction = Vector3.ZERO;
	
	if Input.is_key_label_pressed(KEY_W):
		direction.z = -1;
	
	if Input.is_key_label_pressed(KEY_A):
		direction.x = -1;
	
	if Input.is_key_label_pressed(KEY_D):
		direction.x = 1;
		
	if Input.is_key_label_pressed(KEY_S):
		direction.z = 1;
		
	direction = direction.normalized();
	target_velocity.x = direction.x * max_speed;
	target_velocity.z = direction.z * max_speed;
	target_velocity.y = 0;
	velocity = $View.global_transform.basis * target_velocity;
	velocity.y = 0; # todo - probably shouldn't have to 0 this here (possible issues implementing jump)
	move_and_slide();

func _exit_tree() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
