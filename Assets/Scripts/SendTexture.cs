using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SendTexture : MonoBehaviour
{

    public Texture texture;
    public string T_Name;
    public Material mat;


    public void setTexture(Texture t){
        texture=t;

    }

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        mat.SetTexture(T_Name,texture);
    }
}
