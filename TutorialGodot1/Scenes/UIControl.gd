extends Control

var isPause=false
var telonDown=load("res://Audio/TelonDown.wav")
var menuUP = load("res://Audio/menuSube.wav")
func _ready():
	$Menu.visible=true
	var gameNode = get_node("../Game")
	gameNode.OpenMenu.connect(OpenMenu)
	gameNode.CloseMenu.connect(CLoseMenu)
	
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
		$Menu/AudioMenu.stream=telonDown
		$Menu/AudioMenu.play()
		$Menu/MenuAnim.play("OpenMenu")
	else:
		$Menu/MenuAnim.play("CloseMenu")
		$Menu/AudioMenu.stream=menuUP
		$Menu/AudioMenu.play()
		$"../Game".swPause(false)
func _on_continuar_pressed():
	isPause=true
	swPause()
	
func OpenMenu():
	isPause=true
	swPause()
func CLoseMenu():
	isPause=false
	swPause()
