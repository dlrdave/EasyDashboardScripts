SET(dir "${CTEST_SCRIPT_DIRECTORY}/../EasyDashboardScripts")

INCLUDE("${dir}/EasyDashboardVariables.cmake")

IF(NOT "${ED_generator}" MATCHES "Makefiles")
  # Limit CMAKE_CONFIGURATION_TYPES to the one of interest so that
  # the tests can run/succeed on non-Debug configs:
  ED_APPEND(ED_cache "CMAKE_CONFIGURATION_TYPES:STRING=${ED_config}")
ENDIF(NOT "${ED_generator}" MATCHES "Makefiles")

IF("${ED_args}" MATCHES "KWW_USE_VTK_5_0")
  ED_APPEND(ED_cache "VTK_DIR:STRING=${ED_dir_mytests}/VTK VTK-5-0-${ED_buildname}")
ELSE("${ED_args}" MATCHES "KWW_USE_VTK_5_0")
  ED_APPEND(ED_cache "VTK_DIR:STRING=${ED_dir_mytests}/VTK ${ED_buildname}")
ENDIF("${ED_args}" MATCHES "KWW_USE_VTK_5_0")

INCLUDE("${dir}/EasyDashboard.cmake")
