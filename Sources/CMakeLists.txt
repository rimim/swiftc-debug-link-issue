
IF (WORKAROUND)
# Remove -g from the CMAKE_Swift_FLAGS_DEBUG
# Compiling with debugging and using more than 128 files seems to add
# DummyLibrary.swiftmodule to the linker input files
# Previous versions of the linker would warn about an unsupported file.
# The linker starting with Xcode15 reports this as an error
string(REPLACE "-g" "" CMAKE_Swift_FLAGS_DEBUG "${CMAKE_Swift_FLAGS_DEBUG}")
ENDIF()

file(GLOB DUMMY_SOURCES "DummyFiles/Dummy*.swift")

add_library(DummyLibrary SHARED
  ${DUMMY_SOURCES}
  )
target_link_libraries(DummyLibrary PRIVATE
  )
set_target_properties(DummyLibrary PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})

_install_target(DummyLibrary)
set_property(GLOBAL APPEND PROPERTY SWIFT_COLLECTIONS_EXPORTS DummyLibrary)
