extends Control

var audioBus = AudioServer.get_bus_index("Master")
var pressed=false
var initialMousePosition


func _on_vol_slider_value_changed(value):
	var bus_idx= AudioServer.get_bus_index("Master")
	if(value>$ColorRect/Panel/volSlider.min_value ):
		var dbValue = 20.0 * log(value/100)
		AudioServer.set_bus_mute(bus_idx,false)
		AudioServer.set_bus_volume_db(bus_idx,dbValue)
	else:
		AudioServer.set_bus_mute(bus_idx,true)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:  # Se presionó el botón izquierdo del mouse
				pressed = true
				initialMousePosition= get_local_mouse_position()
			else:  # Se soltó el botón izquierdo del mouse
				pressed = false


func _on_texture_button_pressed():
	get_tree().quit()
