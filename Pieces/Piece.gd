extends Node2D

export (String) var color
var is_matched
var is_counted
var selected = false
var target_position = Vector2.ZERO

var Effects = null
var dying = false
var wiggle = 0.0
var sfx1 = null
var sfx2 = null
var sfx3 = null

export var wiggle_amount = 3

var Coin = preload("res://Coin/Coin.tscn")
export var transparent_time = 1.0
export var scale_time = 1.5
export var rot_time = 1.5



func _ready():
	$Tween.interpolate_property(self, "scale", Vector2(0,0), Vector2(1,1), 0.25, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Tween.start()
	$Select.texture = $Sprite.texture
	$Select.scale = $Sprite.scale
	if sfx2 == null:
		sfx2 = get_node_or_null("/root/Game/2")
	if sfx2 != null:
		sfx2.play()

func _physics_process(_delta):
	if dying:
		queue_free()
	elif position != target_position:
		position = target_position
	if selected:
		$Select.show()
		$Selected.emitting = true
	else:
		$Select.hide()
		$Selected.emitting = false

func generate(pos):
	position = Vector2(pos.x,-100)
	target_position = pos
	if sfx1 == null:
		sfx1 = get_node_or_null("/root/Game/1")
	if sfx1 != null:
		sfx1.play()

func move_piece(change):
	$Tween.interpolate_property(self, "scale", Vector2(2,2), Vector2(1,1), 0.25, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	$Tween.start()
	if sfx3 == null:
		sfx3 = get_node_or_null("/root/Game/3")
	if sfx3 != null:
		sfx3.play()
	target_position = target_position + change

func die():
	dying = true;
	if Effects == null:
		Effects = get_node_or_null("/root/Game/Effects")
	if Effects != null:
		var coin = Coin.instance()
		coin.position = target_position
		Effects.add_child(coin)
