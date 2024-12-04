extends Node

var piwo_status : int = 3


var notatka_remki_przeczytana : bool = false
var pieniadze_zabrane_z_pieca : bool = false


enum WALKA_STANY { BRAK, WYGRANA, PRZEGRANA, UCIECZKA }
var walka_smog: String = "walka_smog"
var walka_smog_wygrana: WALKA_STANY = WALKA_STANY.BRAK
var smog_moved: bool = false


var le_dict = {
	"Some key name": "value1",
	"pieniadze_zabrane_z_pieca": pieniadze_zabrane_z_pieca,
	"pryncypalki_zdobyte": false,
	"pryncypalki_zaplacone": false,
}



func get_flag(flag: String) -> String:
	var temp_flag = get(flag)
	if temp_flag == null:
		print("Nie znaleziono flagi")
		return ""
	return temp_flag

func get_flag_dict(flag: String) -> Variant:
	if not le_dict.has(flag):
		print("Nie znaleziono flagi:", flag)
		return null  # lub jakikolwiek domyślny "brak danych"
	return le_dict[flag]


func set_flag(flag: String, val: bool):
	var le_flag = le_dict[flag]
	if le_flag == null:
		print("Nie znaleziono flagi2: ", flag)
	le_dict[flag] = val


func get_walka(walka: String) -> String:
	var temp_fight = get(walka)
	if temp_fight == null:
		print("Nie znaleziono flagi walki")
		return ""
	return temp_fight
	
func set_walka(walka: String, wygrana: WALKA_STANY):
	var _walka = get_walka(walka)
	if !_walka.is_empty():
		var temp_victory = _walka + "_wygrana"
		if get(temp_victory) == null:
			print("Nie znaleziono wygranej: ", temp_victory)
		else: 
			set(temp_victory, wygrana)



func is_walka_wygrana(walka: String) -> bool:
	var temp_fight = get_walka(walka)
	
	var temp_victory = temp_fight + "_wygrana"
	if get(temp_victory) == null:
		print("Nie znaleziono zwyciestwa")
		return false
	return get(temp_victory) == WALKA_STANY.WYGRANA
