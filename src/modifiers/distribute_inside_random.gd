tool
extends Node


export(bool) var override_global_seed = false
export(int) var custom_seed = 0
export(int) var instance_count = 10

var display_name := "Distribute Inside (Random)"

var _rng: RandomNumberGenerator


func process_transforms(transforms, global_seed) -> void:
	transforms.resize(instance_count)
	_rng = RandomNumberGenerator.new()

	if override_global_seed:
		_rng.set_seed(custom_seed)
	else:
		_rng.set_seed(global_seed)
	
	var center = transforms.path.center
	var half_size = transforms.path.size * 0.5
	
	for i in transforms.list.size():
		# Don't use a while just in case the user-provided path is invalid 
		# and no position ends up inside the path.
		for j in 100:
			var pos = _random_vec3() * half_size + center
			if transforms.path.is_point_inside(pos):
				transforms.list[i].origin = pos
				break


func _random_vec3() -> Vector3:
	var vec3 = Vector3.ZERO
	vec3.x = _rng.randf_range(-1.0, 1.0)
	vec3.y = _rng.randf_range(-1.0, 1.0)
	vec3.z = _rng.randf_range(-1.0, 1.0)
	return vec3
