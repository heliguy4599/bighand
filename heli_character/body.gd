class_name Body
extends Node2D


const MAX_EYE_LOOK := 100.0
const MAX_EYE_MOVEMENT := 8.0


@onready var upper_arm_joint: Node2D = $UpperArmJoint
@onready var lower_arm_joint: Node2D = $UpperArmJoint/LowerArmJoint
@onready var section_length := (lower_arm_joint.global_position - upper_arm_joint.global_position).length()
@onready var left_eye: Sprite2D = $LeftEye
@onready var right_eye: Sprite2D = $RightEye
@onready var left_eye_initial_pos := left_eye.position
@onready var right_eye_initial_pos := right_eye.position


func point_to_hand(hand_pos: Vector2):
	var left_eye_look := hand_pos - to_global(left_eye_initial_pos)
	var right_eye_look := hand_pos - to_global(right_eye_initial_pos)
	
	left_eye_look = left_eye_look.limit_length(MAX_EYE_LOOK)
	right_eye_look = right_eye_look.limit_length(MAX_EYE_LOOK)
	
	left_eye_look *= MAX_EYE_MOVEMENT / MAX_EYE_LOOK
	right_eye_look *= MAX_EYE_MOVEMENT / MAX_EYE_LOOK
	
	left_eye.position = left_eye_initial_pos + left_eye_look
	right_eye.position = right_eye_initial_pos + right_eye_look
	
	var shoulder_pos := upper_arm_joint.global_position
	var hand_dist := shoulder_pos.distance_to(hand_pos)
	if hand_dist > section_length * 2 - 0.1:
		upper_arm_joint.global_rotation = (hand_pos - shoulder_pos).angle()
		lower_arm_joint.rotation = 0
		return
	
	var shoulder_offset := sqrt(section_length ** 2 - (hand_dist / 2) ** 2)
	var half_distance_vector := (hand_pos - shoulder_pos) / 2
	var shoulder_offset_vector := half_distance_vector.rotated(deg_to_rad(90)).normalized() * shoulder_offset
	var upper_arm_vector := half_distance_vector + shoulder_offset_vector
	upper_arm_joint.global_rotation = upper_arm_vector.angle()
	lower_arm_joint.global_rotation = (hand_pos - lower_arm_joint.global_position).angle()