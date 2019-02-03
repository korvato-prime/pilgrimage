extends KinematicBody2D

const GRAVITY = 10
const SPEED = 30
const FLOOR = Vector2(0,-1)

var velocity = Vector2()
var direction = 1
var is_dead = false

func _ready():
	pass 
	
func dead():
	is_dead = true
	velocity = Vector2(0,0)
	#Doesn't work somehow
	#$Collision.disabled = true
	$Collision.queue_free()
	$AnimatedSprite.set_animation('dead')
	#Shrink collision
	#$Collision.scale.y = 0
	$AudioStreamPlayer.play()
	
func _physics_process(delta):
	if !is_dead:		
		velocity.x = SPEED * direction
		#Animation
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR)
		
		if is_on_wall():
			direction = direction * -1
			$RayCast2D.position.x *= -1  
			
		if $RayCast2D.is_colliding() == false:
			direction = direction * -1
			$RayCast2D.position.x *= -1