CMAKE_MINIMUM_REQUIRED(VERSION 2.4 FATAL_ERROR)

GET_FILENAME_COMPONENT(ED_script_EasyDashboard "${CMAKE_CURRENT_LIST_FILE}" ABSOLUTE)
GET_FILENAME_COMPONENT(ED_dir_EasyDashboard "${CMAKE_CURRENT_LIST_FILE}" PATH)

SET(ED_revision_EasyDashboard "$Revision: 1.5 $")
SET(ED_date_EasyDashboard "$Date: 2007/06/04 15:24:45 $")
SET(ED_author_EasyDashboard "$Author: david.cole $")
SET(ED_rcsfile_EasyDashboard "$RCSfile: EasyDashboard.cmake,v $")

IF(NOT DEFINED ED_script_EasyDashboardVariables)
  INCLUDE("${ED_dir_EasyDashboard}/EasyDashboardVariables.cmake")
ENDIF(NOT DEFINED ED_script_EasyDashboardVariables)

SET(dir "${ED_dir_mytests}")
IF("${ED_model}" STREQUAL "Continuous")
  SET(dir "${ED_dir_mytests}/Continuous")
ENDIF("${ED_model}" STREQUAL "Continuous")

IF(NOT DEFINED CTEST_SOURCE_DIRECTORY)
  IF(NOT "${ED_source}" STREQUAL "")
    IF(NOT "${ED_tag}" STREQUAL "")
      SET(CTEST_SOURCE_DIRECTORY "${dir}/${ED_tag}/${ED_source}")
    ELSE(NOT "${ED_tag}" STREQUAL "")
      SET(CTEST_SOURCE_DIRECTORY "${dir}/${ED_source}")
    ENDIF(NOT "${ED_tag}" STREQUAL "")
  ENDIF(NOT "${ED_source}" STREQUAL "")

  IF(NOT "${ED_data}" STREQUAL "")
    IF(NOT "${ED_tag}" STREQUAL "")
      SET(CTEST_DATA_DIRECTORY "${dir}/${ED_tag}/${ED_data}")
    ELSE(NOT "${ED_tag}" STREQUAL "")
      SET(CTEST_DATA_DIRECTORY "${dir}/${ED_data}")
    ENDIF(NOT "${ED_tag}" STREQUAL "")
  ENDIF(NOT "${ED_data}" STREQUAL "")
ENDIF(NOT DEFINED CTEST_SOURCE_DIRECTORY)

IF(NOT DEFINED CTEST_BINARY_DIRECTORY)
  IF(NOT "${ED_tag}" STREQUAL "")
    SET(CTEST_BINARY_DIRECTORY "${dir}/${ED_sourcename} ${ED_tag}-${ED_buildname}")
  ELSE(NOT "${ED_tag}" STREQUAL "")
    SET(CTEST_BINARY_DIRECTORY "${dir}/${ED_sourcename} ${ED_buildname}")
  ENDIF(NOT "${ED_tag}" STREQUAL "")
ENDIF(NOT DEFINED CTEST_BINARY_DIRECTORY)

IF(NOT DEFINED CTEST_BUILD_CONFIGURATION)
  SET(CTEST_BUILD_CONFIGURATION "${ED_config}")
ENDIF(NOT DEFINED CTEST_BUILD_CONFIGURATION)

IF(NOT DEFINED CTEST_BUILD_NAME)
  IF(NOT "${ED_tag}" STREQUAL "")
    SET(CTEST_BUILD_NAME "${ED_tag}-${ED_buildname}")
  ELSE(NOT "${ED_tag}" STREQUAL "")
    SET(CTEST_BUILD_NAME "${ED_buildname}")
  ENDIF(NOT "${ED_tag}" STREQUAL "")
ENDIF(NOT DEFINED CTEST_BUILD_NAME)

IF(NOT DEFINED CTEST_CMAKE_GENERATOR)
  SET(CTEST_CMAKE_GENERATOR "${ED_generator}")
ENDIF(NOT DEFINED CTEST_CMAKE_GENERATOR)

IF(NOT DEFINED CTEST_SITE)
  SET(CTEST_SITE "${ED_site}")
ENDIF(NOT DEFINED CTEST_SITE)

IF(NOT DEFINED CTEST_UPDATE_COMMAND)
  IF(EXISTS "${CTEST_SOURCE_DIRECTORY}/.svn")
    FIND_PROGRAM(CTEST_UPDATE_COMMAND svn
      "C:/Program Files/Subversion/bin"
      "C:/Program Files (x86)/Subversion/bin"
      "C:/cygwin/bin"
      "/usr/bin"
      "/usr/local/bin"
      )
  ENDIF(EXISTS "${CTEST_SOURCE_DIRECTORY}/.svn")
