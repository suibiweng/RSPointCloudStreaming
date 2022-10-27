using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DrawMeshInstanced : MonoBehaviour
{
public Mesh mesh;
  public Material material;
  Matrix4x4[] matrices;

  void OnEnable()
  {
    matrices = new Matrix4x4[10]; // initialize array
    for (int i = 0; i < 10; i++)
    {
      Vector3 position = new Vector3(0, 0, i);
      Quaternion rotation = Quaternion.identity;
      Vector3 scale = new Vector3(0.3f, 0.3f, 0.3f);
      matrices[i] = Matrix4x4.TRS(position, rotation, scale);
    }
  }

  void Update()
  {
    Graphics.DrawMeshInstanced(mesh, 0, material, matrices);
  }
}
