extends Node;

##Minimap's level blocks' positions (in mm space).
##Key = id of level. All relative to level0.
var level_pos_s: Dictionary[int, Vector2] = {};

##Minimap's level blocks' sizes (in mm space).
##Key = id of level.
var level_sizes: Dictionary[int, Vector2] = {};

##Docker positions for the minimap (in level space).
##Key = id of level, and then id of docker.
var docker_pos_s: Dictionary[int, Array] = {};

##Docker info: [0] = connects to which level id?, [1] = corresponds to what docker id?
##Key = id of level, and then id of docker (and then the ultimate key, 0 or 1)
var dockers_info: Dictionary[int, Array] = {};

##Top-left corners of levels, in level space, for building the map
var tl_s: Dictionary[int, Vector2] = {};

##Docker positions for the minimap (in minimap space, relative to level block panel).
##Key = id of level, and then id of docker.
var mm_docker_pos_s: Dictionary[int, Array] = {};

func _get_docker_pos_s(dockers: Array[Docker]) -> Array[Vector2]:
	var ret: Array[Vector2] = [];
	for docker: Docker in dockers:
		ret.append(docker.position);
	return ret;

func _get_dockers_info(dockers: Array[Docker]) -> Array[Array]:
	var ret: Array[Array] = [];
	for docker: Docker in dockers:
		ret.append([docker.connect_to_level_id, docker.connect_to_docker_id]);
	return ret;

func generate() -> void:
	var visited: Array[int] = [];
	# queue entries: [level_id, entry_docker_id] (-1 for level 0, no entry docker)
	var queue: Array = [[0, -1]];
	while (queue.size() > 0):
		var entry: Array = queue.pop_front();
		var id: int = entry[0];
		var eid: int = entry[1];
		if (id in visited):
			continue ;
		visited.append(id);
		var temp_ll: BaseLevel = load("res://Scenes/Levels/level_%d.tscn" % [id]).instantiate();
		var camlims: Vector4i = temp_ll.get_cam_limits();
		var tl: Vector2 = Vector2(camlims.x, camlims.y);
		var dockers: Array[Docker] = temp_ll.get_dockers();
		tl_s[id] = tl;
		dockers_info[id] = _get_dockers_info(dockers);
		docker_pos_s[id] = _get_docker_pos_s(dockers);
		level_sizes[id] = Vector2(camlims.z - camlims.x, camlims.w - camlims.y) / Settings.minimap_scale;
		var pos: Vector2 = Vector2(0, 0);
		if (id != 0):
			var prev_id: int = dockers_info[id][eid][0];
			var old_level_tl: Vector2 = tl_s[prev_id] / Settings.minimap_scale;
			var old_level_pos: Vector2 = level_pos_s[prev_id];
			var old_docker_pos: Vector2 = docker_pos_s[prev_id][dockers[eid].connect_to_docker_id] / Settings.minimap_scale;
			var this_docker_pos: Vector2 = docker_pos_s[id][eid] / Settings.minimap_scale;
			pos = (
				(old_docker_pos - old_level_tl + old_level_pos)
				- (this_docker_pos - tl / Settings.minimap_scale)
			);
		level_pos_s[id] = pos;
		var mm_dockers: Array[Vector2] = [];
		for docker: Docker in dockers:
			mm_dockers.append((docker.position - tl) / Settings.minimap_scale);
			if (!(docker.connect_to_level_id in visited)):
				queue.append([docker.connect_to_level_id, docker.connect_to_docker_id]);
		mm_docker_pos_s[id] = mm_dockers;
		temp_ll.free();
