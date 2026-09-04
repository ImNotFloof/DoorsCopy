shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// Shader parameters
uniform float curvature : hint_range(0.0, 10.0) = 2.0;
uniform float scanline_count : hint_range(10.0, 1080.0) = 300.0;
uniform float scanline_opacity : hint_range(0.0, 1.0) = 0.25;
uniform float vignette_opacity : hint_range(0.0, 1.0) = 0.3;

// Curve coordinates to simulate a rounded CRT tube
vec2 curve_uv(vec2 uv) {
    vec2 delta = uv - 0.5;
    float dist = dot(delta, delta);
    return uv + delta * dist * (curvature / 10.0);
}

void fragment() {
    // Apply curvature to the screen coordinates
    vec2 curved_uv = curve_uv(SCREEN_UV);
    
    // Cut off pixels outside the curved screen boundaries (black bezel)
    if (curved_uv.x < 0.0 || curved_uv.x > 1.0 || curved_uv.y < 0.0 || curved_uv.y > 1.0) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);
    } else {
        // Fetch the base screen texture color
        vec4 color = texture(screen_texture, curved_uv);
        
        // Generate horizontal scanlines
        float scanline = sin(curved_uv.y * scanline_count * PI * 2.0);
        // Soften and normalize the scanline wave between 0.0 and 1.0
        scanline = (scanline + 1.0) * 0.5; 
        scanline = mix(1.0, scanline, scanline_opacity);
        color.rgb *= scanline;
        
        // Generate a smooth vignette around the screen edges
        float vignette = curved_uv.x * curved_uv.y * (1.0 - curved_uv.x) * (1.0 - curved_uv.y);
        vignette = clamp(pow(16.0 * vignette, 0.25), 0.0, 1.0);
        color.rgb *= mix(1.0, vignette, vignette_opacity);
        
        COLOR = color;
    }
}