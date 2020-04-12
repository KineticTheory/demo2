#-----------------------------*-cmake-*----------------------------------------#
# file   config/vendor_libraries.cmake
# author Kelly Thompson <kgt@lanl.gov>
# date   2010 June 6
# brief  Look for any libraries which are required at the top level.
# note   Copyright (C) 2016-2020 Triad National Security, LLC.
#        All rights reserved.
#------------------------------------------------------------------------------#

include_guard(GLOBAL)
include( FeatureSummary )

#------------------------------------------------------------------------------#
# Helper macros for Python
#------------------------------------------------------------------------------#
macro( setupPython )

  message( STATUS "Looking for Python...." )
  find_package(Python QUIET REQUIRED COMPONENTS Interpreter)
  #  Python_Interpreter_FOUND - Was the Python executable found
  #  Python_EXECUTABLE  - path to the Python interpreter
  set_package_properties( PythonInterp PROPERTIES
    URL "https://www.python.org"
    DESCRIPTION "Python interpreter"
    TYPE REQUIRED
    PURPOSE "Required for running tests and accessing features that rely on matplotlib."
    )
  if( Python_Interpreter_FOUND )
    message( STATUS "Looking for Python....found ${Python_EXECUTABLE}" )
  else()
    message( STATUS "Looking for Python....not found" )
  endif()

endmacro()

#------------------------------------------------------------------------------
# Helper macros for setup_global_libraries()
#------------------------------------------------------------------------------
macro( SetupVendorLibrariesUnix )
  setupPython()
endmacro()

##---------------------------------------------------------------------------##
## Vendors for building on Windows-based platforms.
##---------------------------------------------------------------------------##

macro( SetupVendorLibrariesWindows )
  setupPython()
endmacro()

#------------------------------------------------------------------------------
# Helper macros for setup_global_libraries()
# Assign here the library version to be used.
#------------------------------------------------------------------------------
macro( setVendorVersionDefaults )
  #Set the preferred search directories(ROOT)
endmacro()

#------------------------------------------------------------------------------
# This macro should contain all the system libraries which are required to link
# the main objects.
# ------------------------------------------------------------------------------
macro( setupVendorLibraries )

  message( "\nVendor Setup:\n")
  setupVendorLibrariesWindows()

  # Add commands to draco-config.cmake (which is installed for use by othe
  # projects), to setup Draco's vendors
  set( Draco_EXPORT_TARGET_PROPERTIES "${Draco_EXPORT_TARGET_PROPERTIES}
macro( dbs_basic_setup )

  message(\"
Looking for Draco...\")
  message(\"Looking for Draco...\${draco_DIR}
  \")

  # Provide helper functions used by component CMakeLists.txt files
  # This block of code generated by draco/config/vendor_libraries.cmake.

  # Setup defaults, value checks, etc.
  include(buildEnv)
  dbsSetDefaults()

  # CMake macros that check the system for features like 'gethostname', etc.
  include( platform_checks )
  query_craype()

  # Set compiler options
  include( compilerEnv )
  dbsSetupCxx()
  dbsSetupFortran()
  dbsSetupCuda()
  dbsSetupProfilerTools()

  # CMake macros like 'add_component_library' and 'add_component_executable'
  include( component_macros )

  # CMake macros to query the availability of TPLs.
  include( vendor_libraries )

  # Provide targets for MPI, Metis, etc.
  setupVendorLibraries()

endmacro()

")

  message( " " )

endmacro()

#----------------------------------------------------------------------#
# End vendor_libraries.cmake
#----------------------------------------------------------------------#
