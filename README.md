# Pixel Normal World Node For Godot
This is an addon for Godot 4 that adds the `PixelNormalWorld` node to the visual shader system. This node outputs normal map direction in world space based on the input.

|||
| -----|-------|
|![pixelnormalworld](https://github.com/user-attachments/assets/8bf3cdd6-1b21-44aa-8e72-6c43e1c7950f)|![worldspace](https://github.com/user-attachments/assets/4ebe7f5c-7dd7-4faa-a3ef-ba0c3ae71e06)|

![p ixelnormal](https://github.com/user-attachments/assets/f3f8992a-745e-4261-b3aa-7651d637b77a)

# Method
The normal map is unpacked from 0,1 to -1,1 range.

    vec3 unpacked_normal = vec3(%s * 2.0 - 1.0);

TANGENT, BINORMAL & NORMAL is transformed into world space using AxB(3x3) matrix.

    vec3 tangentWS = vec3((INV_VIEW_MATRIX * vec4(TANGENT, 0.0)).xyz);
		vec3 binormalWS = vec3((INV_VIEW_MATRIX * vec4(BINORMAL, 0.0)).xyz);
		vec3 normalWS = vec3((INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);

A TBN matrix is constructed using world space TANGENT, BINORMAL & NORMAL.

    mat4 TBN = mat4(vec4(tangentWS, 0.0), vec4(binormalWS, 0.0), vec4(normalWS, 0.0), vec4(0.0, 0.0, 0.0, 1.0));

The normal map is multiplied by the TBN matrix to get world space pixel normal direction.

    %s = (TBN * vec4(unpacked_normal, 1.0)).xyz;

# Installation
You can get it from the Asset Store in editor.
Or extract the zip file and copy the folder to your project. You'll need to restart the editor for the node to appear in visual shader.
