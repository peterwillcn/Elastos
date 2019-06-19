cmake_minimum_required(VERSION 3.4.1)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_C_STANDARD_REQUIRED ON)

set(PROJECT_ROOT ${CMAKE_CURRENT_LIST_DIR}/../../../../../../../)

get_filename_component(SPVSDK_DIR ../../spvsdk
                       ABSOLUTE BASE_DIR ${CMAKE_BINARY_DIR})


set(SPVSDK_AAR_FILE "${PROJECT_ROOT}/Plugins/Wallet/src/android/libs/org.elastos.wallet-debug.aar")
set(SPVSDK_SO_FILE "${SPVSDK_DIR}/jni/${CMAKE_ANDROID_ARCH_ABI}/libspvsdk.so")

file(MAKE_DIRECTORY ${SPVSDK_DIR})
execute_process(
  COMMAND ${CMAKE_COMMAND} -E tar xzf ${SPVSDK_AAR_FILE}
  WORKING_DIRECTORY ${SPVSDK_DIR}
)

add_library(spvsdk SHARED IMPORTED)
set_target_properties(spvsdk PROPERTIES
  IMPORTED_LOCATION ${SPVSDK_SO_FILE}
)

add_library(verifier SHARED
  native_verifier.cpp
  ElaVerifier.cpp
)

target_include_directories(verifier PRIVATE
  ${PROJECT_ROOT}/Dependency/SPV.Cpp/
)

target_link_libraries(verifier
  spvsdk
  android
  log
)
