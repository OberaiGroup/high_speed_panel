#include <iostream>
#include <apf.h>
#include <PCU.h>
#include <pcu_util.h>

int main(int argc, char** argv)
{
  MPI_Init(&argc,&argv);
  PCU_Comm_Init();

  std::cout<< "hello" << std::endl;


  PCU_Comm_Free();
  MPI_Finalize();
  return 0;
}