ENDIF(NOT DEFINED CTEST_UPDATE_COMMAND)

IF(NOT DEFINED CTEST_UPDATE_COMMAND)
  IF(EXISTS "${CTEST_SOURCE_DIRECTORY}/CVS")
    FIND_PROGRAM(CTEST_UPDATE_COMMAND cvs
      "C:/Program Files/TortoiseCVS"
      "C:/Program Files (x86)/TortoiseCVS"
      "C:/cygwin/bin"
      "/usr/bin"
      "/usr/local/bin"
      )
  ENDIF(EXISTS "${CTEST_SOURCE_DIRECTORY}/CVS")
ENDIF(NOT DEFINED CTEST_UPDATE_COMMAND)

IF(NOT DEFINED CTEST_UPDATE_OPTIONS)
  IF("${CTEST_UPDATE_COMMAND}" MATCHES "svn")
    IF(NOT "${ED_tag}" STREQUAL "")
      # TODO:
      #   ...how to update svn source tree to a tag...?
      #   svn switch first?
      #   how can I predict the URL for the switch call based
      #     on info I already have...?
      #SET(CTEST_UPDATE_OPTIONS "-r ${ED_tag}")
    ELSE(NOT "${ED_tag}" STREQUAL "")
      # svn updates properly with no flags
      #SET(CTEST_UPDATE_OPTIONS "")
    ENDIF(NOT "${ED_tag}" STREQUAL "")
  ENDIF("${CTEST_UPDATE_COMMAND}" MATCHES "svn")

  IF("${CTEST_UPDATE_COMMAND}" MATCHES "cvs")
    IF(NOT "${ED_tag}" STREQUAL "")
      SET(CTEST_UPDATE_OPTIONS "-dAP -r ${ED_tag}")
    ELSE(NOT "${ED_tag}" STREQUAL "")
      SET(CTEST_UPDATE_OPTIONS "-dAP")
    ENDIF(NOT "${ED_tag}" STREQUAL "")
  ENDIF("${CTEST_UPDATE_COMMAND}" MATCHES "cvs")
ENDIF(NOT DEFINED CTEST_UPDATE_OPTIONS)

IF(NOT DEFINED CTEST_COVERAGE_COMMAND)
  FIND_PROGRAM(CTEST_COVERAGE_COMMAND NAMES cov01 gcov
    PATHS
    "C:/Program Files/BullseyeCoverage/bin"
    "C:/Program Files (x86)/BullseyeCoverage/bin"
    "C:/cygwin/bin"
    "/usr/bin"
    "/usr/local/bin"
    )
ENDIF(NOT DEFINED CTEST_COVERAGE_COMMAND)

SET(CTEST_COVERAGE_COMMAND_DIR "")
IF(CTEST_COVERAGE_COMMAND)
  GET_FILENAME_COMPONENT(CTEST_COVERAGE_COMMAND_DIR "${CTEST_COVERAGE_COMMAND}" PATH)
ENDIF(CTEST_COVERAGE_COMMAND)

FIND_PROGRAM(ED_cmd_coverage_switch cov01
  "C:/Program Files/BullseyeCoverage/bin"
  "C:/Program Files (x86)/BullseyeCoverage/bin"
  "C:/cygwin/bin"
  "/usr/bin"
  "/usr/local/bin"
  )

IF(${ED_coverage})
  #
  # Ensure coverage tools are in the PATH, COVFILE is set
  # in the environment and coverage is switched on:
  #
  IF(NOT "${CTEST_COVERAGE_COMMAND_DIR}" STREQUAL "")
    IF(WIN32)
      SET(ENV{PATH} "${CTEST_COVERAGE_COMMAND_DIR}\;$ENV{PATH}")
    ELSE(WIN32)
      SET(ENV{PATH} "${CTEST_COVERAGE_COMMAND_DIR}:$ENV{PATH}")
    ENDIF(WIN32)
  ENDIF(NOT "${CTEST_COVERAGE_COMMAND_DIR}" STREQUAL "")

  SET(ENV{COVFILE} "${CTEST_BINARY_DIRECTORY}/CoverageData.cov")

  IF(ED_cmd_coverage_switch)
    EXECUTE_PROCESS(COMMAND ${ED_cmd_coverage_switch} "-1")
  ENDIF(ED_cmd_coverage_switch)
ELSE(${ED_coverage})
  IF(ED_cmd_coverage_switch)
    EXECUTE_PROCESS(COMMAND ${ED_cmd_coverage_switch} "-0")
  ENDIF(ED_cmd_coverage_switch)
ENDIF(${ED_coverage})


INCLUDE("${ED_dir_support}/EasyDashboardOverrides.cmake" OPTIONAL)


