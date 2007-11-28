# ITK BUILD_EXAMPLES defaults to ON. Turn it off if requested.
#
IF("${ED_args}" MATCHES "NoExamples")
  ED_APPEND(ED_cache "BUILD_EXAMPLES:BOOL=OFF")
ENDIF("${ED_args}" MATCHES "NoExamples")


# ITK BUILD_SHARED_LIBS defaults to OFF. Turn it on if requested.
#
IF("${ED_args}" MATCHES "Shared")
  ED_APPEND(ED_cache "BUILD_SHARED_LIBS:BOOL=ON")
ENDIF("${ED_args}" MATCHES "Shared")


#BUILD_TESTING:BOOL=ON - default?

ED_APPEND(ED_cache "ITK_USE_CONCEPT_CHECKING:BOOL=ON")
ED_APPEND(ED_cache "ITK_USE_PATENTED:BOOL=ON")
ED_APPEND(ED_cache "ITK_USE_REVIEW:BOOL=ON")


# Use CableSwig previously built by another EasyDashboardScript
# (if it's there...):
#
IF(EXISTS "${ED_dir_mytests}/CableSwig ${ED_buildname}")
  ED_APPEND(ED_cache "//Corresponding CableSwig")
  ED_APPEND(ED_cache "CableSwig_DIR:PATH=${ED_dir_mytests}/CableSwig ${ED_buildname}")
ENDIF(EXISTS "${ED_dir_mytests}/CableSwig ${ED_buildname}")


# Then turn on appropriate cache entries for wrapping:
#
IF("${ED_args}" MATCHES "USE_WRAP_ITK_WRAPPING")
  ED_APPEND(ED_cache "USE_WRAP_ITK:BOOL=ON")
  ED_APPEND(ED_cache "NO_LANGUAGES_AUTO_DETECT:BOOL=ON")

  IF("${ED_wrappers}" MATCHES "WrapJava")
    ED_APPEND(ED_cache "WRAP_ITK_JAVA:BOOL=ON")
  ENDIF("${ED_wrappers}" MATCHES "WrapJava")

  IF("${ED_wrappers}" MATCHES "WrapPython")
    ED_APPEND(ED_cache "WRAP_ITK_PYTHON:BOOL=ON")
  ENDIF("${ED_wrappers}" MATCHES "WrapPython")

  IF("${ED_wrappers}" MATCHES "WrapTcl")
    ED_APPEND(ED_cache "WRAP_ITK_TCL:BOOL=ON")
  ENDIF("${ED_wrappers}" MATCHES "WrapTcl")
ENDIF("${ED_args}" MATCHES "USE_WRAP_ITK_WRAPPING")

IF("${ED_args}" MATCHES "USE_ITK_CSWIG_WRAPPING")
  IF("${ED_wrappers}" MATCHES "WrapJava")
    ED_APPEND(ED_cache "ITK_CSWIG_JAVA:BOOL=ON")
  ENDIF("${ED_wrappers}" MATCHES "WrapJava")

  IF("${ED_wrappers}" MATCHES "WrapPython")
    ED_APPEND(ED_cache "ITK_CSWIG_PYTHON:BOOL=ON")
  ENDIF("${ED_wrappers}" MATCHES "WrapPython")

  IF("${ED_wrappers}" MATCHES "WrapTcl")
    ED_APPEND(ED_cache "ITK_CSWIG_TCL:BOOL=ON")
  ENDIF("${ED_wrappers}" MATCHES "WrapTcl")
ENDIF("${ED_args}" MATCHES "USE_ITK_CSWIG_WRAPPING")
