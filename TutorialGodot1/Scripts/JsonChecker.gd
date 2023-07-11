extends Control
var path = "res://data/GuionGame.json"
# Called when the node enters the scene tree for the first time.
func _ready():
	var data=Get_data()
	var current_cap=data["Cap 1"]
	
	for key in current_cap.keys():
		var data_set = current_cap[key]
		if data_set["Personaje"]!=null:
			pass
			#print("Datos:"+"\n\n\n", data_set)
	
	##print(Get_data())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func  Get_data():
	if FileAccess.file_exists(path):
		var datafile =FileAccess.open(path,FileAccess.READ)
		var parsedResult = JSON.parse_string(datafile.get_as_text())
		if parsedResult is Dictionary:
			return parsedResult
		else:
			print("error reading file")
	else:
		print("File doesnt exist!")
