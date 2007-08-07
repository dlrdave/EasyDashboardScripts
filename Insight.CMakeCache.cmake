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


# By default, use USE_WRAP_ITK if it is not already in the cache.
# If using it by default, also suppress language auto detect and
# only wrap in languages explicitly specified in ED_wrappers:
#
IF(NOT "${ED_wrappers}" STREQUAL "")
IF(NOT "${ED_cache}" MATCHES "USE_WRAP_ITK")
  ED_APPEND(ED_cache "USE_WRAP_ITK:BOOL=ON")
  ED_APPEND(ED_cache "NO_LANGUAGES_AUTO_DETECT:BOOL=ON")
ENDIF(NOT "${ED_cache}" MATCHES "USE_WRAP_ITK")
ENDIF(NOT "${ED_wrappers}" STREQUAL "")


# Use CableSwig previously built by another EasyDashboardScript
# (if it's there...):
#
IF(EXISTS "${ED_dir_mytests}/CableSwig ${ED_buildname}")
  ED_APPEND(ED_cache "//Corresponding CableSwig")
  ED_APPEND(ED_cache "CableSwig_DIR:PATH=${ED_dir_mytests}/CableSwig ${ED_buildname}")
ENDIF(EXISTS "${ED_dir_mytests}/CableSwig ${ED_buildname}")


# Then use appropriate cache entries based on that to turn on other
# appropriate cache entries based on ED_args matching Wrap* :
#
IF("${ED_cache}" MATCHES "USE_WRAP_ITK:BOOL=ON")

  IF("${ED_wrappers}" MATCHES "WrapJava")
    ED_APPEND(ED_cache "WRAP_ITK_JAVA:BOOL=ON")
  ENDIF("${ED_wrappers}" MATCHES "WrapJava")

  IF("${ED_wrappers}" MATCHES "WrapPython")
    ED_APPEND(ED_cache "WRAP_ITK_PYTHON:BOOL=ON")
  ENDIF("${ED_wrappers}" MATCHES "WrapPython")

  IF("${ED_wrappers}" MATCHES "WrapTcl")
    ED_APPEND(ED_cache "WRAP_ITK_TCL:BOOL=ON")
  ENDIF("${ED_wrappers}" MATCHES "WrapTcl")

ELSE("${ED_cache}" MATCHES "USE_WRAP_ITK:BOOL=ON")

  IF("${ED_wrappers}" MATCHES "WrapJava")
    ED_APPEND(ED_cache "ITK_CSWIG_JAVA:BOOL=ON")
  ENDIF("${ED_wrappers}" MATCHES "WrapJava")

  IF("${ED_wrappers}" MATCHES "WrapPython")
    ED_APPEND(ED_cache "ITK_CSWIG_PYTHON:BOOL=ON")
  ENDIF("${ED_wrappers}" MATCHES "WrapPython")

  IF("${ED_wrappers}" MATCHES "WrapTcl")
    ED_APPEND(ED_cache "ITK_CSWIG_TCL:BOOL=ON")
  ENDIF("${ED_wrappers}" MATCHES "WrapTcl")

ENDIF("${ED_cache}" MATCHES "USE_WRAP_ITK:BOOL=ON")
