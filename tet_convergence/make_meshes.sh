
export CONVERGENCE_DIR=/home/jlclough/research/high_speed_panel/tet_convergence
export LINEAR_DIR=$CONVERGENCE_DIR/linear
export QUADRATIC_DIR=$CONVERGENCE_DIR/quadratic
export LIN2QUAD_EXEC=/home/jlclough/research/high_speed_panel/linear_to_quad/build/src/linear_to_quad

# First make basic linear meshes for composite tets
cd $LINEAR_DIR
box \
  10 10 1 \
  1  1  0.01 \
  1 model_1.dmg mesh_1_.smb 

box \
  10 20 2 \
  1  1  0.01 \
  1 model_2.dmg mesh_2_.smb 
box \
  10 40 4 \
  1  1  0.01 \
  1 model_4.dmg mesh_4_.smb 
box \
  10 80 8 \
  1  1  0.01 \
  1 model_8.dmg mesh_8_.smb 
box \
  10 160 16 \
  1  1  0.01 \
  1 model_16.dmg mesh_16_.smb 

# Move to quadratic Direcotry, copy linear meshes
cd $QUADRATIC_DIR
cp $LINEAR_DIR/*  $QUADRATIC_DIR

# Convert meshes to use quadratic shape functions
${LIN2QUAD_EXEC} model_1.dmg mesh_1_.smb
${LIN2QUAD_EXEC} model_2.dmg mesh_2_.smb
${LIN2QUAD_EXEC} model_4.dmg mesh_4_.smb
${LIN2QUAD_EXEC} model_8.dmg mesh_8_.smb
${LIN2QUAD_EXEC} model_16.dmg mesh_16_.smb
