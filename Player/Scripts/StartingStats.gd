class_name StartingStats extends Resource

enum BattlerType {
	PLAYER,
	ENEMY
}
@export var type : BattlerType

@export var job_name : String = "job"

@export var max_hp : int
@export var max_mp : int
@export var strength : int
@export var dexternity : int
@export var fortitude : int
@export var inteligence : int
@export var luck : int
