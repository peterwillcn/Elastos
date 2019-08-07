
include(ExternalProject)
ExternalProject_Add(ela_spv_cpp
  SOURCE_DIR
    ${PROJECT_SOURCE_DIR}/../../../Dependency/SPV.Cpp
  UPDATE_COMMAND
    ""
  BUILD_COMMAND
    $(MAKE) walletcore
  INSTALL_COMMAND
    ""
  CMAKE_ARGS
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
  LOG_BUILD
    1
  LOG_INSTALL
    1
)

ExternalProject_Get_property(ela_spv_cpp SOURCE_DIR)
ExternalProject_Get_property(ela_spv_cpp BINARY_DIR)

if(UNIX AND NOT APPLE)
    string(APPEND CMAKE_SHARED_LINKER_FLAGS " -Wl,--no-undefined -Wl,--no-allow-shlib-undefined")
endif(UNIX AND NOT APPLE)

set(LIBRARY_NAME epksign)

add_library(${LIBRARY_NAME} SHARED WalletCoreLib.cpp)

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  get_filename_component(_internal_install_prefix "../.."
                         ABSOLUTE BASE_DIR "${PROJECT_SOURCE_DIR}")
  set(CMAKE_INSTALL_PREFIX ${_internal_install_prefix} CACHE PATH "$LIBRARY_NAME} install prefix" FORCE)
endif(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)

include(GNUInstallDirs)
install(
  TARGETS
    ${LIBRARY_NAME}
  LIBRARY
    DESTINATION ${CMAKE_INSTALL_LIBDIR}
)


target_include_directories(${LIBRARY_NAME}
    PUBLIC
      ${SOURCE_DIR}
      ${SOURCE_DIR}/Interface
      ${SOURCE_DIR}/ThirdParty/catch2
      ${SOURCE_DIR}/ThirdParty/log
      ${SOURCE_DIR}/ThirdParty/openssl/openssl/include
      ${BINARY_DIR}
      ${BINARY_DIR}/ThirdParty/boost/install/include
      ${BINARY_DIR}/ThirdParty/openssl/install/include
      ${CMAKE_BINARY_DIR}
)

add_library(wallet_core STATIC IMPORTED)
set_target_properties(wallet_core PROPERTIES
  IMPORTED_LOCATION ${BINARY_DIR}/SDK/WalletCore/libwalletcore.a
)
add_dependencies(wallet_core ela_spv_cpp)

add_library(openssl_crypto STATIC IMPORTED)
set_target_properties(openssl_crypto PROPERTIES
  IMPORTED_LOCATION ${BINARY_DIR}/ThirdParty/openssl/install/lib/libcrypto.a
)
add_dependencies(openssl_crypto ela_spv_cpp)

add_library(openssl_ssl STATIC IMPORTED)
set_target_properties(openssl_ssl PROPERTIES
  IMPORTED_LOCATION ${BINARY_DIR}/ThirdParty/openssl/install/lib/libssl.a
)
add_dependencies(openssl_ssl ela_spv_cpp)

target_link_libraries(${LIBRARY_NAME}
    wallet_core
    openssl_crypto
    openssl_ssl
)

target_link_libraries(${LIBRARY_NAME} dl)

if(ANDROID)
    target_link_libraries(${LIBRARY_NAME} log atomic)
else()
    target_link_libraries(${LIBRARY_NAME} pthread)
endif()

