using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ReSetTextures : MonoBehaviour
{
    public Texture Rstexture;
    public string TextureName;
    public Material assignMat;

    public void SetTexture(Texture t) {
        Rstexture = t;

    }

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {

        assignMat.SetTexture(TextureName, Rstexture);


    }
}
