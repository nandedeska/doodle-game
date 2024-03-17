extends Label


func _process(delta):
	var bullet_count = len(get_tree().get_nodes_in_group("bullet"))
	text = "%s" % bullet_count
	$"../FPS Counter".text = "%s FPS" % Engine.get_frames_per_second()
