extends RigidBody2D

signal blockBroken;
onready var ballScene =  preload("res://GameObjects/Ball.tscn");

func _ready() -> void:
	pass
	
func _on_Block_body_entered(body: Node) -> void:
	if(body.get_filename() == ballScene.get_path()):
		emit_signal("blockBroken");
		queue_free()