# TODO: provide mechanism to avoid attaching these notes files?
# (Write this as a macro and only attach files that exist and files
# that are not *already in* ED_notes... for *all* the files listed
# in this section, not just the root script as here: )
#
# Prepend the root script as a note if it's not already in ED_notes:
#
SET(found 0)
FOREACH(n ${ED_notes})
  IF("${n}" STREQUAL "${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}")
    SET(found 1)
  ENDIF("${n}" STREQUAL "${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}")
ENDFOREACH(n)
IF(NOT ${found})
  SET(ED_notes "${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}" ${ED_notes})
ENDIF(NOT ${found})

# Prepend ED_info.xml so it's the note at the top:
#
SET(ED_notes "${CTEST_BINARY_DIRECTORY}/ED_info.xml" ${ED_notes})

# Append EasyDashboard system scripts and the final CMakeCache.txt:
#
#SET(ED_notes ${ED_notes} "${ED_projectcachescript}")
SET(ED_notes ${ED_notes} "${ED_script_EasyDashboard}")
SET(ED_notes ${ED_notes} "${ED_script_EasyDashboardVariables}")
#SET(ED_notes ${ED_notes} "${ED_dir_support}/EasyDashboardDefaults.cmake")
#SET(ED_notes ${ED_notes} "${ED_dir_support}/EasyDashboardOverrides.cmake")
SET(ED_notes ${ED_notes} "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt")

IF(NOT DEFINED CTEST_NOTES_FILES)
  SET(CTEST_NOTES_FILES ${ED_notes})
ENDIF(NOT DEFINED CTEST_NOTES_FILES)


INCLUDE("${ED_projectcachescript}" OPTIONAL)


# TODO: provide mechanism to avoid setting these default cache values?
#
IF(NOT "${ED_cache}" MATCHES "BUILDNAME:")
  ED_APPEND(ED_cache "BUILDNAME:STRING=${ED_buildname}")
ENDIF(NOT "${ED_cache}" MATCHES "BUILDNAME:")

IF("${CTEST_CMAKE_GENERATOR}" MATCHES "Make")
  IF(NOT "${ED_cache}" MATCHES "CMAKE_BUILD_TYPE:")
    ED_APPEND(ED_cache "CMAKE_BUILD_TYPE:STRING=${CTEST_BUILD_CONFIGURATION}")
  ENDIF(NOT "${ED_cache}" MATCHES "CMAKE_BUILD_TYPE:")
ENDIF("${CTEST_CMAKE_GENERATOR}" MATCHES "Make")

IF(NOT "${ED_cache}" MATCHES "CMAKE_INSTALL_PREFIX:")
  ED_APPEND(ED_cache "CMAKE_INSTALL_PREFIX:STRING=${CTEST_BINARY_DIRECTORY} Install")
ENDIF(NOT "${ED_cache}" MATCHES "CMAKE_INSTALL_PREFIX:")

IF(NOT "${ED_cache}" MATCHES "SITE:")
  ED_APPEND(ED_cache "SITE:STRING=${ED_site}")
ENDIF(NOT "${ED_cache}" MATCHES "SITE:")


# Run the stages of the dashboard:
#   (in a WHILE loop if model is Continuous)
#
IF(${ED_clean})
  CTEST_EMPTY_BINARY_DIRECTORY("${CTEST_BINARY_DIRECTORY}")
ENDIF(${ED_clean})


ED_GET_EasyDashboardInfo(ED_info)
FILE(APPEND "${CTEST_BINARY_DIRECTORY}/ED_info PreConfigure.xml" "${ED_info}")

