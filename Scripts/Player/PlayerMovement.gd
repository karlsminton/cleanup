extends CharacterBody3D

class_name PlayerMovement

var node;

var max_speed = 100;
var target_velocity = Vector3.ZERO;


func _init(this: CharacterBody3D) -> void:
	node = this;
	pass;

func _input(event: InputEvent) -> void:
	if not is_instance_of(event, InputEventKey):
		return;

	var key = getKey(event);

	if key == 'Escape':
		# todo - this kills the game, we need this to display over the top of the current scene
		node.get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn");

	if key == 'W':
		var direction = Vector3.ZERO;
		direction.z -= 1;
		direction.normalized();

		target_velocity.x = direction.x * max_speed;
		target_velocity.z = direction.z * max_speed;
		node.velocity = direction;

		node.move_and_slide();
		return;
		# node;

	print_debug(key);
	return;

func getKey(event: InputEventKey) -> String:
	var keycode = DisplayServer.keyboard_get_keycode_from_physical(event.physical_keycode)
	return OS.get_keycode_string(keycode);

func _exit_tree() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
