extends Control

var time: float = 0.0
var running: bool = false


func format_time(t):
	var minutes = "%02d" % [t / 60]
	var seconds = "%02d" % [int(ceil(t)) % 60]
	var ms = "%03d" % floor(fmod(t, 1) * 1000)

	var formatted = String()
	formatted += minutes + ":" + seconds + "." + ms
	return formatted


func formatted_time():
	return format_time(time)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.game_started.connect(_on_game_started)
	SignalBus.game_over.connect(_on_game_over)
	SignalBus.game_reset.connect(_on_game_reset)


func _process(delta: float) -> void:
	if running:
		time += delta
		$Timer.text = formatted_time()
		if time > 15 and time <= 30:
			$"ratingbox/star5/star-empty".visible = false
			$"ratingbox/star5/star-half".visible = true
			$"ratingbox/star5/star-full".visible = false
		if time > 30 and time <= 45:
			$"ratingbox/star5/star-empty".visible = true
			$"ratingbox/star5/star-half".visible = false
			$"ratingbox/star5/star-full".visible = false
		if time > 45 and time <= 60:
			$"ratingbox/star4/star-empty".visible = false
			$"ratingbox/star4/star-half".visible = true
			$"ratingbox/star4/star-full".visible = false
		if time > 60 and time <= 75:
			$"ratingbox/star4/star-empty".visible = true
			$"ratingbox/star4/star-half".visible = false
			$"ratingbox/star4/star-full".visible = false
		if time > 75 and time <= 90:
			$"ratingbox/star3/star-empty".visible = false
			$"ratingbox/star3/star-half".visible = true
			$"ratingbox/star3/star-full".visible = false
		if time > 90 and time <= 105:
			$"ratingbox/star3/star-empty".visible = true
			$"ratingbox/star3/star-half".visible = false
			$"ratingbox/star3/star-full".visible = false
		if time > 105 and time <= 120:
			$"ratingbox/star2/star-empty".visible = false
			$"ratingbox/star2/star-half".visible = true
			$"ratingbox/star2/star-full".visible = false
		if time > 120 and time <= 135:
			$"ratingbox/star2/star-empty".visible = true
			$"ratingbox/star2/star-half".visible = false
			$"ratingbox/star2/star-full".visible = false
		if time > 135 and time <= 150:
			$"ratingbox/star1/star-empty".visible = false
			$"ratingbox/star1/star-half".visible = true
			$"ratingbox/star1/star-full".visible = false
		if time > 150:
			$"ratingbox/star1/star-empty".visible = true
			$"ratingbox/star1/star-half".visible = false
			$"ratingbox/star1/star-full".visible = false


func _on_game_started():
	$Title.visible = false
	$Prompt.visible = false
	$LDTag.visible = false
	$Timer.visible = true
	$DEAD.text = "GOT 'EM"
	$DEAD.visible = false
	$DeadPrompt.visible = false
	$"ratingbox/star1/star-empty".visible = false
	$"ratingbox/star1/star-half".visible = false
	$"ratingbox/star1/star-full".visible = true
	$"ratingbox/star2/star-empty".visible = false
	$"ratingbox/star2/star-half".visible = false
	$"ratingbox/star2/star-full".visible = true
	$"ratingbox/star3/star-empty".visible = false
	$"ratingbox/star3/star-half".visible = false
	$"ratingbox/star3/star-full".visible = true
	$"ratingbox/star4/star-empty".visible = false
	$"ratingbox/star4/star-half".visible = false
	$"ratingbox/star4/star-full".visible = true
	$"ratingbox/star5/star-empty".visible = false
	$"ratingbox/star5/star-half".visible = false
	$"ratingbox/star5/star-full".visible = true
	$ratingbox.visible = true
	running = true
	time = 0.0


func _on_game_over():
	if time < 15:
		$DEAD.text = "UNEXPECTEDLY FAST"
	if time >= 15 and time < 90:
		$DEAD.text = "BUG EXTERMINATED"
	if time >= 90 and time < 120:
		$DEAD.text = "NOT THE WORST"
	if time >= 120 and time < 135:
		$DEAD.text = "YOU'RE SUPPOSED TO SWAT THE BUG FYI"
	if time >= 135 and time < 150:
		$DEAD.text = "SORRY I FEEL ASLEEP WAITING BECUASE YOU WERE SO SLOW"
	if time >= 150:
		$DEAD.text = "COULD HAVE JUST WAITED FOR THE BUG TO DIE OF NATURAL CAUSES"
	$DEAD.visible = true
	$DeadPrompt.visible = true
	running = false


func _on_game_reset():
	$LDTag.visible = true
	$Title.visible = true
	$Prompt.visible = true
	$Timer.visible = false
	$DEAD.visible = false
	$DeadPrompt.visible = false
	$ratingbox.visible = false
	running = false
	time = 0.0
