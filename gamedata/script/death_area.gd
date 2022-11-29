extends Area2D


func _on_death_out_of_bounds_body_entered(body):
	if (body.name == ('player')):
		get_tree().change_scene("res://dev-room.tscn")