IF(NOT EXISTS "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt")
  FILE(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt" "${ED_cache}")
ENDIF(NOT EXISTS "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt")


SET(first_time 1)
SET(done 0)
WHILE(NOT ${done})
  SET(START_TIME ${CTEST_ELAPSED_TIME})


MESSAGE(STATUS "Calling CTEST_START(\"${ED_model}\").  START_TIME: ${START_TIME}")
CTEST_START("${ED_model}")


IF(${ED_update})
  IF(NOT "${CTEST_DATA_DIRECTORY}" STREQUAL "")
    CTEST_UPDATE(SOURCE "${CTEST_DATA_DIRECTORY}")
  ENDIF(NOT "${CTEST_DATA_DIRECTORY}" STREQUAL "")

  CTEST_UPDATE(SOURCE "${CTEST_SOURCE_DIRECTORY}" RETURN_VALUE files_updated)
ELSE(${ED_update})
  SET(files_updated "0")
ENDIF(${ED_update})


IF(NOT "${ED_model}" STREQUAL "Continuous")
IF("${files_updated}" STREQUAL "0")
  # Pretend so remaining steps run:
  SET(files_updated 1)
ENDIF("${files_updated}" STREQUAL "0")
ENDIF(NOT "${ED_model}" STREQUAL "Continuous")

IF(${first_time})
IF("${files_updated}" STREQUAL "0")
  # Pretend so remaining steps run:
  SET(files_updated 1)
ENDIF("${files_updated}" STREQUAL "0")
ENDIF(${first_time})

SET(first_time 0)


IF("${files_updated}" GREATER "0")


IF(${ED_configure})
  CTEST_CONFIGURE(BUILD "${CTEST_BINARY_DIRECTORY}")
ENDIF(${ED_configure})


CTEST_READ_CUSTOM_FILES("${CTEST_BINARY_DIRECTORY}")


# For projects that have no CTestConfig.cmake and have not
# defined the necessary variables within their dashboard
# scripts...
#
IF(NOT EXISTS "${CTEST_BINARY_DIRECTORY}/CTestConfig.cmake")
  IF(NOT DEFINED CTEST_PROJECT_NAME)
    SET(CTEST_PROJECT_NAME "${ED_sourcename}")
  ENDIF(NOT DEFINED CTEST_PROJECT_NAME)

  IF(NOT DEFINED CTEST_NIGHTLY_START_TIME)
    SET(CTEST_NIGHTLY_START_TIME "03:04:05 EDT")
  ENDIF(NOT DEFINED CTEST_NIGHTLY_START_TIME)

  IF(NOT DEFINED CTEST_DROP_METHOD)
    SET(CTEST_DROP_METHOD "NoDropMethod")
  ENDIF(NOT DEFINED CTEST_DROP_METHOD)

  IF(NOT DEFINED CTEST_DROP_SITE)
    SET(CTEST_DROP_SITE "NoSite")
  ENDIF(NOT DEFINED CTEST_DROP_SITE)

  IF(NOT DEFINED CTEST_DROP_LOCATION)
    SET(CTEST_DROP_LOCATION "NoLocation")
  ENDIF(NOT DEFINED CTEST_DROP_LOCATION)

  IF(NOT DEFINED CTEST_TRIGGER_SITE)
    SET(CTEST_TRIGGER_SITE "NoTriggerSite")
  ENDIF(NOT DEFINED CTEST_TRIGGER_SITE)
ENDIF(NOT EXISTS "${CTEST_BINARY_DIRECTORY}/CTestConfig.cmake")


ED_GET_EasyDashboardInfo(ED_info)
FILE(APPEND "${CTEST_BINARY_DIRECTORY}/ED_info.xml" "${ED_info}")


IF(${ED_build})
  CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}")
ENDIF(${ED_build})


IF(${ED_test})
  CTEST_TEST(BUILD "${CTEST_BINARY_DIRECTORY}")
ENDIF(${ED_test})


IF(${ED_coverage})
  CTEST_COVERAGE(BUILD "${CTEST_BINARY_DIRECTORY}")
ENDIF(${ED_coverage})


IF(${ED_submit})
  CTEST_SUBMIT()
ENDIF(${ED_submit})


IF(${ED_verbose})
  ED_DUMP_EasyDashboardInfo()
ENDIF(${ED_verbose})

ENDIF("${files_updated}" GREATER "0")


  # If it's a continuous dashboard, then it's done if we've exceeded
  # the continuous dashboard run threshold (${ED_duration} seconds)
  #
  # If it's not a continuous dashboard, then we're just done...
  #
  IF("${ED_model}" STREQUAL "Continuous")
    IF(${CTEST_ELAPSED_TIME} GREATER ${ED_duration})
      SET(done 1)
      MESSAGE(STATUS "${ED_model} dashboard done. CTEST_ELAPSED_TIME: ${CTEST_ELAPSED_TIME}")
    ELSE(${CTEST_ELAPSED_TIME} GREATER ${ED_duration})
      MESSAGE(STATUS "Calling CTEST_SLEEP.  ED_interval: ${ED_interval}  CTEST_ELAPSED_TIME: ${CTEST_ELAPSED_TIME}")
      CTEST_SLEEP(${START_TIME} ${ED_interval} ${CTEST_ELAPSED_TIME})
      MESSAGE(STATUS "Returned from CTEST_SLEEP.  CTEST_ELAPSED_TIME: ${CTEST_ELAPSED_TIME}")
    ENDIF(${CTEST_ELAPSED_TIME} GREATER ${ED_duration})
  ELSE("${ED_model}" STREQUAL "Continuous")
    SET(done 1)
    MESSAGE(STATUS "${ED_model} dashboard done. CTEST_ELAPSED_TIME: ${CTEST_ELAPSED_TIME}")
  ENDIF("${ED_model}" STREQUAL "Continuous")

ENDWHILE(NOT ${done})


SET(CTEST_RUN_CURRENT_SCRIPT 0)
