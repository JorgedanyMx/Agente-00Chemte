extends Control

var isPause=false


func _ready():
	$Menu.visible=false

func _on_btn_menu_pressed():
	isPause=true
	swPause()

func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_menu"):
			isPause=!isPause
			swPause()
func swPause():
	if (isPause):
		$Menu.visible=true
		$HUD.visible=false
	else:
		$Menu.visible=false
		$HUD.visible=true


func _on_continuar_pressed():
	isPause=false
	swPause()
