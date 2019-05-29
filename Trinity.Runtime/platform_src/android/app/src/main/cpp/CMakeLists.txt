cmake_minimum_required(VERSION 3.4.1)

set(PROJECT_ROOT ${CMAKE_CURRENT_LIST_DIR}/../../../../../../../)

set(SPVSDK_DIR ${CMAKE_BINARY_DIR}/spvsdk)

file(MAKE_DIRECTORY ${SPVSDK_DIR})
execute_process(COMMAND tar xzf ${PROJECT_ROOT}/Plugins/Wallet/src/android/libs/org.elastos.wallet-debug.aar -C ${SPVSDK_DIR})

add_library(spvsdk SHARED IMPORTED)
set_target_properties(spvsdk PROPERTIES
  IMPORTED_LOCATION "${SPVSDK_DIR}/jni/${CMAKE_ANDROID_ARCH_ABI}/libspvsdk.so"
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
