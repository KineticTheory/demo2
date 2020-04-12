#-----------------------------*-cmake-*----------------------------------------#
# file   draco/CMakeLists.txt
# author Kelly Thompson <kgt@lanl.gov>
# date   2010 April 28
# brief  Instructions for building root level Makefile.
# note   Copyright (C) 2019-2020 Triad National Security, LLC.
#        All rights reserved.
#------------------------------------------------------------------------------#

# Build notes:
#   https://rtt.lanl.gov/redmine/projects/draco/wiki/
#   https://rtt.lanl.gov/redmine/projects/draco/wiki/Common_Configure_Options

cmake_minimum_required(VERSION 3.17.0 FATAL_ERROR)
set(ddesc "An object-oriented component library supporting radiation")
string(APPEND ddesc " transport applications.")
project( Draco DESCRIPTION ${ddesc} VERSION 7.6 LANGUAGES CXX C)


# Build system configuration files are located here.
set( CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/config )

# The Draco version number.
#
include(dracoVersion)
set_ccs2_software_version( Draco )

#
# Unit Test Setup
#
include(dracoTesting)

# Set default compile environment:

# Setup defaults, value checks, etc.
include(buildEnv)
# set defaults for BUILD_TYPE and INSTALL_PREFIX
dbsSetDefaults()
# Initialize fields that define the exported target files
# (draco-config.cmake)
dbsInitExportTargets( "Draco" )
# Save config info
dbsConfigInfo()

# Platform Checks: Is HOST_NAME_MAX defined?  Is WinSock2.h available?  Is
# gethostname() available?
include( platform_checks )
query_craype()
set_draco_uname()
query_have_gethostname()
query_have_maxpathlen()
query_have_sys_headers() # sets HAVE_UNISTD_H, etc.
query_have_restrict_keyword()
query_fma_on_hardware()

# Set compiler options
include( compilerEnv )
dbsSetupCompilers()
dbsSetupCxx()
dbsSetupFortran()
dbsSetupCuda()
dbsSetupProfilerTools()
dbsSetupStaticAnalyzers()

# Find any globally required libraries
include( FeatureSummary )
include( vendor_libraries )
setupVendorLibraries()

#
# Build Draco components:
#
add_subdirectory( src )
add_subdirectory( config )  # This must be processed after 'src'

# Export targets
install(
  EXPORT draco-targets
  DESTINATION cmake
  EXPORT_LINK_INTERFACE_LIBRARIES )

##---------------------------------------------------------------------------##
## End of CMakeLists.txt
##---------------------------------------------------------------------------##
