SET(ED_source "VTK")
SET(ED_tag "VTK-5-0-4")

# CTestConfig.cmake settings since that file does not exist in the VTK-5-0 branch:
#
SET(CTEST_PROJECT_NAME "VTK")
SET(CTEST_NIGHTLY_START_TIME "23:00:00 EDT")
SET(CTEST_DROP_METHOD "http")
SET(CTEST_DROP_SITE "www.vtk.org")
SET(CTEST_DROP_LOCATION "/cgi-bin/HTTPUploadDartFile.cgi")
SET(CTEST_TRIGGER_SITE "http://${CTEST_DROP_SITE}/cgi-bin/Submit-vtk-TestingResults.cgi")

INCLUDE("${CTEST_SCRIPT_DIRECTORY}/VTK.cmake")
