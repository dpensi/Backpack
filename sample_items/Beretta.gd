extends RigidBody2D

# this is an example script for a generic
# object that may exist in a game

var damage = 50
var fire_rate = 1
var used = 0.0 # new

# this variable makes the object usable with backpack
# the value must be a key in the inventory definition json file
var item_id = "beretta"
