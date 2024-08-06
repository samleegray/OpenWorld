extends Label

@onready var character_timer: Timer = $"../../../CharacterTimer"

# The full text to be displayed
var full_text: String = "Your animated text goes here. Some very long text indeed, let's see how it's handled. Wee hee woohoo! COOLNESS SUCKERS."
# The index of the current character being displayed
var char_index: int = 0

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	text = ""  # Start with an empty label

# Function to apply fade-in effect to the last added character
func _fade_in_character(index: int) -> void:
	# Implement the fade-in effect for the character at the given index
	# This can be done using a shader or by manipulating the color modulate
	# For simplicity, we will change the color modulate here
	var fade_label: Label = Label.new()
	fade_label.text = full_text[index]
	fade_label.custom_minimum_size = custom_minimum_size
	fade_label.modulate = Color(1, 1, 1, 0)  # Start fully transparent
	add_child(fade_label)
	fade_label.position = Vector2(char_index * 10, 0)  # Adjust position as needed

	# Animate the fade-in effect
	var fade_tween: Tween = Tween.new()
	fade_tween.tween_property(fade_label, "modulate:a", 1, 0.5)

	# After fade-in, remove the fade label and update the main label
	await fade_tween.finished
	remove_child(fade_label)
	text = full_text.substr(0, char_index)


func _on_character_timer_timeout() -> void:
	if char_index < full_text.length():
		text += full_text[char_index]
		char_index += 1
		_fade_in_character(char_index - 1)  # Apply fade-in effect
	else:
		character_timer.stop()
