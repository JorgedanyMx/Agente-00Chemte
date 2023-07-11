extends Control

var show_button=false
var line={}
var maindata=[]
var path = "res://data/GGprueba.json"
var currentCap=""
var endHistory=false
var initialPosition: Vector2
var initialRotation
var initialMousePosition: Vector2
var pressed = false
var deltaPos=Vector2.ZERO
var leftChoise=false
var rightChoise=false
var canSwipe=true

func _ready():
	maindata = Get_data()
	currentCap=maindata[maindata.keys()[0]]
	line=currentCap["1"]
	initialPosition = $Panel/currentCard.position
	initialRotation = $Panel/currentCard.rotation
	showCard(line)
	$Panel/bankCard.flipBack()
	$Panel/currentCard.flipFront()
	$Panel/currentCard.changeAlphaDer(0)
	$Panel/currentCard.changeAlphaIzq(0)


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:  # Se presionó el botón izquierdo del mouse
				pressed = true
				initialMousePosition= get_local_mouse_position()
			else:  # Se soltó el botón izquierdo del mouse
				pressed = false

# Called every frame. 'delta' is the elapsedus frame.
func _process(delta):
	if(!endHistory):
		if (Input.is_action_just_pressed("ui_left")):
			pass
		if (Input.is_action_just_pressed("ui_right")):
			pass
	swipeChoise(delta)

func swipeChoise(delta):
	if (pressed):
		var mousePosition = get_local_mouse_position()
		deltaPos= (mousePosition - initialMousePosition)  # Sumar el movimiento relativo del mouse a la posición de la carta
		if(abs(deltaPos.x)<=300):
			$Panel/currentCard.rotation = (deltaPos.x/300)*.8
			$Panel/currentCard.position =	initialPosition + deltaPos
			if(abs(deltaPos.x)<=100):
				if(deltaPos.x<-1):
					$Panel/currentCard.changeAlphaDer(abs(deltaPos.x)/100)
					$Panel/currentCard.changeAlphaIzq(0)
				elif(deltaPos.x>1):
					$Panel/currentCard.changeAlphaIzq(abs(deltaPos.x)/100)
					$Panel/currentCard.changeAlphaDer(0)
		
			
	else:
		if(abs(deltaPos.x) >= 100):
			choiseAnswer(deltaPos.x)
		# Mover la carta suavemente hacia la posición inicial
		deltaPos = Vector2.ZERO
		$Panel/currentCard.changeAlphaDer(abs(deltaPos.x)/100)
		$Panel/currentCard.changeAlphaIzq(abs(deltaPos.x)/100)
		var easeAmount = 10
		$Panel/currentCard.position += (initialPosition - $Panel/currentCard.position) * easeAmount*delta
		$Panel/currentCard.rotation += (initialRotation - $Panel/currentCard.rotation) * easeAmount*delta	

func choiseAnswer(posx):
	if(posx>0):
		getGuionLine(line["Diálogo A - ID"])
		print("\n\n Opcion A")
	else:
		if line["Diálogo B - ID"]!=null:
			print("\n\n Opcion B")
			getGuionLine(line["Diálogo B - ID"])
		else:
			getGuionLine(line["Diálogo A - ID"])
			print("\n\n Opcion B")

#Funcion para obetener el indice
func findLine(dictionary: Dictionary, key):
	if dictionary.has(str(key)):
		return dictionary[str(key)]
	else:
		return null

func  Get_data():
	if FileAccess.file_exists(path):
		var datafile =FileAccess.open(path,FileAccess.READ)
		var parsedResult = JSON.parse_string(datafile.get_as_text())
		if parsedResult is Dictionary:
			return parsedResult
		else:
			print("error reading file")
		datafile.close()
	else:
		print("File doesnt exist!")

	
func showCard(nextLine):
	print(nextLine)
	if(nextLine!=null):
		$Panel/Dialogo1.text= nextLine["Pregunta"]
		$Panel/Dialogo2.text= "Personaje: "+ nextLine["Personaje"]
		$Panel/currentCard.flipFront()
		if nextLine["R A"]!=null:
			$Panel/currentCard.infoCard(nextLine["R A"],nextLine["R B"],nextLine["Background Color"],nextLine["Imagen URL"])
		else:
			$Panel/currentCard.infoCard("mmm...","mmm...",nextLine["Background Color"],nextLine["Imagen URL"])
		if(nextLine["Imagen URL"]!=null):
			$Panel/currentCard.setImg(nextLine["Imagen URL"])
		if(nextLine["Background Color"]!=null):
			pass
	
func getGuionLine(idxNextLine):
	var nextLine=findLine(currentCap,idxNextLine)
	if( nextLine==null or nextLine["Pregunta"]==null):
		nextLine=line
	line=nextLine
	showCard(line)
