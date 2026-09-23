extends Node2D

@onready var ExitRaycast: RayCast2D = $ExitRaycast
@onready var Sarc: StaticBody2D = $"../Sarcophagus"
# Export specific info for this level only

@export var next_level_path: String
@export var second_goldstar_req: int
@export var third_goldstar_req: int

@onready var next: Button = $"../UI/NextLevelButton"
@onready var retry: Button = $"../UI/RetryButton"

# Get spiller for at tælle moves
@onready var player: CharacterBody2D = $"../CharacterBody2D"
# Spiller move count (inkluderer også push_block)
@onready var move_count: int = 0


# Ny level beat grafik
@onready var victory_background: Sprite2D = $"../UI/VictoryBg2"
@onready var pyramid: Sprite2D = $"../UI/Pyramide"
@onready var level_index: RichTextLabel = $"../UI/LevelIndex"
@onready var move_counter: RichTextLabel = $"../UI/MoveCount"

@onready var graystar1: Sprite2D = $"../UI/GrayStar1"
@onready var graystar2: Sprite2D = $"../UI/GrayStar2"
@onready var graystar3: Sprite2D = $"../UI/GrayStar3"

@onready var goldstar1: Sprite2D = $"../UI/GoldStar1"
@onready var goldstar2: Sprite2D = $"../UI/GoldStar2"
@onready var goldstar3: Sprite2D = $"../UI/GoldStar3"

# Labels for at fortælle hvor mange moves man må bruge
@onready var goldstarlabel2: Label = $"../UI/GoldStarLabel2"
@onready var goldstarlabel3: Label = $"../UI/GoldStarLabel3"
@onready var starlevelbeat: Label = $"../UI/StarLevelBeat"


func _ready() -> void:
	# Sets leveltextlabel
	level_index.text = "Level %d/9" % Levels.current_level
	
	Sarc.block_moved_exit_check.connect(exit_checks)
	next.pressed.connect(on_next_level_button_pressed)
	retry.pressed.connect(on_retry_button_pressed)
	player.player_moved.connect(count_player_move)

func exit_checks() -> void:
	print("Exit checked")
	if ExitRaycast.is_colliding():
		print("Level Won! Bring up UI now")
		MusicPlayer.stop_music()
		MusicPlayer.play_custom_track("res://Music/egyptian swag.mp3")
		# Show det hele
		next.show()
		retry.show()
		victory_background.show()
		pyramid.show()
		level_index.show()
		# Altid show grå stjerner
		graystar1.show()
		graystar2.show()
		graystar3.show()
		# Første guld for at vinde banen
		# Man behøver måske ikke graystar1, men fuck det
		goldstar1.show()
		# Tjek om de har fået goldstar 2 og 3. Det er baseret på steps taken
		if move_count <= second_goldstar_req:
			print("Second gold star reached")
			goldstar2.show()
		if move_count <= third_goldstar_req:
			print("Third gold star reached")
			goldstar3.show()
		# Vis labels for move requirement ift. stjerner
		goldstarlabel2.text = ("Under " + str(second_goldstar_req+1) + " moves")
		goldstarlabel3.text = ("Under " + str(third_goldstar_req+1) + " moves")
		starlevelbeat.show()
		goldstarlabel2.show()
		goldstarlabel3.show()
		
		
		
func count_player_move() -> void:
	move_count += 1
	print("Move count: " + str(move_count))
	move_counter.text = "Move count:  %d" % move_count


func on_retry_button_pressed() -> void:
	Levels.reset_level()


func on_next_level_button_pressed() -> void:
	Levels.current_level += 1
	SceneManager.change_scene(next_level_path)
