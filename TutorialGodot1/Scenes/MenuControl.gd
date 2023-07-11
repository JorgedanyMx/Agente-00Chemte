extends Control

var audioBus = AudioServer.get_bus_index("Master")


func _on_vol_slider_value_changed(value):
	var bus_idx= AudioServer.get_bus_index("Master")
	if(value>$bgMenu/Panel/volSlider.min_value ):
		AudioServer.set_bus_mute(bus_idx,false)
		AudioServer.set_bus_volume_db(bus_idx,value)
	else:
		AudioServer.set_bus_mute(bus_idx,true)



func _on_salir_pressed():
	get_tree().quit()
