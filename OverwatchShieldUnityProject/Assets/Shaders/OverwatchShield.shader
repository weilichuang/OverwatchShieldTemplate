Shader "Lexdev/CaseStudies/OverwatchShield"
{
    Properties
    {
        //_[Name](“[Inspector Name]”, [Type]) = [DefaultValue]
        _Color("Color",COLOR) = (0,0,0,0.5)
        _PulseTex("Hex Pulse Texture", 2D) = "white" {}
    	_PulseIntensity ("Hex Pulse Intensity", float) = 3.0
    	_PulseTimeScale("Hex Pulse Time Scale", float) = 2.0
    }
    SubShader
    {
        Tags
        {
            "RenderType" = "Transparent" //
            "Queue" = "Transparent" //透明队列
        }

        Cull Off //Disable backface culling
        Blend SrcAlpha One //Additive混合模式

        Pass
        {
            HLSLPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
            	float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

            float4 _Color;
            sampler2D _PulseTex;
			float4 _PulseTex_ST;
            float _PulseIntensity;
            float _PulseTimeScale;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv,_PulseTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float4 pulseTex = tex2D(_PulseTex,i.uv);
				fixed4 pulseTerm = pulseTex * _Color * _PulseIntensity * abs(sin(_Time.y * _PulseTimeScale));
				return fixed4(_Color.rgb + pulseTerm.rgb, _Color.a);
			}

			ENDHLSL
        }
    }
}