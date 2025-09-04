extends Control

signal finished

@onready var name_label: Label = $Panel/NameLabel
@onready var text_label: Label = $Panel/TextLabel
@onready var auto_timer: Timer = $AutoTimer

@export var dialogue_script: Array[Dictionary] = [
	{"speaker": "Arthur:", "text": "หยุด! ผู้ใดผ่านประตูเมืองนี้", "speed": 0.05, "wait": 5},
	{"speaker": "Nobura:", "text": "ข้าแค่ผ่านมา ขอพักแรมหนึ่งคืน", "speed": 0.03, "wait": 5},
	{"speaker": "ume:", "text": "เข้าไปได้ แต่อย่าก่อความวุ่นวาย", "wait": 5},
]

@export var autoplay: bool = true
@export var default_speed: float = 0.03
@export var default_wait: float = 1.0
@export var loop: bool = false

var _i := 0
var _typing := false
var _skip := false

func _ready() -> void:
	add_to_group("dialogue_box") # เพื่อให้ Nobura หาเจอ
	visible = false # ซ่อนตอนเริ่มเกม

	var cb = Callable(self, "_on_AutoTimer_timeout")
	if not auto_timer.is_connected("timeout", cb):
		auto_timer.connect("timeout", cb)

var triggered := false

func start_dialogue() -> void:
	if triggered:
		return
	triggered = true

	visible = true
	_i = 0
	if not dialogue_script.is_empty():
		_show(_i)


func _unhandled_input(e: InputEvent) -> void:
	if not visible: 
		return
	if e.is_action_pressed("ui_accept"):
		if _typing:
			_skip = true
		else:
			_next()

func _on_AutoTimer_timeout() -> void:
	_next()

func _show(i: int) -> void:
	var line = dialogue_script[i]
	var t: String = str(line.get("text", ""))
	var speed: float = float(line.get("speed", default_speed))
	var wait_s: float = float(line.get("wait", default_wait))
	var speaker: String = str(line.get("speaker", ""))

	name_label.text = speaker
	text_label.text = ""
	_typing = true
	_skip = false

	for idx in range(t.length()):
		if _skip:
			text_label.text = t
			break
		text_label.text += t[idx]
		await get_tree().create_timer(speed).timeout

	_typing = false
	_skip = false

	if autoplay:
		auto_timer.stop()
		auto_timer.wait_time = max(0.01, wait_s)
		auto_timer.start()

func _next() -> void:
	_i += 1
	if _i >= dialogue_script.size():
		if loop:
			_i = 0
		else:
			auto_timer.stop()
			emit_signal("finished")
			visible = false # ปิดกล่องเมื่อจบ
			return
	_show(_i)
