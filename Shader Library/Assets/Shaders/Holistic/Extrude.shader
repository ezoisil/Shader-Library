Shader "Custom/Extrude"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Amount ("Extrude", Range(-1,1)) = 0.01
    }
    SubShader
    {
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert vertex:vert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        struct appdata
        {
            float4 vertex: POSITION;
            float3 normal: NORMAL;
            float4 texcoord: TEXCOORD0;
        };

        float _Amount;
        
        void vert(inout  appdata v)
        {
            //v.vertex.xyz += v.normal * _Amount;
            //v.vertex.xyz += v.normal * _Amount * (cos(_Time)+1);
            v.vertex.xyz += v.normal * lerp(_Amount * _Time * 0.001,0,1);
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
