// Made with Amplify Shader Editor v1.9.0.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RSShader"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.02
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 2
		_Color("Color", 2D) = "white" {}
		_Offset("Offset", Vector) = (-0.26,0,0,0)
		_Depth("Depth", 2D) = "white" {}
		_Scale("Scale", Float) = 0.6
		_PointDensity("PointDensity", Float) = 0
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_BumpScale("BumpScale", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Depth;
		uniform half2 _Offset;
		uniform half _Scale;
		uniform half _BumpScale;
		uniform sampler2D _Color;
		uniform sampler2D _TextureSample0;
		uniform half _PointDensity;
		uniform float _Cutoff = 0.02;
		uniform float _EdgeLength;


		half3 RGBToHSV(half3 c)
		{
			half4 K = half4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			half4 p = lerp( half4( c.bg, K.wz ), half4( c.gb, K.xy ), step( c.b, c.g ) );
			half4 q = lerp( half4( p.xyw, c.r ), half4( c.r, p.yzx ), step( p.x, c.r ) );
			half d = q.x - min( q.w, q.y );
			half e = 1.0e-10;
			return half3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float2 uv_TexCoord20 = v.texcoord.xy + _Offset;
			half4 tex2DNode14 = tex2Dlod( _Depth, float4( ( ( uv_TexCoord20 * _Scale ) + ( ( 1.0 - _Scale ) * 0.5 ) ), 0, 0.0) );
			half3 hsvTorgb58 = RGBToHSV( tex2DNode14.rgb );
			half smoothstepResult64 = smoothstep( 0.37 , 0.66 , hsvTorgb58.x);
			half3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( ( smoothstepResult64 * _BumpScale ) * ase_vertexNormal );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			half4 tex2DNode16 = tex2D( _Color, i.uv_texcoord );
			o.Albedo = tex2DNode16.rgb;
			o.Emission = tex2DNode16.rgb;
			o.Alpha = 1;
			half2 appendResult74 = (half2(_PointDensity , _PointDensity));
			float2 uv_TexCoord70 = i.uv_texcoord * appendResult74;
			float2 uv_TexCoord20 = i.uv_texcoord + _Offset;
			half4 tex2DNode14 = tex2D( _Depth, ( ( uv_TexCoord20 * _Scale ) + ( ( 1.0 - _Scale ) * 0.5 ) ) );
			clip( ( tex2D( _TextureSample0, uv_TexCoord70 ) * tex2DNode14.b ).r - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19001
524;73;320;726;1308.032;214.4112;1;False;False
Node;AmplifyShaderEditor.RangedFloatNode;40;-2169.594,393.8758;Inherit;False;Property;_Scale;Scale;9;0;Create;True;0;0;0;False;0;False;0.6;0.66;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;38;-2828.367,41.37224;Inherit;False;Property;_Offset;Offset;7;0;Create;True;0;0;0;False;0;False;-0.26,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-2230.925,22.8542;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;41;-1705.022,268.0891;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-1718.439,442.5132;Inherit;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-1780.494,125.5308;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-1540.66,241.2547;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;44;-1495.377,68.50748;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-1440.731,-897.5964;Inherit;False;Property;_PointDensity;PointDensity;10;0;Create;True;0;0;0;False;0;False;0;324.98;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;-1404.418,-233.3848;Inherit;True;Property;_Depth;Depth;8;0;Create;True;0;0;0;False;0;False;-1;None;b35c4d66914c6014e9a9e2081452b0a6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RGBToHSVNode;58;-1208.022,19.00671;Inherit;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;74;-1271.731,-839.5964;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SmoothstepOpNode;64;-892.0225,-165.9933;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0.37;False;2;FLOAT;0.66;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-924.958,321.6318;Inherit;False;Property;_BumpScale;BumpScale;12;0;Create;True;0;0;0;False;0;False;0;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;70;-1007.731,-834.5964;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;800,800;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;18;-1379.374,-654.4048;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-581.8582,-207.122;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;10;-674.558,95.27802;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;69;-746.7314,-709.5964;Inherit;True;Property;_TextureSample0;Texture Sample 0;11;0;Create;True;0;0;0;False;0;False;-1;None;0000000000000000f000000000000000;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-306.5922,80.82873;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;67;-615.4166,169.8935;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;68;-912.7314,123.4036;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;-531.7314,-448.5964;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;16;-1079.506,-501.2025;Inherit;True;Property;_Color;Color;6;0;Create;True;0;0;0;False;0;False;-1;None;28214d8ecf1d0874ab97dfdaabd8da50;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;66;114.1717,-283.6106;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;RSShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Custom;0.02;True;True;0;False;Transparent;;Geometry;All;18;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;2;2;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;20;1;38;0
WireConnection;41;0;40;0
WireConnection;39;0;20;0
WireConnection;39;1;40;0
WireConnection;42;0;41;0
WireConnection;42;1;43;0
WireConnection;44;0;39;0
WireConnection;44;1;42;0
WireConnection;14;1;44;0
WireConnection;58;0;14;0
WireConnection;74;0;73;0
WireConnection;74;1;73;0
WireConnection;64;0;58;1
WireConnection;70;0;74;0
WireConnection;13;0;64;0
WireConnection;13;1;11;0
WireConnection;69;1;70;0
WireConnection;15;0;13;0
WireConnection;15;1;10;0
WireConnection;71;0;69;0
WireConnection;71;1;14;3
WireConnection;16;1;18;0
WireConnection;66;0;16;0
WireConnection;66;2;16;0
WireConnection;66;10;71;0
WireConnection;66;11;15;0
ASEEND*/
//CHKSM=169F443B0DF0B5E817214880CED63ADBD8358FCC