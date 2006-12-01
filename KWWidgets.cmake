SET(dir "${CTEST_SCRIPT_DIRECTORY}/../EasyDashboardScripts")

INCLUDE("${dir}/EasyDashboardVariables.cmake")

IF(NOT "${ED_generator}" MATCHES "Makefiles")
  # Limit CMAKE_CONFIGURATION_TYPES to the one of interest so that
  # the tests can run/succeed on non-Debug configs:
  ED_APPEND(ED_cache "CMAKE_CONFIGURATION_TYPES:STRING=${ED_config}")
ENDIF(NOT "${ED_generator}" MATCHES "Makefiles")

ED_APPEND(ED_cache "VTK_DIR:STRING=${ED_dir_mytests}/VTK ${ED_buildname}")

INCLUDE("${dir}/EasyDashboard.cmake")
