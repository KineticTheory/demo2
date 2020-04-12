Drraco
----------------

* Demonstration of VS2019 + cmake-3.17.0 build failure related to [CMake's `GNUtoMS` feature](https://cmake.org/cmake/help/latest/prop_tgt/GNUtoMS.html).
* Ref: https://developercommunity.visualstudio.com/content/problem/967511/the-system-was-unable-to-find-the-specified-regist.html
* Requirements to reproduce
  * Visual Studio Community 2019 Version 16.6.0 Preview 2.1
  * Visual studio python 3 installed.
  * CMake-3.17.0 installed and used by the project.
  * MSYS2 shell for MinGW64 with gcc and gfortran isntalled. See https://github.com/KineticTheory/Linux-HPC-Env/wiki/Download-and-install-basic-tools for installation details related to MSYS2.
     * `c:\msys64\mingw64\bin` must be in PATH.
Status
----------------
* The error log:

```console
 [ 20%] Linking Fortran shared library C:\work\vs2019-x64-Debug\demo2\Debug\librtt_FC_f90sub.dll
    "C:\Program Files\CMake\bin\cmake.exe" -E cmake_link_script CMakeFiles\Lib_FC_f90sub.dir\link.txt --verbose=1
    "C:\Program Files\CMake\bin\cmake.exe" -E rm -f CMakeFiles\Lib_FC_f90sub.dir/objects.a
    C:\msys64\mingw64\bin\ar.exe cr CMakeFiles\Lib_FC_f90sub.dir/objects.a @CMakeFiles\Lib_FC_f90sub.dir\objects1.rsp
    C:\msys64\mingw64\bin\gfortran.exe  -ffree-line-length-none -cpp -g -gdwarf-3 -fbounds-check -frange-check -ffpe-trap=invalid,zero,overflow -fbacktrace -finit-integer=2147483647 -finit-real=NAN -finit-character=127 -DDEBUG  -shared -o C:\work\vs2019-x64-Debug\demo2\Debug\librtt_FC_f90sub.dll -Wl,--out-implib,librtt_FC_f90sub.dll.a -Wl,--major-image-version,0,--minor-image-version,0 -Wl,--whole-archive CMakeFiles\Lib_FC_f90sub.dir/objects.a -Wl,--no-whole-archive @CMakeFiles\Lib_FC_f90sub.dir\linklibs.rsp -Wl,--output-def,Lib_FC_f90sub.def
    "C:\Program Files\CMake\bin\cmake.exe" -Dlib="C:/work/vs2019-x64-Debug/demo2/src/FortranChecks/f90sub/CMakeFiles/CMakeGNUtoMS_lib.bat" -Ddef=Lib_FC_f90sub.def -Ddll=C:\work\vs2019-x64-Debug\demo2\Debug\librtt_FC_f90sub.dll -Dimp=librtt_FC_f90sub.dll.a -P "C:/Program Files/CMake/share/cmake-3.17/Modules/Platform/GNUtoMS_lib.cmake"
    [DEBUG:vcvarsall.bat] init with arguments 'x64'
    [DEBUG:vcvarsall.bat] inner argument {x64}
    [DEBUG:vcvarsall.bat] Command line parse completed with values:
    [DEBUG:vcvarsall.bat] __VCVARSALL_TARGET_ARCH='x64'
    [DEBUG:vcvarsall.bat] __VCVARSALL_HOST_ARCH='x64'
    [DEBUG:vcvarsall.bat] __VCVARSALL_WINSDK=''
    [DEBUG:vcvarsall.bat] __VCVARSALL_STORE=''
    [DEBUG:vcvarsall.bat] __VCVARSALL_HELP=''
    [DEBUG:vcvarsall.bat] __VCVARSALL_PARSE_ERROR='0'
    [DEBUG:VsDevCmd] Writing pre-initialization environment to C:\Users\kt\AppData\Local\Temp\dd_vsdevcmd16_preinit_env.log
    [DEBUG:VsDevCmd.bat] --------------------- VS Developer Command Prompt Environment [pre-init] ---------------------
    VSCMD_DEBUG_KT=0
    VSCMD_START_DIR=.
    
    ...
    
    [DEBUG:core\dotnet.bat] Framework Preference: 64bit
    [DEBUG:core\dotnet.bat] Cannot find registry key for FrameworkDir64 - using default: C:\Windows\Microsoft.NET\Framework64\
    
    ...
    
       [DEBUG:VsDevCmd.bat] calling "ext\perf_tools.bat"
    C:\work\KineticTheory\demo2\CUSTOMBUILD : error : The system was unable to find the specified registry key or value. 
    [DEBUG:~nx0] after reg query 'HKLM\SOFTWARE', __collection_tools=''
    [DEBUG:~nx0] after reg query 'HKLM\SOFTWARE\Wow6432Node', __collection_tools='C:\Program Files (x86)\Microsoft Visual Studio\Shared\Common\VSPerfCollectionTools\vs2019\'
    [DEBUG:ext\perf_tools.bat] init:COMPLETE
```

Known Workaround
----------------

* Modify `C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Auxiliary\Build\vcvarsall.bat` by inserting `@set VSCMD_DEBUG_KT=0` to line 1.

Release
----------------

Draco is released under the BSD 3-Clause License. For more details see the
[LICENSE file](https://github.com/lanl/Draco/blob/develop/LICENSE.md).
