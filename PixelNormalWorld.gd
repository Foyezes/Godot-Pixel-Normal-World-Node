# This node was created by Foyezes
# x.com/Foyezes
# bsky.app/profile/foyezes.bsky.social

@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodePixelNormalWorld

func _get_name():
	return "PixelNormalWorld"

func _get_category():
	return "Color"

func _get_description():
	return "Outputs normal map direction in world space"

func _get_output_port_count():
	return 1
	
func _get_input_port_count():
	return 1

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D
func _get_output_port_name(port):
	match port:
		0:
			return ""
			
func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_name(port):
	match port:
		0:
			return "Normal Map"
			
func _get_input_port_type(port):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
			
func _get_default_input_port(port):
	return 0

func _get_code(input_vars, output_vars, mode, type):
	if type == VisualShader.TYPE_FRAGMENT:
		
		return """
		vec3 unpacked_normal = vec3(%s * 2.0 - 1.0);
		
		vec3 tangentWS = vec3((INV_VIEW_MATRIX * vec4(TANGENT, 0.0)).xyz);
		vec3 binormalWS = vec3((INV_VIEW_MATRIX * vec4(BINORMAL, 0.0)).xyz);
		vec3 normalWS = vec3((INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);
		
		mat4 TBN = mat4(vec4(tangentWS, 0.0), vec4(binormalWS, 0.0), vec4(normalWS, 0.0), vec4(0.0, 0.0, 0.0, 1.0));
		%s = (TBN * vec4(unpacked_normal, 1.0)).xyz;
		""" % [input_vars[0], output_vars[0]]

func _is_available(mode, type):
	if type == VisualShader.TYPE_VERTEX:
		return false
	elif type == VisualShader.TYPE_FRAGMENT:
		return true
