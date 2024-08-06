extends Label

@onready var character_timer: Timer = $"../../../../CharacterTimer"

# The full text to be displayed
var full_text: String = "Your animated text goes here. Some very long text indeed, let's see how it's handled. Wee hee woohoo! COOLNESS SUCKERS."
# The index of the current character being displayed
var char_index: int = 0

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	text = ""  # Start with an empty label


func create_fade_label() -> Label:
	var fade_label: Label = Label.new()
	fade_label.text = full_text.substr(0, char_index)
	fade_label.modulate.a = 0.0  # Start fully transparent
	fade_label.size = size
	fade_label.add_theme_font_size_override("font_size", get_theme_font_size("font_size"))
	fade_label.autowrap_mode = autowrap_mode
	
	return fade_label


# Function to apply fade-in effect to the last added character
func _fade_in_character(index: int) -> void:
	# Implement the fade-in effect for the character at the given index
	# This can be done using a shader or by manipulating the color modulate
	# For simplicity, we will change the color modulate here
	var fade_label: Label = create_fade_label()
	add_child(fade_label)
	
	# Animate the fade-in effect
	var fade_tween: Tween = create_tween()
	fade_tween.tween_property(fade_label, "modulate:a", 1, 0.5)

	# After fade-in, remove the fade label and update the main label
	await fade_tween.finished
	remove_child(fade_label)


func _on_character_timer_timeout() -> void:
	if char_index < full_text.length():
		_fade_in_character(char_index)
		char_index += 1
	else:
		text = full_text
		character_timer.stop()
