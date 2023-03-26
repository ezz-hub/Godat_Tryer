extends CharacterBody2D



#parameters/idle/blend_position

var r:int =0
@onready var animationTree=$AnimationTree
@export var startingDirection:Vector2 = Vector2(0,1)
@onready var stateMachine = animationTree.get("parameters/playback")

@export var speed: float =100

func _ready():
	Pick_new_State()
	update_animation_paramters(startingDirection)

func _physics_process(_delta):
	#well here we first make a varaible of input 
	r=0
	var input_Direction=Vector2(
		Input.get_action_strength("right")- Input.get_action_strength("left"),
		Input.get_action_strength("down")-Input.get_action_strength("up")	
	)	
	
	
	velocity=speed*input_Direction
	Pick_new_State()
	update_animation_paramters(input_Direction)
	

	move_and_slide()
	
	


func update_animation_paramters( move_input:Vector2 ):
	if(move_input != Vector2.ZERO):
		if(r==2):
			animationTree.set("parameters/idle/blend_position",move_input)
			animationTree.set("parameters/walk/blend_position",move_input)
		if(r==1):
			animationTree.set("parameters/idle/blend_position",move_input)
			animationTree.set("parameters/walk/blend_position",move_input)
		
func Pick_new_State():
	if(velocity.x <= 0.1 and velocity.y  <0.1):
		r=1
		stateMachine.travel("idle")
	else:
		r=2
		stateMachine.travel("walk")



