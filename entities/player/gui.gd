extends CanvasLayer
class_name GUI

var are_you_sure : bool = false
@onready var settings_menu: Settings = %settingsMenu

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Esc") and Global.game_state == Global.game_states.Gameplay:
		get_tree().paused = not get_tree().paused
		are_you_sure = false
		
		if get_tree().paused:
			# pause
			settings_menu._on_load_pressed()
		else:
			# unpause
			settings_menu._on_save_pressed()
	
	%paused.visible = get_tree().paused and Global.game_state == Global.game_states.Gameplay
	%sure.visible = are_you_sure
	%timer.visible = Global.game_state == Global.game_states.Gameplay

func _on_quit_pressed() -> void:
	are_you_sure = not are_you_sure

func _on_sure_pressed() -> void:
	get_tree().quit()

func _on_resume_pressed() -> void:
	get_tree().paused = false
	settings_menu._on_save_pressed()
