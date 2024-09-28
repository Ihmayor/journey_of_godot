#Handles all UI SFX
extends Node

@export var root_path : NodePath

@onready var sounds = {
	&"UI_Click": AudioStreamPlayer.new(),
	&"UI_Hover": AudioStreamPlayer.new(),
	&"UI_Toggle": AudioStreamPlayer.new(),
}

func _ready():
	assert(root_path != null, "Empty root path for UI!")
	#Load sounds from SFX folder
	for i in sounds.keys():
		sounds[i].stream = load("res://music/SFX/" + str(i) + ".wav")
		#assign output mixerbus
		sounds[i].bus = &"UI"
		add_child(sounds[i])
	install_sounds(get_node(root_path))

#Register sounds for every relevant signal for every found button
func install_sounds(node :Node):
	for i in node.get_children():
		if i is Button:
			if i is CheckButton:
				i.pressed.connect(func(): ui_sfx_play(&"UI_Toggle"))
			else:
				i.pressed.connect(func(): ui_sfx_play(&"UI_Click"))
			i.mouse_entered.connect(func(): ui_sfx_play(&"UI_Hover"))#			

		#recursive call
		install_sounds(i)
		
func ui_sfx_play(sound : StringName):
	sounds[sound].play()
