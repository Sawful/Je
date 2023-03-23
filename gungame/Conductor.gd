extends AudioStreamPlayer

#https://youtu.be/_FRiPPbJsFQ for help

@export var bpm = 80
@export var measures = 4


var song_position = 0.0
var song_position_in_beats = 1
var sec_per_beat = 60.0/bpm
var last_reported_beat = 0
var beats_before_start = 0
var measure = 1

signal beat_signal(position)
signal measure_signal(position)

# Called when the node enters the scene tree for the first time.
func _ready():
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if playing:
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -= AudioServer.get_output_latency()
		song_position_in_beats = int(floor(song_position / sec_per_beat)) + beats_before_start
		_report_beat()
		

func _report_beat():
	if last_reported_beat < song_position_in_beats:
		if measure > measures:
			measure = 1
		emit_signal("beat_signal", song_position_in_beats)
		emit_signal("measure_signal", measure)
		last_reported_beat = song_position_in_beats
		measure += 1

func play_with_beat_offset(num):
	beats_before_start = num
	$StartTimer.wait_time = sec_per_beat
	$StartTimer.start()
	


func _on_start_timer_timeout():
	song_position_in_beats += 1
	if song_position_in_beats < beats_before_start -1:
		$StartTimer.start()
	elif song_position_in_beats == beats_before_start < 1:
		$StartTimer.wait_time = $StartTimer.wait_time - (AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency())
		$StartTimer.start()
	else:
		play()
		$StartTimer.stop()
	_report_beat()
	
func play_from_beat(beat, offset):
	play()
	seek(beat + sec_per_beat)
	beats_before_start = offset
	
	measure = beat % measures


#func _on_finished():
	#play()
