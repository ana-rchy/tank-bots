all the functions referenced here are allowed. you can use other properties/functions that godot provides *within reason*. all submissions' code will be checked, and if youre doing something stupid like `tank._enemy_tank.queue_free()` that obviously wont be allowed

---

# PlayerScript functions

### `start(tank: Tank)`
called at the start of the game. `tank` is the tank API you will be using

### `on_turn(tank: Tank)`
called every turn. if you want to perform multiple actions in a turn, you have to call an action'ing function more than once within one call of `on_turn`

---

# Tank enums

### `Direction`
- values: `UP, UP_RIGHT, RIGHT, DOWN_RIGHT, DOWN, DOWN_LEFT, LEFT, UP_LEFT`
- use this enum when calling `move` and `shoot`

### `MoveResult`
- values: `OK, OUT_OF_ACTIONS, BESIDE_WALL, HIT_WALL, HIT_TANK`
- returned from `move`. indicates the result of the action
- 
- `OK`: returned if no other condition applies
- `OUT_OF_ACTIONS`: no more actions left in the turn
- `BESIDE_WALL`: the tank is beside a wall. important to note that this is returned when you move from the centre to an edge of the map too
- `HIT_WALL`: the tank collided with a wall. returned when a wall prevents you from moving in the given direction
- `HIT_TANK`: the tank collided with another tank. has a priority over `BESIDE_WALL`/`HIT_WALL` as a return value

### `ShootResult`
- values: `OK, OUT_OF_ACTIONS`
- 
- `OK`: returned if no other condition applies
- `OUT_OF_ACTIONS`: no more actions left in the turn

# Tank functions

### `move(dir_enum: Direction) -> MoveResult`
- moves the tank one grid square in the specified direction
- 
- `dir_enum`: the direction specified with a value from the `Direction` enum
- `MoveResult`: see `MoveResult` above
- 
- e.g. `tank.move(Tank.Direction.UP)`

### `shoot(dir_enum: Direction) -> ShootResult`
- shoots a bullet in the specified direction
- 
- `dir_enum`: the direction specified with a value from the `Direction` enum
- `ShootResult`: see `ShootResult` above
- 
- e.g. `tank.shoot(Tank.Direction.DOWN_LEFT)`

### `get_pos() -> Vector2i`
- returns your own position on the 11x11 map grid

### `get_enemy_pos() -> Vector2i`
- returns the enemy's position on the 11x11 map grid

### `get_pos_history() -> Array[Vector2i]`
- returns an array containing all your previous positions after every turn

### `get_enemy_pos_history() -> Array[Vector2i]`
- returns an array containing all your enemy's previous positions after every turn

### `get_bullets() -> Array[Bullet]`
- returns an array containing references to every currently active `Bullet` owned by you

### `get_enemy_bullets() -> Array[Bullet]`
- returns an array containing references to every currently active `Bullet` owned by your enemy

### `get_hp() -> int`
- returns your hp

### `get_enemy_hp() -> int`
- returns your enemy's hp

### `get_action_count() -> int`
- returns the number of actions you have left in the current turn

### `dir_to_vector(dir: Direction) -> Vector2`
- converts a `Direction` to a (square grid relative) normalized `Vector2`

---

# Bullet functions

### `get_pos() -> Vector2i`
- returns the bullets position on the 11x11 map grid

### `get_pos_history() -> Array[Vector2i]`
- returns an array containing all the bullet's previous positions after every turn

### `get_dir() -> Vector2i`
- returns the direction the bullet is heading in as a (square grid relative) normalized `Vector2i`
