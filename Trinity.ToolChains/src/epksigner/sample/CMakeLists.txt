set(SAMPLE_NAME sample)

add_executable(${SAMPLE_NAME} main.cpp)

target_include_directories(${SAMPLE_NAME} PRIVATE ${PROJECT_SOURCE_DIR}/main)
target_link_libraries(${SAMPLE_NAME} epksign)

