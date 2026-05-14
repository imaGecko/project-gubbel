extends StaticBody2D

func _ready() -> void:
	update_collision()

func update_collision():
	var rectangle = $ColorRect
	var collision = $PhysicsCollision
	var shape = RectangleShape2D.new();
	shape.size = rectangle.size
	collision.shape = shape
