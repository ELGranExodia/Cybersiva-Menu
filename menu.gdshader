shader_type canvas_item;

// Parámetros que puedes modificar desde el Inspector
uniform float scanline_count = 50.0;
uniform float scanline_speed = 5.0;
uniform float scanline_opacity = 0.4;

void fragment() {
    // Obtener el color y la transparencia original del texto
    vec4 text_color = texture(TEXTURE, UV);
    
    // Crear el patrón de líneas de escaneo en movimiento
    float scanline = sin(UV.y * scanline_count - TIME * scanline_speed) * 0.5 + 0.5;
    
    // Aplicar las líneas oscureciendo ligeramente el color original
    COLOR = vec4(text_color.rgb * (1.0 - (scanline * scanline_opacity)), text_color.a);
}