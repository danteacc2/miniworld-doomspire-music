-- ==========================================
-- DOOMSPIRE MUSIC & CELESTIAL SKYBOX SCRIPT
-- MiniWorld Lua Edition
-- ==========================================

-- Variables globales
local world = mw.world
local player = mw.player
local musicPlaying = false

-- ===== CONFIGURACIÓN =====
-- Ajusta estos valores según tus assets
local CONFIG = {
    music_volume = 0.6,           -- Volumen de música (0-1)
    music_loop = true,            -- Repetir música
    sky_brightness = 1.5,         -- Brillo del cielo
    sky_fog_distance = 800,       -- Distancia de niebla
    ambient_color = {r=100, g=150, b=200},  -- Color ambiental azul celeste
    light_color = {r=255, g=200, b=100},    -- Color dorado/cálido
}

-- ===== FUNCIÓN: Reproducir música =====
function playDoomspireMusic()
    if musicPlaying then
        return
    end
    
    -- Crear source de sonido
    local audioSource = mw.world:createAudio({
        url = "",  -- Aquí pones la URL/path de tu música
        volume = CONFIG.music_volume,
        loop = CONFIG.music_loop,
        is3D = false  -- Música global, no posicional
    })
    
    if audioSource then
        audioSource:play()
        musicPlaying = true
        mw.log("🎵 Música Doomspire iniciada")
    else
        mw.err("Error al crear la fuente de audio")
    end
end

-- ===== FUNCIÓN: Configurar Skybox Celestial =====
function setupCelestialSkybox()
    -- Obtener la configuración de iluminación del mundo
    if world then
        -- Color ambiental (luz general)
        world:setAmbientColor(
            CONFIG.ambient_color.r,
            CONFIG.ambient_color.g,
            CONFIG.ambient_color.b
        )
        
        -- Configurar niebla (fog) para efecto celestial
        world:setFogDistance(CONFIG.sky_fog_distance)
        world:setFogColor(
            160,  -- R: tonos azulados
            190,  -- G: tonos azulados
            255   -- B: tonos azulados
        )
        
        -- Establecer brillo general
        world:setLightBrightness(CONFIG.sky_brightness)
        
        mw.log("✨ Skybox Celestial configurado")
    end
end

-- ===== FUNCIÓN: Iluminación Dramática tipo Doomspire =====
function setupDoomspireLighting()
    if world then
        -- Luz direccional principal (sol)
        -- Ajusta ángulos según tu preferencia
        local light = world:createLight({
            type = "directional",  -- Luz direccional tipo sol
            intensity = 1.8,
            color = {
                r = CONFIG.light_color.r,
                g = CONFIG.light_color.g,
                b = CONFIG.light_color.b
            },
            direction = {x = 0.5, y = -0.8, z = 0.3}  -- Ángulo del sol
        })
        
        if light then
            mw.log("☀️ Iluminación Doomspire aplicada")
        end
    end
end

-- ===== FUNCIÓN: Crear efecto de atmósfera épica =====
function setupAtmosphere()
    if world then
        -- Ajustar color base del mundo
        world:setWorldColor(100, 150, 200)  -- Tonos azul celeste
        
        -- Opcional: Partículas o efectos especiales
        -- Aquí puedes añadir humo, polvo, etc. si MiniWorld lo soporta
        
        mw.log("🌌 Atmósfera épica configurada")
    end
end

-- ===== FUNCIÓN: Inicializar toda la escena =====
function initDoomspireScene()
    mw.log("⚙️ Inicializando escena Doomspire...")
    
    setupCelestialSkybox()
    setupDoomspireLighting()
    setupAtmosphere()
    playDoomspireMusic()
    
    mw.log("✅ Escena Doomspire completamente cargada")
end

-- ===== FUNCIÓN: Detener música =====
function stopMusic()
    if musicPlaying then
        -- Aquí detienes el audio
        -- audioSource:stop()  -- Descomenta si tienes referencia al audioSource
        musicPlaying = false
        mw.log("⏹️ Música detenida")
    end
end

-- ===== EJECUCIÓN =====
-- Se ejecuta cuando el script se carga
initDoomspireScene()

-- Retornar funciones públicas si es necesario
return {
    initScene = initDoomspireScene,
    stopMusic = stopMusic,
    playMusic = playDoomspireMusic,
    CONFIG = CONFIG
}