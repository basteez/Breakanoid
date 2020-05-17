#extends Node2D
#
#var sprite;
#func _ready() -> void:
#	sprite = $sprite;
#	
#	# This gives you an ImageTexture
#	var image_texture_resource = sprite.texture
#	
#	# This gives you an Image
#	var image = image_texture_resource.get_data()
#	print(image)
#	# This gives you a pixel (check the doc)
#	#image.get_pixel(x, y)
#	#for i in range(image.get_width()):
#	#	for j in range(image.get_height()):
#	#		print(image.get_pixel(i,j))
#	
#	print(image.get_pixel(1,1))
#	
#	pass
extends Node2D

var pixels : Array = []

func _ready():
	var texture : Texture = $sprite.texture
	var size : Vector2 = texture.get_size()
	var image : Image = texture.get_data()
	var blockScene = preload("res://GameObjects/Block.tscn")
	
#	blocca l'immagine per operazioni in lettura
	image.lock()
	
	for x in range(0,size.x):
		for y in range (0,size.y):
			var pixel = image.get_pixel(x,y)
			pixels.append([Vector2(x,y),pixel])
			
#	Sblocca l'immagine
	image.unlock()
	for pixel in pixels:
		if pixel[1].a == 1:
			print(pixel)
			var newBlock = blockScene.instance()
			newBlock.position = pixel[0] * 32 + Vector2(get_viewport().size.x/2, 200) - Vector2(newBlock.get_node("Sprite").texture.get_size().x, 0) - Vector2(32, 0)
			newBlock.set_modulate(pixel[1])
			get_tree().get_root().get_node("GameScene").get_node("Blocks").add_child(newBlock)
