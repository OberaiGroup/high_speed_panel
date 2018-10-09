#include <cstdlib>
#include <iostream>
#include <apf.h>
#include <apfMDS.h>
#include <apfMesh2.h>
#include <apfShape.h>
#include <gmi_mesh.h>
#include <PCU.h>
#include <pcu_util.h>

void print_usage( char** argv)
{
  if( !PCU_Comm_Self() )
  {
    std::cout <<
    "Usage: " << std::endl <<
    argv[0] << " <model.dmg> <mesh_in.smb> <mesh_out.smb>" << std::endl;
  }
  return;
}

void print_args( char** argv)
{
  if( !PCU_Comm_Self() )
  {
    std::cout <<
    "Loading model named " << argv[1] << std::endl <<
    "Loading mesh named " << argv[2] << std::endl <<
    "Writng mesh named " << argv[3] << std::endl;
  }
  return;
}

void check_args( int argc, char** argv)
{
  if( argc != 4)
  {
    print_usage( argv);
    MPI_Finalize();
    std::abort();
  }
  print_args( argv);

  return;
}

void change_to_quads( apf::Mesh2* mesh, char* mesh_file, char* out_mesh)
{
  int quadratic_order = 2;
  if( mesh->getShape()->getOrder() != quadratic_order)
  {
    mesh->changeShape( apf::getLagrange( quadratic_order), true);
    mesh->verify();
    mesh->writeNative( out_mesh);
  }
  else if( !PCU_Comm_Self() )
  {
    std::cout << std::endl <<
    "Mesh already has quadratic shape functions!" << std::endl;
  }

  return;
}

int main(int argc, char** argv)
{
  MPI_Init(&argc,&argv);
  PCU_Comm_Init();
  check_args( argc, argv);

  char* model_file = argv[1];
  char* mesh_file  = argv[2];
  char* out_mesh   = argv[3];

  gmi_register_mesh();
  apf::Mesh2* mesh = apf::loadMdsMesh( model_file, mesh_file);

  change_to_quads( mesh, mesh_file, out_mesh);

  mesh->destroyNative();
  apf::destroyMesh( mesh);

  PCU_Comm_Free();
  MPI_Finalize();
  return 0;
}
