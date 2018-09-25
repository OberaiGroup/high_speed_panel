set( SOURCES
linear_to_quad.cpp
)

set( HEADERS
${SCOREC_INC}/apf.h
${SCOREC_INC}/apfMDS.h
${SCOREC_INC}/apfMesh2.h
${SCOREC_INC}/apfShape.h
${SCOREC_INC}/gmi_mesh.h
${SCOREC_INC}/PCU.h
${SCOREC_INC}/pcu_util.h
)
link_directories( ${SCOREC_LIB})

add_executable( linear_to_quad ${SOURCES} ${HEADERS})

target_include_directories( linear_to_quad PUBLIC ${SCOREC_INC})
target_link_libraries( linear_to_quad 
apf
mds
gmi
pcu 
)
