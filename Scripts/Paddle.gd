extends RigidBody2D

signal game_started;
onready var ballScene =  load("res://GameObjects/Ball.tscn")
export var isVertical = false;

var half_sprite_width;

func _ready() -> void:
	half_sprite_width = ($Sprite.texture.get_size().x*$Sprite.get_scale().x)/2;

func _physics_process(_delta: float) -> void:
	if(isVertical):
		position = Vector2(position.x, clamp(get_global_mouse_position().y, half_sprite_width, get_viewport_rect().size.y - half_sprite_width));
	else:
		position = Vector2(clamp(get_global_mouse_position().x, half_sprite_width, get_viewport_rect().size.x - half_sprite_width), position.y);


func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("startGame")):
		emit_signal("game_started");
	if(Input.is_action_just_pressed("spawnBall") and self.name=="Paddle"):
	#	spawn_ball();
		pass

func spawn_ball():
	var newBall = ballScene.instance();
	newBall.position = Vector2(position.x, position.y-35);
	connect('game_started', newBall, '_on_Paddle_game_started')
	get_tree().get_root().get_node("GameScene").get_node("Balls").add_child(newBall)
	emit_signal("game_started")
	pass
