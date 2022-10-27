using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TextureSendReceive;
using UnityEngine.UI;
public class TCPIPtextureTransfer : MonoBehaviour
{
    public TextureReceiver _Depth;
    public TextureReceiver _Color;
    public Material _mat;

    Texture2D texture1, texture2;
   
    // Start is called before the first frame update
    void Start()
    {
        texture1 = new Texture2D(1, 1);
        texture2 = new Texture2D(1, 1);
        _Depth.SetTargetTexture(texture1);
        _Color.SetTargetTexture(texture2);
    }

    // Update is called once per frame
    void Update()
    {
        _mat.SetTexture("_Depth",texture1);
        _mat.SetTexture("_Color", texture2);

    }
}
