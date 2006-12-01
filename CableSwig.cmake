# Since CableSwig never calls ADD_TEST, don't bother testing:
SET(ED_test 0)

# Since there's no CableSwig dashboard, never submit:
SET(ED_submit 0)

SET(dir "${CTEST_SCRIPT_DIRECTORY}/../EasyDashboardScripts")
INCLUDE("${dir}/EasyDashboard.cmake")
