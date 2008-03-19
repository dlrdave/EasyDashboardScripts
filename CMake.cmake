SET(dir "${CTEST_SCRIPT_DIRECTORY}/../EasyDashboardScripts")
INCLUDE("${dir}/EasyDashboardVariables.cmake")

# ED_cmd_qmake should be set in Support/EasyDashboardDefaults.cmake on
# machines that have Qt installed.
#
IF(NOT "${ED_cmd_qmake}" STREQUAL "")
  IF(NOT "${ED_args}" MATCHES "BUILD_QtDialog_OFF")
    ED_APPEND(ED_cache "BUILD_QtDialog:BOOL=ON")
  ENDIF(NOT "${ED_args}" MATCHES "BUILD_QtDialog_OFF")
ENDIF(NOT "${ED_cmd_qmake}" STREQUAL "")

IF(NOT "${ED_args}" MATCHES "CTEST_TEST_CTEST_OFF")
  ED_APPEND(ED_cache "CTEST_TEST_CTEST:BOOL=ON")
ENDIF(NOT "${ED_args}" MATCHES "CTEST_TEST_CTEST_OFF")

IF(NOT "${ED_args}" MATCHES "NoPackage")
  SET(ED_buildtarget "package")
ENDIF(NOT "${ED_args}" MATCHES "NoPackage")

INCLUDE("${dir}/EasyDashboard.cmake")
