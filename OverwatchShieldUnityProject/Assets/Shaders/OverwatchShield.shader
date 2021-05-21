Shader "Lexdev/CaseStudies/OverwatchShield"
{
    Properties
    {
    	//_[Name](“[Inspector Name]”, [Type]) = [DefaultValue]
		_Color("Color",COLOR) = (0,0,0,0.5)
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
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};

            float4 _Color;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				//final output
				return _Color;
			}

			ENDHLSL
        }
    }
}