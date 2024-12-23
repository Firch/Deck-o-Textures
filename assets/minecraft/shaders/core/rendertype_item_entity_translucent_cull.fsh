#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec2 texCoord1;

out vec4 fragColor;

void main() {
    float bigCard = 204.0/255.0;
    float smallCard = 178.0/255.0;

    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
    if (color.a < 0.1) {
        discard;
    }
    float setValue = bigCard;
    float discardValue = smallCard;
    if (vertexDistance > 10.0) {
        setValue = smallCard;
        discardValue = bigCard;
    }
    if (abs(color.a - discardValue) <= 0.001) {
        discard;
    }
    if (abs(color.a - setValue) <= 0.001) {
        color.a = 1.0;
    }
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
