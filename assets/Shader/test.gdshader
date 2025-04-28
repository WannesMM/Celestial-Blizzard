shader_type spatial;
render_mode cull_disabled;

uniform sampler2D texture : 

void vertex()
{
	VERTEX.x = sin(TIME *8.0 * (UV.x -1.0));
}