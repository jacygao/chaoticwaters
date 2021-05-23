# Style guide

## Naming

### Function Name
- Name function names with `snake_case`
- For node rendering name the method `render_node()`
- For node initialisation name the method `init_node()`

### File Name
- Name scene files with `CamelCase` with the first letter uppercase such as `CannonBall.tscn`
- gd files should have the same name as the relavent scene file such as `CannonBall.gd`
- Name asset files with `snake_case` such as `cannon_ball.png`

## Templating

### render_node()'
Implement this method a Node when you need invocation from the parent Node that triggers a re-rendering.