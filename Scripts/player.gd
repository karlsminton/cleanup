extends CharacterBody3D

const LOOKAROUND_SPEED = 0.001;

var camera: Camera3D
var rot_x = 0
var rot_y = 0

func _ready() -> void:
	camera = $View
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var k = DisplayServer.keyboard_get_keycode_from_physical(event.physical_keycode)
		var keycode = OS.get_keycode_string(k)
		
		if keycode == 'Escape':
			get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	
	if event is InputEventMouseMotion:
		rot_x += event.relative.x * LOOKAROUND_SPEED
		
		# todo - check these clamp values, difficult to determine at this time
		if rot_y + event.relative.y * LOOKAROUND_SPEED > -1.8 and rot_y + event.relative.y * LOOKAROUND_SPEED < 1.001:
			rot_y += event.relative.y * LOOKAROUND_SPEED
		
		camera.transform.basis = Basis()
		
		print_debug(rot_y)
		camera.rotate_object_local(Vector3(0, 1, 0), rot_x)
		camera.rotate_object_local(Vector3(1, 0, 0), rot_y)

func _exit_tree() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
