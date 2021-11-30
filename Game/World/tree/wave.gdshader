shader_type canvas_item;

uniform float spread = 5.0; //wave loop speed
uniform float wave_freq = 1.0; //wave freq
uniform float wave_width = 1; //wave width 

uniform sampler2D noise;

void vertex()
{
	
}

void fragment(){
	vec2 wave_uv_offset;
	float time = TIME /15f;

	//wave_uv_offset.x = cos((TIME*wave_speed)+UV.x+UV.y*wave_freq*2.0)*wave_width*0.01;
	//wave_uv_offset.y = cos((TIME*wave_speed)+UV.x+UV.x*wave_freq*2.0)*wave_width*0.01;
	wave_uv_offset.x =texture(noise,vec2(UV.y/spread+time*wave_freq,time)*wave_width).r ;
	wave_uv_offset.y= texture(noise,vec2(time,UV.x/spread+time)*wave_width).r  ;
	
	//wave_uv_offset.x = (texture(noise,UV+TIME/5f).x)/10f+0.8;
	//wave_uv_offset.y= (texture(noise,UV+TIME/5f).y)/10f+0.8;
	
	wave_uv_offset = wave_uv_offset /10f+0.8;
	
	COLOR = texture(TEXTURE,(UV*1.25f-0.88+wave_uv_offset)*wave_uv_offset);
	COLOR.r = wave_uv_offset.x;
	//COLOR = vec4(wave_uv_offset,0.0,1.0);
	//COLOR = texture(TEXTURE,UV+wave_uv_offset);
}
