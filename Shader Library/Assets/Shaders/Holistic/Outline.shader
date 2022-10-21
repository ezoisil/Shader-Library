Shader "Custom/Outline"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _OutlineColor ("Outline Color", Color) = (0,0,0,1)
        _Outline("Outline Width", Range(.002,0.1)) = .005
    }
    SubShader
    {
        ZWrite off
        CGPROGRAM
            #pragma surface surf Lambert vertex:vert

        float4 _OutlineColor;
        float _Outline;

        struct Input
        {
            float2 uv_MainTex;
        };

        void vert (inout appdata_full v)
        {
            v.vertex.xyz += v.normal * _Outline;
        }

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Emission = _OutlineColor.rgb;
        }
        
        ENDCG
        
        ZWrite on
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert
        
        sampler2D _MainTex;
   
        struct Input
        {
            float2 uv_MainTex;
        };
        
        

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
