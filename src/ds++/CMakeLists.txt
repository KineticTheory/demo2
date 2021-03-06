#-----------------------------*-cmake-*----------------------------------------#
# file   ds++/CMakeLists.txt
# author Kelly Thompson <kgt@lanl.gov>
# date   2010 Sep 24
# brief  Generate build project files for ds++.
# note   Copyright (C) 2016-2019, Triad National Security, LLC.
#        All rights reserved.
#------------------------------------------------------------------------------#
cmake_minimum_required(VERSION 3.17.0)
project( dsxx CXX )

# ---------------------------------------------------------------------------- #
# Generate config.h (only occurs when cmake is run)
# ---------------------------------------------------------------------------- #
if( ${CMAKE_SYSTEM_NAME} MATCHES "Windows" )
   set( FPETRAP_WINDOWS_X86 1 )
endif()

set( DRACO_DIAGNOSTICS "0"
   CACHE STRING "Diagnostics verbosity level (0-7). Default is 0." )
# provide a constrained drop down menu for cmake-gui
set_property( CACHE DRACO_DIAGNOSTICS PROPERTY STRINGS 0 1 2 3 4 5 6 7 )

# Provide an enum from CMAKE_CXX_COMPILER_VERSION
if( NOT "${CMAKE_CXX_COMPILER_VERSION}x" STREQUAL "x" )
  string( REPLACE "." "" CMAKE_CXX_COMPILER_VERSION_ENUM
    ${CMAKE_CXX_COMPILER_VERSION} )
endif()

# Information about the current machine
cmake_host_system_information(RESULT COMPILED_HOSTNAME QUERY HOSTNAME)
cmake_host_system_information(RESULT COMPILED_FQDN QUERY FQDN)
cmake_host_system_information(RESULT COMPILED_OS_NAME QUERY OS_NAME)
cmake_host_system_information(RESULT COMPILED_OS_RELEASE QUERY OS_RELEASE)
cmake_host_system_information(RESULT COMPILED_OS_VERSION QUERY OS_VERSION)
cmake_host_system_information(RESULT COMPILED_OS_PLATFORM QUERY OS_PLATFORM)
cmake_host_system_information(RESULT draco_is64bit QUERY IS_64BIT)
cmake_host_system_information(RESULT HAVE_HARDWARE_FPU QUERY HAS_FPU)
cmake_host_system_information(RESULT HAVE_HARDWARE_MMX QUERY HAS_MMX)
cmake_host_system_information(RESULT HAVE_HARDWARE_MMX_PLUS QUERY HAS_MMX_PLUS)
cmake_host_system_information(RESULT HAVE_HARDWARE_SSE QUERY HAS_SSE)
cmake_host_system_information(RESULT HAVE_HARDWARE_SSE2 QUERY HAS_SSE2)
cmake_host_system_information(RESULT HAVE_HARDWARE_SSE_FP QUERY HAS_SSE_FP)
cmake_host_system_information(RESULT HAVE_HARDWARE_SSE_MMX QUERY HAS_SSE_MMX)

# Create ds++/config.h
configure_file( config.h.in ${PROJECT_BINARY_DIR}/ds++/config.h )

# Generate the dll_declspec.h file that defines DLL_PUBLIC_<pkg> CPP macros.
include(generate_dll_declspec)
set( components dsxx )
generate_dll_declspec( "ds++" "${components}")

# ---------------------------------------------------------------------------- #
# Source files
# ---------------------------------------------------------------------------- #

file( GLOB template_implementations *.t.hh *.i.hh )
file( GLOB sources *.cc )
file( GLOB explicit_instantiations *_pt.cc )
file( GLOB dsxx_headers *.hh )
list( APPEND dsxx_headers
   ${PROJECT_BINARY_DIR}/ds++/config.h
   ${PROJECT_BINARY_DIR}/ds++/dll_declspec.h )
set( dsxx_terminal_headers
   ${PROJECT_SOURCE_DIR}/terminal/terminal.h
   ${PROJECT_SOURCE_DIR}/terminal/terminal_base.h )
list( REMOVE_ITEM dsxx_headers ${template_implementations} )

if( ${CMAKE_GENERATOR} MATCHES "Xcode" )
  # Xcode does not support per file, per configuration compile definitions, so
  # we add this compile definition for all files
  add_compile_definitions( BUILD_TYPE="$<CONFIG>" )
else()
  set_source_files_properties( Release.cc PROPERTIES
    COMPILE_DEFINITIONS BUILD_TYPE="$<CONFIG>" )
endif()

# ---------------------------------------------------------------------------- #
# Build package library
# ---------------------------------------------------------------------------- #

add_component_library(
   TARGET       Lib_dsxx
   LIBRARY_NAME ds++
   SOURCES      "${sources}"
   HEADERS      "${dsxx_headers};${dsxx_terminal_headers}" )
if( WIN32 )
  target_link_libraries( Lib_dsxx PUBLIC ${Lib_win_winsock})
else()
  target_link_libraries( Lib_dsxx PUBLIC coverage_config )
endif()
target_include_directories( Lib_dsxx
  # source directory or install location
  PUBLIC
    $<BUILD_INTERFACE:${Draco_SOURCE_DIR}/src>
    $<INSTALL_INTERFACE:include>
  # generated include directive files (config.h)
  PUBLIC $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}> )

# ---------------------------------------------------------------------------- #
# Installation instructions
# ---------------------------------------------------------------------------- #

install( TARGETS Lib_dsxx EXPORT draco-targets DESTINATION ${DBSCFGDIR}lib )
# install( TARGETS coverage_config EXPORT draco-targets )
install( FILES ${dsxx_headers} ${template_implementations} DESTINATION
  ${DBSCFGDIR}include/ds++ )
# install( FILES
    # ${dsxx_terminal_headers}
    # ${PROJECT_SOURCE_DIR}/terminal/LICENSE
    # ${PROJECT_SOURCE_DIR}/terminal/README.md
  # DESTINATION ${DBSCFGDIR}include/terminal )
if( "${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
  install(FILES $<TARGET_PDB_FILE:Lib_dsxx> DESTINATION ${DBSCFGDIR}lib
    OPTIONAL)
endif()

# ---------------------------------------------------------------------------- #
# End ds++/CMakeLists.txt
# ---------------------------------------------------------------------------- #
