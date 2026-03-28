extends Node

var musique = 1

var next_niv = 1


#-------------------------------------------------------------------------------------
#niveau 6
var porte_a_piece_1 = 0
var piece_1 = 0

#-------------------------------------------------------------------------------------




# Variable qui stocke le temps de jeu total
var speedrun_time = 0.0

# Variable pour mettre le chronomètre en pause.
# Initialisé à 'true' pour qu'il ne se lance pas dans le menu.
var is_timer_paused = true

# Variable pour choisir le mode de chronomètre.
# 1 = "Niv" (reset à chaque mort/niveau)
# 2 = "Any%" (ne se reset jamais)
var speedrun_time_type = 1 

# Fonction pour réinitialiser le chronomètre.
# Pratique pour remettre le temps à 0.
func reset_timer():
	speedrun_time = 0.0

# Cette fonction s'exécute à chaque frame et met à jour le temps.
func _process(delta):
	# Le temps ne s'incrémente que si le chronomètre n'est pas en pause.
	if not is_timer_paused:
		speedrun_time += delta
		

	
	
	
