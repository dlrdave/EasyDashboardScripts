SET(VTK_cygwin 0)
IF("${ED_gen}" STREQUAL "cygwin")
  SET(VTK_cygwin 1)
ENDIF("${ED_gen}" STREQUAL "cygwin")

IF("${ED_args}" MATCHES "Examples")
  ED_APPEND(ED_cache "BUILD_EXAMPLES:BOOL=ON")
ENDIF("${ED_args}" MATCHES "Examples")

IF("${ED_args}" MATCHES "EnableMFC")
  ED_APPEND(ED_cache "Module_vtkGUISupportMFC:BOOL=ON")
ENDIF("${ED_args}" MATCHES "EnableMFC")

IF(${VTK_cygwin})
  ED_APPEND(ED_cache "OPENGL_INCLUDE_DIR:PATH=/usr/include/w32api")
ENDIF(${VTK_cygwin})

# By default, turn on VTK_DEBUG_LEAKS.
# If turned off using ED_args, then turn it off...
#
IF("${ED_args}" MATCHES "VTK_DEBUG_LEAKS_OFF")
  ED_APPEND(ED_cache "VTK_DEBUG_LEAKS:BOOL=OFF")
ELSE("${ED_args}" MATCHES "VTK_DEBUG_LEAKS_OFF")
  ED_APPEND(ED_cache "VTK_DEBUG_LEAKS:BOOL=ON")
ENDIF("${ED_args}" MATCHES "VTK_DEBUG_LEAKS_OFF")

IF(APPLE)
  IF("${ED_args}" MATCHES "VTK_USE_COCOA_ON")
    ED_APPEND(ED_cache "VTK_USE_CARBON:BOOL=OFF")
    ED_APPEND(ED_cache "VTK_USE_COCOA:BOOL=ON")
    ED_APPEND(ED_cache "VTK_USE_X:BOOL=OFF")
  ELSE("${ED_args}" MATCHES "VTK_USE_COCOA_ON")
    IF("${ED_args}" MATCHES "VTK_USE_CARBON_ON")
      ED_APPEND(ED_cache "VTK_USE_CARBON:BOOL=ON")
      ED_APPEND(ED_cache "VTK_USE_COCOA:BOOL=OFF")
      ED_APPEND(ED_cache "VTK_USE_X:BOOL=OFF")
    ELSE("${ED_args}" MATCHES "VTK_USE_CARBON_ON")
      IF("${ED_args}" MATCHES "VTK_USE_X_ON")
        ED_APPEND(ED_cache "VTK_USE_CARBON:BOOL=OFF")
        ED_APPEND(ED_cache "VTK_USE_COCOA:BOOL=OFF")
        ED_APPEND(ED_cache "VTK_USE_X:BOOL=ON")
      ENDIF("${ED_args}" MATCHES "VTK_USE_X_ON")
    ENDIF("${ED_args}" MATCHES "VTK_USE_CARBON_ON")
  ENDIF("${ED_args}" MATCHES "VTK_USE_COCOA_ON")
ENDIF(APPLE)

IF("${ED_wrappers}" MATCHES "WrapJava")
  ED_APPEND(ED_cache "VTK_WRAP_JAVA:BOOL=ON")
ENDIF("${ED_wrappers}" MATCHES "WrapJava")

IF("${ED_wrappers}" MATCHES "WrapPython")
  ED_APPEND(ED_cache "VTK_WRAP_PYTHON:BOOL=ON")
ENDIF("${ED_wrappers}" MATCHES "WrapPython")

IF("${ED_wrappers}" MATCHES "WrapTcl")
  ED_APPEND(ED_cache "VTK_WRAP_TCL:BOOL=ON")
ENDIF("${ED_wrappers}" MATCHES "WrapTcl")

# If ED_mesa_lib_dir is set, use mesa as the OpenGL implementation...
# (Somebody somewhere probably also needs to add to the LD_LIBRARY_PATH
# for runtime, too...)
#
IF(ED_mesa_lib_dir)
  # Assume root of mesa install tree is at mesa_lib_dir/.. :
  #
  GET_FILENAME_COMPONENT(ED_mesa_dir "${ED_mesa_lib_dir}/.." ABSOLUTE)

  ED_APPEND(ED_cache "OPENGL_INCLUDE_DIR:PATH=${ED_mesa_dir}/include")
  ED_APPEND(ED_cache "OPENGL_gl_LIBRARY:FILEPATH=${ED_mesa_lib_dir}/libGL.so")
  ED_APPEND(ED_cache "OPENGL_glu_LIBRARY:FILEPATH=${ED_mesa_lib_dir}/libGLU.so")
  ED_APPEND(ED_cache "OPENGL_xmesa_INCLUDE_DIR:PATH=${ED_mesa_dir}/include")
ENDIF()

# If ED_use_system_libs is set, use the commonly available system versions
# of the VTK 3rd party libraries.
#
IF(ED_use_system_libs)
  ED_APPEND(ED_cache "VTK_USE_SYSTEM_EXPAT:BOOL=ON")
  ED_APPEND(ED_cache "VTK_USE_SYSTEM_FREETYPE:BOOL=ON")
  ED_APPEND(ED_cache "VTK_USE_SYSTEM_JPEG:BOOL=ON")
  ED_APPEND(ED_cache "VTK_USE_SYSTEM_LIBXML2:BOOL=ON")
  ED_APPEND(ED_cache "VTK_USE_SYSTEM_PNG:BOOL=ON")
  ED_APPEND(ED_cache "VTK_USE_SYSTEM_TIFF:BOOL=ON")
  ED_APPEND(ED_cache "VTK_USE_SYSTEM_ZLIB:BOOL=ON")
ENDIF(ED_use_system_libs)
