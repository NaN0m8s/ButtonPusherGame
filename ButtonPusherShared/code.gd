extends Node

var isDown = false
var frame = 0

var upSound = soundEffect.new("res://Sound/Effects/sound_up_copyright.wav")
var downSound = soundEffect.new("res://Sound/Effects/sound_down_copyright.wav")
var bgm = music.new("res://Sound/Music/Green Hills Zone (Sonic 2 GG)/Full.wav", 6.4)

var p1downframe = 0
var p1upframe = 1
var p2downframe = 0
var p2upframe = 1
var stopMusic = false

class music:
	var sound
	var midpoint: float
	
	func _init(path, midpoint = 0.0):
		self.midpoint = midpoint
		self.sound = load(path)
		
	func playSound(channel, sound, time = 0.0):
		#Plays a sound(.wav) through the chosen sound channel (AudioStreamPlayer2D)
		if not channel.is_playing():
			channel.stream = sound
			channel.play(time)
	
	func loop(channel, musicOff = false):
	#Checks if you can loop entire track
		var timesLooped = 0
		if not musicOff and not channel.is_playing() and timesLooped == 0:
			timesLooped += 1
			playSound(channel, self.sound)
		elif not musicOff and not channel.is_playing() and timesLooped > 1:
			timesLooped += 1
			playSound(channel, self.sound, self.midpoint)
		
		return timesLooped
	func play(channel, musicOff = false):
		if not musicOff:
			playSound(channel, self.sound, 0)

class soundEffect:
	var sound
	func _init(path):
		self.sound = load(path)

	func play(channel, time = 0.0):
		#Plays a sound(.wav) through the chosen sound channel (AudioStreamPlayer2D)
		channel.stream = self.sound
		channel.play(time)

class player:
	var number: int
	var character: String
	var dir
	
	func _init(name = "MissingNa", num = -1):
		self.character = name
		self.number = num
		self.dir = load("res://Sprites/" + num)
	
func playSound(channel, sound, time = 0.0):
		#Plays a sound(.wav) through the chosen sound channel (AudioStreamPlayer2D)
		channel.stream = sound
		channel.play(time)
func p1_input(function = null):
		#Checks if player 1's button is pressed or not
	if Input.is_action_pressed("p1_button_down"):
		p1upframe = 0 
		$P1ButtonUp.visible = false
		$P1ButtonDown.visible = true
		
		
		if p1downframe == 0:
			downSound.play($P1Sound1)
			p1downframe = p1downframe + 1
	else:
		p1downframe = 0
		$P1ButtonUp.visible = true
		$P1ButtonDown.visible = false
		
		if p1upframe == 0:
			upSound.play($P1Sound1)
			p1upframe = p1upframe + 2
	
	if Input.is_action_pressed("p1_input_up"):
		$P1ButtonDown.position.y -= 1
		$P1ButtonUp.position.y -= 1
	if Input.is_action_pressed("p1_input_right"):
		$P1ButtonDown.position.x += 1
		$P1ButtonUp.position.x += 1
	if Input.is_action_pressed("p1_input_left"):
		$P1ButtonDown.position.x -= 1
		$P1ButtonUp.position.x -= 1
	if Input.is_action_pressed("p1_input_down"):
		$P1ButtonDown.position.y += 1
		$P1ButtonUp.position.y += 1
func p2_input(function = null):

		#Checks if player 1's button is pressed or not
	if Input.is_action_pressed("p2_button_down"):
		p2upframe = 0 
		$P2ButtonUp.visible = false
		$P2ButtonDown.visible = true
		
		if p2downframe == 0:
			downSound.play($P2Sound1)
			p2downframe = p2downframe + 1
	else:
		p2downframe = 0
		$P2ButtonUp.visible = true
		$P2ButtonDown.visible = false
		
		if p2upframe == 0:
			upSound.play($P2Sound1)
			p2upframe = p2upframe + 1
			
	if Input.is_action_pressed("p2_input_up"):
		$P2ButtonDown.position.y -= 1
		$P2ButtonUp.position.y -= 1
	if Input.is_action_pressed("p2_input_right"):
		$P2ButtonDown.position.x += 1
		$P2ButtonUp.position.x += 1
	if Input.is_action_pressed("p2_input_left"):
		$P2ButtonDown.position.x -= 1
		$P2ButtonUp.position.x -= 1
	if Input.is_action_pressed("p2_input_down"):
		$P2ButtonDown.position.y += 1
		$P2ButtonUp.position.y += 1

func _ready():
	print("Hello World")
func _process(delta):
	p1_input()
	p2_input()
	bgm.loop($BGM00)
	#playMusicLoop(sonic2music, $BGM00, 6.4, stopMusic)
	frame += 1
	print(frame)
