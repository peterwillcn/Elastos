#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "ElastosDID::eladid-shared" for configuration "Debug"
set_property(TARGET ElastosDID::eladid-shared APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(ElastosDID::eladid-shared PROPERTIES
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/libeladid.1.0.0.dylib"
  IMPORTED_SONAME_DEBUG "@rpath/libeladid.1.dylib"
  )

list(APPEND _IMPORT_CHECK_TARGETS ElastosDID::eladid-shared )
list(APPEND _IMPORT_CHECK_FILES_FOR_ElastosDID::eladid-shared "${_IMPORT_PREFIX}/lib/libeladid.1.0.0.dylib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
