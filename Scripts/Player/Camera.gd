extends CharacterBody3D

class_name PlayerCamera

const LOOKAROUND_SPEED = 0.001;

var camera_node: Camera3D
var node: Node
var model_bounding_node: Node3D
var rot_x = 0
var rot_y = 0

func _init(this: CharacterBody3D) -> void:
	node = this;
	camera_node = node.get_node('View');
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	model_bounding_node = node.get_node('Node3D');

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		rot_x += event.relative.x * LOOKAROUND_SPEED;
		
		# todo - check these clamp values, difficult to determine at this time
		if rot_y + event.relative.y * LOOKAROUND_SPEED > -1.8 and rot_y + event.relative.y * LOOKAROUND_SPEED < 1.8:
			rot_y += event.relative.y * LOOKAROUND_SPEED;
		
		camera_node.transform.basis = Basis();
		model_bounding_node.transform.basis = Basis();
		
		camera_node.rotate_object_local(Vector3(0, 1, 0), rot_x);
		camera_node.rotate_object_local(Vector3(1, 0, 0), rot_y);
		
		model_bounding_node.rotate_object_local(Vector3(0, 1, 0), camera_node.rotation.y);
