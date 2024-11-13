extends CanvasLayer

class Quiz:
	var question: String
	var answers: Array
	var correctAnswer: String
		
	func _init(_question, _answers, _correctAnswer):
		question = _question
		answers = _answers
		correctAnswer = _correctAnswer

var buttons
var dialog_box
var quizzes : Array = []
var active_quiz
func _ready():
	dialog_box = get_node("Dialog Box/Question")
	buttons = [
	get_node("Button Container/Button1"), 
	get_node("Button Container/Button2"), 
	get_node("Button Container/Button3"),
	get_node("Button Container/Button4")
	]
	quizzes = load_json_file("res://Master/Scripts/JSON/quiz_inputs.json")
	for quiz in quizzes:
		_enqueue(quizzes, quiz)
	_set_quiz(quizzes)
#functions
#region Quiz Setup
func _set_quiz(array : Array):
	if quizzes.size() > 0:
		active_quiz = _dequeue(array)
	else:
		SignalBus.quiz_finnished.emit()
	if dialog_box:
		dialog_box.text = active_quiz["quiz_question"]
	for i in range(buttons.size()):
		var active_button = buttons[i]
		if active_button:
			active_button.text = active_quiz["quiz_answers"][i]
#endregion
#region Queue System
func _enqueue(array, item):
	if len(array) < 10:
		array.push_back(item)
func _dequeue(array):
	var active = array.pop_front()
	return active
#endregion
#region JSON Loader
func load_json_file(file_path : String):
	if FileAccess.file_exists(file_path):
		var raw_json_file = FileAccess.open(file_path, FileAccess.READ)
		var json_parsed = JSON.parse_string(raw_json_file.get_as_text())
		if json_parsed is Array:
			raw_json_file.close()
			return json_parsed
		else:
			print("Error reading file!")
	else:
		print("File does not exist!")
#endregion

#region Button Logic
func _on_button_pressed(button_path : Button):
	if button_path.text == active_quiz["quiz_correct_answer"]:
		_correct_button_pressed()
	else:
		_incorrect_button_pressed()

func _correct_button_pressed():
	_set_quiz(quizzes)
	print("Quiz Reset!")
func _incorrect_button_pressed():
	print("Wrong Answer!")
#endregion
#region Buttons
func _on_button_1_pressed():
	_on_button_pressed($"Button Container/Button1")
func _on_button_2_pressed():
	_on_button_pressed($"Button Container/Button2")
func _on_button_3_pressed():
	_on_button_pressed($"Button Container/Button3")
func _on_button_4_pressed():
	_on_button_pressed($"Button Container/Button4")
#endregion
