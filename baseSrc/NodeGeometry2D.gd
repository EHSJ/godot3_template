tool
class_name Geometry2D
extends CollisionShape2D

export (bool) var draw = true setget set_draw
export (Color) var color = Color(1, 1, 1, 1) setget set_color

export (bool) var iborder = true setget set_border
export (int) var bwide = 5 setget set_bwide
export (Color) var bcolor = Color(.5, .5, .5, 1) setget set_bcolor

# SETERS / GETTERS

func set_draw(new_state):
	draw = new_state
	update()

func set_color(new_color):
	color = new_color
	update()

func set_border(new_state):
	iborder = new_state
	update()

func set_bwide(new_wide):
	bwide = new_wide
	update()

func set_bcolor(new_bcolor):
	bcolor = new_bcolor
	update()

func _ready():
	update()

func _draw():

	# Exit if disabled
	if (!draw): return

	# For CollisionShape2D's offset_position
	var offset_position = Vector2(0, 0)

	# Draw Full Backgrounnd shape
	if shape is CircleShape2D:
		draw_circle(offset_position, shape.radius, color)
	elif shape is RectangleShape2D:
		var rect = Rect2(offset_position - shape.extents, shape.extents * 2.0)
		draw_rect(rect, color)
	elif shape is CapsuleShape2D:
		var upper_circle_position = offset_position + Vector2(0, shape.height * 0.5)
		draw_circle(upper_circle_position, shape.radius, color)
		var lower_circle_position = offset_position - Vector2(0, shape.height * 0.5)
		draw_circle(lower_circle_position, shape.radius, color)
		var rect_position = offset_position - Vector2(shape.radius, shape.height * 0.5)
		var rect = Rect2(rect_position, Vector2(shape.radius * 2, shape.height))
		draw_rect(rect, color)

# Draw Foreground shape
	if iborder:
		if shape is CircleShape2D:
			draw_circle(offset_position, shape.radius - bwide, bcolor)
		elif shape is RectangleShape2D:
			var rect = Rect2(offset_position - shape.extents + Vector2(bwide, bwide),
					(shape.extents * 2.0) - Vector2(bwide * 2.0,bwide * 2.0))
			draw_rect(rect, bcolor)
		elif shape is CapsuleShape2D:
			var upper_circle_position = offset_position + Vector2(0, shape.height * 0.5)
			draw_circle(upper_circle_position, shape.radius - bwide, bcolor)
			var lower_circle_position = offset_position - Vector2(0, shape.height * 0.5)
			draw_circle(lower_circle_position, shape.radius - bwide, bcolor)
			var rect_position = offset_position - Vector2(shape.radius, shape.height * 0.5)
			var rect = Rect2(rect_position + Vector2(bwide, 0), 
					Vector2(shape.radius * 2 - bwide*2, shape.height))
			draw_rect(rect, bcolor)

func _on_draw():
	update()