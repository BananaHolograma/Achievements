@tool
extends EditorPlugin

const PLUGIN_PREFIX = "GodotParadise"

var SETTINGS_BASE = "{project_name}/config".format({"project_name": ProjectSettings.get_setting("application/config/name")})
var DEFAULT_SETTINGS = [
	{
		"name": SETTINGS_BASE + "/achievements/local_source",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_TYPE_STRING,
		"value": "res://",
	},
		{
		"name": SETTINGS_BASE + "/achievements/remote_source",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_TYPE_STRING,
		"value": "https://"
	},
	{
		"name": SETTINGS_BASE + "/achievements/save_directory",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_TYPE_STRING,
		"value": OS.get_user_data_dir()
	},
	{
		"name": SETTINGS_BASE + "/achievements/save_file_name",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_TYPE_STRING,
		"value": "achievements.json"
	},
	{
		"name": SETTINGS_BASE + "/achievements/password",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_TYPE_STRING,
		"value": ""
	},
]

func _enter_tree():
	_setup_settings()
	add_autoload_singleton(_add_prefix("Achievements"), "res://addons/achievements/achievements.tscn")


func _exit_tree():
	remove_autoload_singleton(_add_prefix("Achievements"))
	_remove_settings()
	

func _setup_settings():
	for setting in DEFAULT_SETTINGS:
		if not ProjectSettings.has_setting(setting["name"]):
			if setting["name"].ends_with("password"):
				setting["value"] = _generate_random_string(25)
				
			ProjectSettings.set_setting(setting["name"], setting["value"])
			ProjectSettings.add_property_info({"name": setting["name"], "type": setting["type"]})
	

func _remove_settings():
	for setting in DEFAULT_SETTINGS:
		if ProjectSettings.has_setting(setting["name"]):
			ProjectSettings.set_setting(setting["name"], null)
	

func _generate_random_string(length: int, characters: String =  "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"):
	var random_number_generator: RandomNumberGenerator = RandomNumberGenerator.new()
	var result = ""

	if not characters.is_empty() and length > 0:
		for i in range(length):
			result += characters[random_number_generator.randi() % characters.length()]

	return result

func _add_prefix(text: String) -> String:
	return "{prefix}{text}".format({"prefix": PLUGIN_PREFIX, "text": text}).strip_edges()
