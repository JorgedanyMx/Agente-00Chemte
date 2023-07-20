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
	var numeroAleatorio = randf()
	var randomPich = 0.9 + numeroAleatorio * 0.2
	$Menu/AudioMenu.pitch_scale=randomPich
	if (isPause):
		$"../Game".swPause(true)
		var clipSound=load("res://Audio/TelonDown.wav")
		$Menu/AudioMenu.stream=clipSound
		$Menu/AudioMenu.play()
		$Menu.visible=true
		$HUD.visible=false
		$Menu/MenuAnim.play("OpenMenu")
	else:
		$Menu/MenuAnim.play("CloseMenu")
		var clipSound = load("res://Audio/TelonUP.wav")
		$Menu/AudioMenu.stream=clipSound
		$Menu/AudioMenu.play()
		$"../Game".swPause(false)
		#$Menu.visible=false
		$HUD.visible=true
		

func _on_continuar_pressed():
	isPause=false
	swPause()
