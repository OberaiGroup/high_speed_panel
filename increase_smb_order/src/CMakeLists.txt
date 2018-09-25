set( SOURCES
increase_smb_order.cpp
)

set( HEADERS
${SCOREC_INC}/apf.h
${SCOREC_INC}/PCU.h
${SCOREC_INC}/pcu_util.h
)
link_directories( ${SCOREC_LIB})

add_executable( increase_smb_order ${SOURCES} ${HEADERS})

target_include_directories( increase_smb_order PUBLIC ${SCOREC_INC})
target_link_libraries( increase_smb_order 
pcu 
apf
)
