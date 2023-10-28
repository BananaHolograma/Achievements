@tool
extends EditorPlugin

const PLUGIN_PREFIX = "GodotParadise"

func _enter_tree():
	pass

func _exit_tree():
	pass
	
func _add_prefix(text: String) -> String:
	return "{prefix}{text}".format({"prefix": PLUGIN_PREFIX, "text": text}).strip_edges()
