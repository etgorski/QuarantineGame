extends CanvasLayer

onready var bar = $TextureProgress
onready var moneyAmount = $Amount
onready var player_max_health = $"../Actors/Player".max_health


func _on_ready():
	bar.value = player_max_health


func _on_Player_health_changed(current_health):
	bar.value = current_health
	print("your health has changed")


func _on_Player_money_changed(money):
	moneyAmount.set_text(String(money))
	print("get bread")


func _on_Player_died():
	print("you are dead")



