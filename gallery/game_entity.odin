package main

import "core:fmt"
import "core:math"
import "core:mem"
import "core:slice"

Vector2 :: [2]f32

Entity_Type :: enum {
    Player,
    Enemy,
    Projectile,
    Obstacle,
}

Entity_Flags :: distinct bit_set[Entity_Flag; u8]
Entity_Flag :: enum {
    Invulnerable,
    Airborne,
    Visible,
}

Entity :: struct {
    id:       u32,
    name:     string,
    kind:     Entity_Type,
    pos:      Vector2,
    velocity: Vector2,
    flags:    Entity_Flags,
    health:   int,
    active:   bool,
}

entity_distance :: proc(a, b: Entity) -> f32 {
    diff := a.pos - b.pos
    return math.sqrt(diff.x * diff.x + diff.y * diff.y)
}

update_entity :: proc(e: ^Entity, dt: f32) {
    if !e.active do return

    e.pos += e.velocity * dt

    if e.health <= 0 {
        e.active = false
        e.flags -= {.Visible}
    }
}

main :: proc() {
    track: mem.Tracking_Allocator
    mem.tracking_allocator_init(&track, context.allocator)
    context.allocator = mem.tracking_allocator(&track)
    defer mem.tracking_allocator_destroy(&track)

    player := Entity{
        id       = 1,
        name     = "Hero",
        kind     = .Player,
        pos      = {0.0, 10.0},
        velocity = {1.5, 0.0},
        flags    = {.Visible},
        health   = 100,
        active   = true,
    }

    update_entity(&player, 0.016)
    fmt.printfln("Entity '%s' [%v] at pos: %v, health: %d", player.name, player.kind, player.pos, player.health)
}
