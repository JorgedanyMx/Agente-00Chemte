extends Control

var dialogos =["hola",
	"como estas, que tal te la estás pasando",
	"me tenías con el pendiente"
	]
var dialog_index=0
var show_button=false
var line=[]
var maindata=[]

func _ready():
#	maindata = Get_data("Cap2")
#	line=maindata[1]
#	showCard(line)
	pass

"""
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("ui_left")):
		print(line)
		getGuionLine(line[5])
		
	if (Input.is_action_just_pressed("ui_right")):
		if line[6]!="":
			getGuionLine(line[6])
		else:
			getGuionLine(line[5])


#Funcion para obetener el indice
func findLine(value, array) ->int:
	for index in range(array.size()):
		var subarray = array[index]
		if subarray.size() > 0 and subarray[0] == value:
			return index
	return -1



func load_dialog():
	if dialog_index <dialogos.size():
		if(dialog_index==0 or dialog_index==dialogos.size()-1):
			show_button=!show_button
			$next.visible=show_button
		$RichTextLabel.text = dialogos[dialog_index]
		#$RichTextLabel.visible_ratio =lerp(0,1,0.1)
		dialog_index+=1
		if(dialog_index>=dialogos.size()):
			$RichTextLabel.text=""

func splitStringByTab(string_data):
	var result = string_data.split("\t")
	return result
	
func  Get_data(path):
	var filePath = "res://data/"+path+".tsv"
	var maindata =Array()
	if FileAccess.file_exists(filePath):
		var datafile =FileAccess.open(filePath,FileAccess.READ)
		while !datafile.eof_reached():
			var data_set=(datafile.get_line())
			maindata.append(splitStringByTab(data_set)) 
		datafile.close()
	else:
		print("archivo no existe")
	#print(maindata)
	return maindata
	
func showCard(nextLine):
	$Panel/Dialogo1.text= nextLine[2]
	if nextLine[3]=="":
		$Panel/Resp2.text="mmm..."
	else:
		$Panel/Resp2.text=nextLine[3]
	if nextLine[4]=="":
		$Panel/Resp1.text="mmm..."
	else:
		$Panel/Resp1.text=nextLine[4]
	$Panel/Dialogo2.text= "Personaje: "+ nextLine[1]
	$"../currentCardCard".flipFront()
	if nextLine[3]!="":
		$"../currentCardCard".infoCard(nextLine[3],nextLine[4],nextLine[9],nextLine[10])
	else:
		$"../currentCardCard".infoCard("mmm...","mmm...",nextLine[9],nextLine[10])
	
func getGuionLine(idxNextLine):
	print("El siguiente valor es: "+ idxNextLine)
	var idxLine=findLine(idxNextLine,maindata)
	if(idxLine==-1):
		return
	line=maindata[idxLine]
	showCard(line)
"""
