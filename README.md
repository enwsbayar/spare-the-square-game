# Spare the Square

A 2D pixel-art platformer made with Godot 4.6.

## Gameplay

Guide the square through 14 levels filled with obstacles. Reach the portal at the end of each level to progress. One wrong move and you're back to the start.

### Controls

| Key | Action |
|-----|--------|
| `A` | Move left |
| `D` | Move right |
| `Space` | Jump |
| `K` | Self-destruct (manual respawn) |

### Obstacles

- **Spikes** — instant death on contact
- **Saws** — rotating blades that patrol areas
- **Cannons** — fire bullets at the player
- **NPCs** — AI-controlled enemies that chase and shoot
- **Platforms** — moving platforms
- **Trampolines** — launch the player upward
- **Teleports** — warp between two points
- **Buttons** — activate or deactivate elements in the level

## Features

- 14 handcrafted levels
- Main menu with Play, Continue, Levels, and Settings
- Level select screen — unlocks as you progress
- Progress saved automatically to disk
- Fullscreen toggle in settings

## Project Structure

```
spare-the-square/
├── Assets/          # Sprites and textures
├── Fonts/           # PressStart2P pixel font
├── Scenes/
│   ├── Levels/      # level_1.tscn through level_14.tscn
│   ├── Menus/       # main_menu, level_select, settings
│   └── Others/      # player, portal, cannon, npc, etc.
└── Scripts/         # GDScript files for all scenes
```

## Built With

- [Godot Engine 4.6](https://godotengine.org/)
- GDScript
- PressStart2P font

## Developer

**bayo.studio**
