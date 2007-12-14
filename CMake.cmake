SET(dir "${CTEST_SCRIPT_DIRECTORY}/../EasyDashboardScripts")
INCLUDE("${dir}/EasyDashboardVariables.cmake")

IF("${ED_args}" MATCHES "BUILD_QtDialog_ON")
  ED_APPEND(ED_cache "BUILD_QtDialog:BOOL=ON")
ENDIF("${ED_args}" MATCHES "BUILD_QtDialog_ON")

IF("${ED_args}" MATCHES "CTEST_TEST_CTEST_ON")
  ED_APPEND(ED_cache "CTEST_TEST_CTEST:BOOL=ON")
ENDIF("${ED_args}" MATCHES "CTEST_TEST_CTEST_ON")

INCLUDE("${dir}/EasyDashboard.cmake")
