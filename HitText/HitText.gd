extends Label

onready var TweenNode = $Tween
var value = 1
var baseSize = 16
var size = 16

func incrementHit(value):
	match value:
		1:
			text = "1 Hit"
			changeFontSize(16)
			changeColor(Color.white)
			changeModuleColor(Color(1, 1, 1, 1))
			MoveLeft()
		2:
			text = "2 Hits"
			changeFontSize(20)
		3:
			#Aca va el sonido
			text = "3 Hits"
			power()
			changeFontSize(25)
		_:
			MoveRight()

func toChange(value):
	match value:
		0:
			MoveRight()
		1:
			text = "1 Hit"
			size = baseSize
			changeColor(Color.white)
			changeModuleColor(Color(1, 1, 1, 1))
			changeFontSize(size)
			MoveLeft()
		_:
			text = str(value) + " Hit"
			size += 3
			changeFontSize(min(size, 25))
			if(value == 3):
				#Aca va el sonido
				power()

func MoveLeft():
	var newPos = Vector2(get_rect().position.x - 500, get_rect().position.y)
	TweenNode.interpolate_property(self, "rect_position", get_rect().position, newPos, 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
	TweenNode.start()

func MoveRight():
	var newPos = Vector2(get_rect().position.x + 500, get_rect().position.y)
	TweenNode.interpolate_property(self, "rect_position", get_rect().position, newPos, 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
	TweenNode.start()

func power():
	changeModuleColor(Color(1.5, 1.5, 1.5, 1))
	changeColor(Color.red)

func changeFontSize(value):
	get("custom_fonts/font").set("size", value)

func changeColor(color):
	set("custom_colors/font_color", color)

func changeModuleColor(color):
	set("modulate", color)