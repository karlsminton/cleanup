extends CharacterBody3D

# Prefixing variables as they're not actually needed
var _a = load("res://Scripts/Player/Camera.gd");
var _b = load("res://Scripts/Player/PlayerMovement.gd");

var camera;
var control;

func _ready() -> void:
	print_debug('player.gd happened');
	camera = PlayerCamera.new(self);
	control = PlayerMovement.new(self);

func _input(event: InputEvent) -> void:
	camera._input(event);
	control._input(event);

func _physics_process(delta: float) -> void:
	control._physics_process(delta);

func _exit_tree() -> void:
	control._exit_tree();
