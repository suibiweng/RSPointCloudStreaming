using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetRenderMode : MonoBehaviour
{
    public MeshTopology renderMode;
    
    void SettingRenderMode(){
        Mesh mesh = GetComponent<MeshFilter>().mesh;
        int vertexCount = mesh.vertexCount;
        int[] indices = new int[vertexCount];
        for(int i=0; i<vertexCount; i++){
            indices[i] = i;
        }
        
        mesh.SetIndices(indices, renderMode, 0);
    }
    // Start is called before the first frame update
    void Start()
    {
        SettingRenderMode();
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}