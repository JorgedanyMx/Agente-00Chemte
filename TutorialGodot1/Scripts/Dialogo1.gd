extends Control

var dialogos =["hola",
	"como estas, que tal te la estás pasando",
	"me tenías con el pendiente"
	]
var dialog_index=0


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_pressed("ui_accept")):
		if dialog_index <dialogos.size():
			$RichTextLabel.text = dialogos[dialog_index]
			$RichTextLabel.visible_ratio
