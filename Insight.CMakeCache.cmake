IF("${ED_args}" MATCHES "NoExamples")
  ED_APPEND(ED_cache "BUILD_EXAMPLES:BOOL=OFF")
ENDIF("${ED_args}" MATCHES "NoExamples")

IF("${ED_args}" MATCHES "Shared")
  ED_APPEND(ED_cache "BUILD_SHARED_LIBS:BOOL=ON")
ENDIF("${ED_args}" MATCHES "Shared")
