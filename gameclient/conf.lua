
function love.conf(t)
    t.screen.width = 800
    t.screen.height = 600
    t.modules.joystick = false
    t.modules.audio = true
    t.modules.keyboard = true
    t.modules.event = true
    t.modules.image = true
    t.modules.graphics = true
    t.modules.timer = true
    t.modules.mouse = true
    t.modules.sound = true
    t.modules.physics = false
    t.console = false
    t.title = "SummerTime Galaxies"
    t.author = "NEXTNETIC"
    t.screen.fullscreen = false
    t.screen.vsync = true
    t.screen.fsaa = 0
    t.version = 001
end