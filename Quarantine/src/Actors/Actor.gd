extends KinematicBody2D
class_name Actor

const MAX_SPEED = 64
const FRICTION = 0.25
const GRAVITY = 200
const JUMP_FORCE = 128
const AIR_RESISTANCE = 0.02

var motion = Vector2.ZERO
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var direction = left
