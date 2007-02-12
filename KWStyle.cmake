# KWStyle "CTestConfig.cmake equivalents" since that file does not yet exist in KWStyle:
#
SET(CTEST_PROJECT_NAME "KWStyle")
SET(CTEST_NIGHTLY_START_TIME "21:00:00 EDT")
SET(CTEST_DROP_METHOD "http")
SET(CTEST_DROP_SITE "public.kitware.com")
SET(CTEST_DROP_LOCATION "/cgi-bin/HTTPUploadDartFile.cgi")
SET(CTEST_TRIGGER_SITE "http://${CTEST_DROP_SITE}/cgi-bin/SubmitKWStyle.cgi")

SET(dir "${CTEST_SCRIPT_DIRECTORY}/../EasyDashboardScripts")
INCLUDE("${dir}/EasyDashboard.cmake")
