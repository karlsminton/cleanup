extends CharacterBody3D

class_name PlayerMovement

var node : CharacterBody3D;

var max_speed = 10;
var target_velocity = Vector3.ZERO;


func _init(this: CharacterBody3D) -> void:
	node = this;
	pass;

func _input(event: InputEvent) -> void:
	if not is_instance_of(event, InputEventKey):
		return;

	var key = getKey(event);

	if key == 'Escape':
# 		# todo - this kills the game, we need this to display over the top of the current scene
		node.get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn");

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
	node.velocity = target_velocity;
	node.move_and_slide();

func getKey(event: InputEventKey) -> String:
	var keycode = DisplayServer.keyboard_get_keycode_from_physical(event.physical_keycode)
	return OS.get_keycode_string(keycode);

func _exit_tree() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
