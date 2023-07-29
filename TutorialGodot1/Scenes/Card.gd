extends Container

class_name Card

var linkChar = ""
var bgCikir = ""
var resIzq = ""
var resDer = ""
var pensamientosCard = load("res://Sprites/Game/Narrativa.png")
var cardBg =load("res://Sprites/Game/cartaupd.png")

func _ready():
	changeAlphaDer(0)
	changeAlphaIzq(0)

func infoCard(resp1,resp2):
	#$Front.texture=cardBg as Texture 
	changeAlphaIzq(1)
	changeAlphaDer(1)
	$Front/Content/RespDer/txtRespDer.text=resp1
	if(resp2!=null):
		$Front/Content/RespIzq/txtRespIzq.text=resp2
	else:
		$Front/Content/RespIzq/txtRespIzq.text=resp1

func setBgColor(bgColor):
	if(bgColor!=null):
		$Front.self_modulate = Color("#"+bgColor)

func flipFront():
	$AnimationPlayer.play("FlipFront")
	var numeroAleatorio = randf()
	var randomPich = 0.9 + numeroAleatorio * 0.2
	$AudioStreamPlayer.pitch_scale=randomPich
	$AudioStreamPlayer.stream= load("res://Audio/Card2.wav");
	$Front/Content/RespDer.visible=true
	$Front/Content/RespIzq.visible=true
	
func changeAlphaIzq(alp):
	var color=$Front/Content/RespIzq.modulate
	color.a=alp
	$Front/Content/RespIzq.modulate=color
	
	
func changeAlphaDer(alp):
	var color=$Front/Content/RespDer.modulate
	color.a=alp
	$Front/Content/RespDer.modulate=color
	
	
func flipBack():
	$Back.visible=true
	$Front.visible=false
	
func setImg(urlImg):
	$Front/Narrativa.text=""
	$Front/Content.visible=true
	
	var imgNew=load("res://Sprites/"+urlImg)
	if(imgNew!=null):
		$Front/Content.texture=load("res://Sprites/"+urlImg) as Texture 
	
func dontRotate():
	$Front/Content/RespDer.global_rotation=0
	$Front/Content/RespIzq.global_rotation=0

func SoundFlip():
	$AudioStreamPlayer.play()

func showNarrativa(textL):
	Pensamientos()
	$Front/Content.visible=false
	#$Front.self_modulate = Color("#d1cdc4")
	$Front/Narrativa.text="[center]"+textL+ "[/center]"

func Pensamientos():
	$Front.texture=pensamientosCard as Texture 

func imgCard():
	$Front.texture=cardBg as Texture 
