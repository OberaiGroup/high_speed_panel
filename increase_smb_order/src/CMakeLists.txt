set( SOURCES
increase_smb_order.cpp
)

add_executable( increase_smb_order ${SOURCES})

target_include_directories( increase_smb_order PUBLIC ${SCOREC_INC})
