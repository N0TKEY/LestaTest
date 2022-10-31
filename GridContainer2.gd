extends GridContainer

var net = [1,4,2,4,3,1,0,2,0,3,1,4,2,4,3,1,0,2,0,3,1,4,2,4,3] # Аттавизм (изначально выигрышная комбинция), который можно было бы задать пустым. Однако я ещё не знаю, эффективнее ли это.
var adreas = [] # Небходимо для работы с кнопками.
var lastButton # Хранит номер нажатой до этого кнопки.
var testBool = false # Для проверки состояния победы.
var lastButtonTexture # Для сохранения выбора фишки


func _ready():
	############################ Генерация "уровня".
	randomize()
	var utilArr = [0,0,0,0] # Счётчик генерации
	for i in 25:
		if net[i]!=4:
			while true:
				var shaker = int(round(rand_range(0,3)))
				if shaker==0: 
					if utilArr[shaker]+1<5:
						net[i]=shaker
						utilArr[shaker]+=1
						break
				else:
					if utilArr[shaker]+1<6:
						net[i]=shaker
						utilArr[shaker]+=1
						break
		##################################### Построение "уровня".
		var Slot = TextureButton.new()
		add_child(Slot)
		adreas.append(Slot) # Сохранение кнопок для последующей работы с ними.
		Slot.editor_description = str(i) # Нумерация кнопок.
		Slot.connect("pressed", self, "_button_pressed", [Slot])
		Slot.connect("mouse_entered", self, "_on_TextureButton_mouse_entered", [Slot])
		Slot.connect("mouse_exited", self, "_on_TextureButton_mouse_exited", [Slot])
		match net[i]:
			0:
				Slot.texture_normal = load ("res://image/simpleButton1.png")
				Slot.texture_pressed = load ("res://image/simpleButton2.png")
				Slot.texture_hover = load ("res://image/simpleButton3.png")
			1:
				Slot.texture_normal = load ("res://image/greenButton1.png")
				Slot.texture_pressed = load ("res://image/greenButton2.png")
				Slot.texture_hover = load ("res://image/greenButton3.png")
			2:
				Slot.texture_normal = load ("res://image/orangeButton1.png")
				Slot.texture_pressed = load ("res://image/orangeButton2.png")
				Slot.texture_hover = load ("res://image/orangeButton3.png")
			3:
				Slot.texture_normal = load ("res://image/whiteButton1.png")
				Slot.texture_pressed = load ("res://image/whiteButton2.png")
				Slot.texture_hover = load ("res://image/whiteButton3.png")
			4:
				Slot.texture_normal = load ("res://image/blockButton1.png")
				Slot.texture_pressed = load ("res://image/blockButton2.png")
				Slot.texture_hover = load ("res://image/blockButton3.png")
	isWin()


######################################### Обработка нажатия любой кнопки.
# Улучшу подход, хочу смотреть только 8 вокруг кнопки, а не все 25.
func _button_pressed(actualButton, second=false):
	if testBool==true:
		_on_AcceptDialog_confirmed() # На случай, если игрок проигнорирует сообщение об окончании игры.
	var actualButtonNum = int(actualButton.editor_description) # Номер нажатой кнопки.
	var is_second = false # Для снятия и наложения выбора фишки.
	if lastButton!=null: # Защита первого запуска.
		if adreas[lastButton].texture_normal == lastButtonTexture:
			is_second = true
		adreas[lastButton].texture_normal = lastButtonTexture
	for i in 25:
		if (net[i]==5 and actualButtonNum!=i): 
			net[i] = 0 # Обнуление всех "пустых" ячеек до значения пустой ячейки, кроме нажатой.
			adreas[i].texture_normal = load ("res://image/simpleButton1.png")
			adreas[i].texture_pressed = load ("res://image/simpleButton2.png")
			adreas[i].texture_hover = load ("res://image/simpleButton3.png")
	match net[actualButtonNum]:
		1,2,3:
			if lastButton!=actualButtonNum or is_second:
				for i in 25:
					# Выделение пустых соседних ячеек для фишки зелёного/оранжевого/белого цвета.
					if (net[i]==0 and abs(i/5 - actualButtonNum/5)<=1 and abs(i%5 - actualButtonNum%5)<=1): 
						net[i] = 5
						adreas[i].texture_normal = load ("res://image/chooseButton1.png")
						adreas[i].texture_pressed = load ("res://image/chooseButton2.png")
						adreas[i].texture_hover = load ("res://image/chooseButton3.png")
				lastButton = actualButtonNum
				# Смена выбранной фишки.
				lastButtonTexture = adreas[actualButtonNum].texture_normal
				adreas[actualButtonNum].texture_normal = adreas[actualButtonNum].texture_pressed
		5:
			# Перемещение фишки.
			net[actualButtonNum] = net[lastButton]
			adreas[actualButtonNum].texture_normal = adreas[lastButton].texture_normal
			adreas[actualButtonNum].texture_pressed = adreas[lastButton].texture_pressed
			adreas[actualButtonNum].texture_hover = adreas[lastButton].texture_hover
			net[lastButton] = 0
			adreas[lastButton].texture_normal = load ("res://image/simpleButton1.png")
			adreas[lastButton].texture_pressed = load ("res://image/simpleButton2.png")
			adreas[lastButton].texture_hover = load ("res://image/simpleButton3.png")
			if second==false: 
				_button_pressed(actualButton, true) # Для продолжения работы с той же фишкой.
	if second==false: 
		isWin() # Без этого условия, будет задублировано.


####################################################### Отображение доступных ячеек при наведении.
func _on_TextureButton_mouse_entered(actualButton):
	var actualButtonNum = int(actualButton.editor_description)
	if net[actualButtonNum]!=4 and net[actualButtonNum]!=5 and net[actualButtonNum]!=0:
		for i in 25:
			# Выделение пустых соседних ячеек для фишки зелёного/оранжевого/белого цвета при наведении.
			if (net[i]==0 and abs(i/5 - actualButtonNum/5)<=1 and abs(i%5 - actualButtonNum%5)<=1): 
				adreas[i].texture_normal = load ("res://image/chooseButton1.png")

func _on_TextureButton_mouse_exited(actualButton):
	var actualButtonNum = int(actualButton.editor_description)
	if net[actualButtonNum]!=4 and net[actualButtonNum]!=5 and net[actualButtonNum]!=0:
		for i in 25:
			# Снятие выделения пустых соседних ячеек для фишки зелёного/оранжевого/белого цвета при наведении.
			if (net[i]==0 and abs(i/5 - actualButtonNum/5)<=1 and abs(i%5 - actualButtonNum%5)<=1): 
				adreas[i].texture_normal = load ("res://image/simpleButton1.png")


######################################## Проверка на победу.
func isWin():
	testBool = true # Значения необходмиое для победы.
	for i in 25:
		if (((i%5 == 0)and(net[i] != 1))or((i%5 == 2)and(net[i] !=2))or((i%5 == 4)and(net[i] !=3))): 
			testBool=false # Будет отменено если есть хоть одно различие с нужной комбинацией.
			break
	if testBool==true:
		var winner = AcceptDialog.new()
		add_child(winner)
		winner.dialog_text = "You win!"
		winner.window_title = "Congratulation!"
		winner.popup_centered()
		winner.connect("confirmed", self, "_on_AcceptDialog_confirmed") # Один из вариантов закрытия игры. Запасной был ранее при нажатии.


######################################## Выход при победе.
func _on_AcceptDialog_confirmed():
	get_tree().quit() 
