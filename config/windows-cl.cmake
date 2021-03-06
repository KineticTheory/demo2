#-----------------------------*-cmake-*----------------------------------------#
# file   windows-cl.cmake
# author Kelly Thompson <kgt@lanl.gov>
# date   2010 June 5
# brief  Establish flags for Windows - MSVC
# note   Copyright (C) 2016-2020 Triad National Security, LLC.
#        All rights reserved.
#------------------------------------------------------------------------------#

include_guard(GLOBAL)

# Settings that are common for Visual Studio are in a shared file.  These
# settings are valid for both cl.exe and clang-cl.exe.
include(windows-msvc)

if( NOT CXX_FLAGS_INITIALIZED )
  set( CXX_FLAGS_INITIALIZED "yes" CACHE INTERNAL "using Draco settings." )

  # Notes on options:
  # - /W[0-4] Warning levels. Draco is currently using /W4 (see
  #           src/CMakeLists.txt), but clients default to /W2. /W0 suppresses
  #           all warnings.
  string( APPEND CMAKE_C_FLAGS " /W2")
  string( APPEND CMAKE_CXX_FLAGS " /W2")

endif()

# Ensure cache values always match current selection
force_compiler_flags_to_cache()

#------------------------------------------------------------------------------#
# End windows-cl.cmake
#------------------------------------------------------------------------------#
