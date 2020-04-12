#-----------------------------*-cmake-*----------------------------------------#
# file   src/CMakeLists.txt
# author Kelly Thompson <kgt@lanl.gov>
# date   2010 April 28
# brief  Instructions for building src level Makefile.
# note   Copyright (C) 2016-2020 Triad National Security, LLC.
#        All rights reserved.
#------------------------------------------------------------------------------#
cmake_minimum_required(VERSION 3.17.0)
project( draco_src_dir )

# Provide helper functions used by component CMakeLists.txt files
include( component_macros )

add_dir_if_exists( ds++ )
add_dir_if_exists( FortranChecks )

# Push some variables up one level
set( Draco_EXPORT_TARGET_PROPERTIES
  "${Draco_EXPORT_TARGET_PROPERTIES}" PARENT_SCOPE)

##---------------------------------------------------------------------------##
## End of src/CMakeLists.txt
##---------------------------------------------------------------------------##
