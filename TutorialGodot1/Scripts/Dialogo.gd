extends Control

var show_button=false
var canSwipe=true
var endHistory=false
var pressed = false
var leftChoise=false
var rightChoise=false
var leftfall=true
var isFall=false
var line={}
var maindata=[]
var path = "res://data/GameHistoryCap1.json"
var currentCap=""
var initialPosition: Vector2
var initialMousePosition: Vector2
var deltaPos=Vector2.ZERO
var checkpoint={}
var errors=0
var initialRotation


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
			getGuionLine("53")
		if (Input.is_action_just_pressed("ui_right")):
			pass
	if(canSwipe):
		swipeChoise(delta)
	fallCard(delta)
	

func fallCard(deltaTime):
	if(isFall):
		var speedPos=40
		var speedRot= 20
		$Panel/currentCard.position.y += speedPos/2
		if(leftfall):
			$Panel/currentCard.position.x -= speedPos*deltaTime*80
			$Panel/currentCard.rotation -= deltaTime*speedRot
		else:
			$Panel/currentCard.position.x += speedPos*deltaTime*80
			$Panel/currentCard.rotation += deltaTime*speedRot
		if($Panel/currentCard.position.y>2350):
			$Panel/currentCard.visible=false
			$Panel/currentCard.flipBack()
		if($Panel/currentCard.position.y>2400):
			isFall=false
			$Panel/currentCard.position = initialPosition
			$Panel/currentCard.rotation = 0
			showCard(line)
			$Panel/currentCard.visible=true
			$Panel/currentCard.SoundFlip()

func clamp(value, min_value, max_value):
	return max(min(value, max_value), min_value)

func swipeChoise(delta):
	if (pressed and !isFall):
		var mousePosition = get_local_mouse_position()
		deltaPos= (mousePosition - initialMousePosition)  # Sumar el movimiento relativo del mouse a la posición de la carta
		deltaPos.x=clamp(deltaPos.x,-299,299)
		deltaPos.y=clamp(deltaPos.y,-200,200)
		$Panel/currentCard.rotation = (deltaPos.x/300)*.8
		$Panel/currentCard.dontRotate()
		$Panel/currentCard.position =	initialPosition + deltaPos
		if(abs(deltaPos.x)<=100):
			if(deltaPos.x<-1):
				$Panel/currentCard.changeAlphaDer(abs(deltaPos.x)/100)
				$Panel/currentCard.changeAlphaIzq(0)
			elif(deltaPos.x>1):
				$Panel/currentCard.changeAlphaIzq(abs(deltaPos.x)/100)
				$Panel/currentCard.changeAlphaDer(0)
	else:
		if(abs(deltaPos.x) >= 200):
			choiseAnswer(deltaPos.x)
		# Mover la carta suavemente hacia la posición inicial
		deltaPos = Vector2.ZERO
		$Panel/currentCard.changeAlphaDer(abs(deltaPos.x)/100)
		$Panel/currentCard.changeAlphaIzq(abs(deltaPos.x)/100)
		var easeAmount = 10
		if(!isFall):
			$Panel/currentCard.position += (initialPosition - $Panel/currentCard.position) * easeAmount*delta
			$Panel/currentCard.rotation += (initialRotation - $Panel/currentCard.rotation) * easeAmount*delta
		

func choiseAnswer(posx):
	if(posx<0):#Izquierda
		getGuionLine(line["Diálogo A - ID"])
		isFall=true
		leftfall=true
		#print("\n\n Opcion A")
	else:
		isFall=true
		leftfall=false
		if line["Diálogo B - ID"]!=null:
			#print("\n\n Opcion B")
			getGuionLine(line["Diálogo B - ID"])
		else:
			getGuionLine(line["Diálogo A - ID"])
			#print("\n\n Opcion B")

	

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
	if(nextLine!=null):
		if(nextLine["Personaje"]=="#FINAL"):
			if(errors==0):
				var idx=""+str(nextLine["Pregunta"])
				getGuionLine(idx)
				loadCard(line)
			elif(errors<3):
				var idx=""+str(nextLine["R A"])
				getGuionLine(idx)
				loadCard(line)
			else:
				var idx=""+str(nextLine["R B"])
				getGuionLine(idx)
				loadCard(line)
			#getGuionLine
		else:
			loadCard(nextLine)

func loadCard(nextLine):
	var text = nextLine["Personaje"] + ": " +nextLine["Pregunta"]
	$Panel/Dialogo1.text= nextLine["Personaje"] + ": " +nextLine["Pregunta"]
	$Panel/Dialogo2.text = ""
	$Panel/Dialogo1/DiagAnim.play("Historia")
	$Panel/Dialogo1/DiagAnim.speed_scale=(100.0/len(text))
	$Panel/currentCard.flipFront()
	if nextLine["R A"]!=null:
		$Panel/currentCard.infoCard(nextLine["R A"],nextLine["R B"],nextLine["Background Color"],nextLine["Imagen URL"])
	else:
		$Panel/currentCard.infoCard("mmm...","mmm...",nextLine["Background Color"],nextLine["Imagen URL"])
	if(nextLine["Imagen URL"]!=null):
		$Panel/currentCard.setImg(nextLine["Imagen URL"])
	if(nextLine["Background Color"]!=null):
		pass
	if(nextLine["IsError"]==true):
		errors+=1
	if(nextLine["IsCheckPoint"]==true):
		checkpoint=nextLine

func getGuionLine(idxNextLine):
	var nextLine=findLine(currentCap,idxNextLine)
	if( nextLine==null or nextLine["Pregunta"]==null):
		nextLine=line
	line=nextLine


func swPause(pauseFlag):
	canSwipe=!pauseFlag
