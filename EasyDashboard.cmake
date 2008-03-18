CMAKE_MINIMUM_REQUIRED(VERSION 2.4 FATAL_ERROR)

GET_FILENAME_COMPONENT(ED_script_EasyDashboard "${CMAKE_CURRENT_LIST_FILE}" ABSOLUTE)
GET_FILENAME_COMPONENT(ED_dir_EasyDashboard "${CMAKE_CURRENT_LIST_FILE}" PATH)

SET(ED_revision_EasyDashboard "$Revision: 1.21 $")
SET(ED_date_EasyDashboard "$Date: 2008/03/18 20:03:31 $")
SET(ED_author_EasyDashboard "$Author: david.cole $")
SET(ED_rcsfile_EasyDashboard "$RCSfile: EasyDashboard.cmake,v $")

IF(NOT DEFINED ED_script_EasyDashboardVariables)
  INCLUDE("${ED_dir_EasyDashboard}/EasyDashboardVariables.cmake")
ENDIF(NOT DEFINED ED_script_EasyDashboardVariables)

SET(dir "${ED_dir_mytests}")
IF(NOT "${ED_model}" STREQUAL "Experimental")
  SET(dir "${ED_dir_mytests}/${ED_model}")
ENDIF(NOT "${ED_model}" STREQUAL "Experimental")

IF(NOT DEFINED CTEST_SOURCE_DIRECTORY)
  IF(NOT "${ED_source}" STREQUAL "")
    IF("${ED_tag_dir}" STREQUAL "")
      SET(CTEST_SOURCE_DIRECTORY "${dir}/${ED_source}")
    ELSE("${ED_tag_dir}" STREQUAL "")
      SET(CTEST_SOURCE_DIRECTORY "${dir}/${ED_tag_dir}/${ED_source}")
    ENDIF("${ED_tag_dir}" STREQUAL "")
  ENDIF(NOT "${ED_source}" STREQUAL "")

  IF(NOT "${ED_data}" STREQUAL "")
    IF("${ED_tag_dir}" STREQUAL "")
      SET(CTEST_DATA_DIRECTORY "${dir}/${ED_data}")
    ELSE("${ED_tag_dir}" STREQUAL "")
      SET(CTEST_DATA_DIRECTORY "${dir}/${ED_tag_dir}/${ED_data}")
    ENDIF("${ED_tag_dir}" STREQUAL "")
  ENDIF(NOT "${ED_data}" STREQUAL "")
ENDIF(NOT DEFINED CTEST_SOURCE_DIRECTORY)

IF(NOT DEFINED CTEST_BUILD_NAME)
  IF("${ED_tag_buildname}" STREQUAL "")
    SET(CTEST_BUILD_NAME "${ED_buildname}")
  ELSE("${ED_tag_buildname}" STREQUAL "")
    SET(CTEST_BUILD_NAME "${ED_tag_buildname}-${ED_buildname}")
  ENDIF("${ED_tag_buildname}" STREQUAL "")

  IF(${ED_coverage})
    SET(CTEST_BUILD_NAME "${CTEST_BUILD_NAME}-Coverage")
  ENDIF(${ED_coverage})

  IF(${ED_kwstyle})
    SET(CTEST_BUILD_NAME "${CTEST_BUILD_NAME}-KWStyle")
  ENDIF(${ED_kwstyle})
ENDIF(NOT DEFINED CTEST_BUILD_NAME)

IF(NOT DEFINED CTEST_BUILD_TARGET)
  IF(DEFINED ED_buildtarget)
    SET(CTEST_BUILD_TARGET "${ED_buildtarget}")
  ENDIF(DEFINED ED_buildtarget)
ENDIF(NOT DEFINED CTEST_BUILD_TARGET)

IF(NOT DEFINED CTEST_BINARY_DIRECTORY)
  SET(CTEST_BINARY_DIRECTORY "${dir}/${ED_sourcename} ${CTEST_BUILD_NAME}")
ENDIF(NOT DEFINED CTEST_BINARY_DIRECTORY)

IF(NOT DEFINED CTEST_BUILD_CONFIGURATION)
  SET(CTEST_BUILD_CONFIGURATION "${ED_config}")
ENDIF(NOT DEFINED CTEST_BUILD_CONFIGURATION)

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
      "C:/Program Files/CVSNT"
      "C:/Program Files (x86)/CVSNT"
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
    # svn updates properly with no flags
    #SET(CTEST_UPDATE_OPTIONS "")
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
IF(NOT "${ED_cache}" MATCHES "BUILD_SHARED_LIBS:")
  IF("${ED_args}" MATCHES "Static")
    ED_APPEND(ED_cache "BUILD_SHARED_LIBS:BOOL=OFF")
  ELSE("${ED_args}" MATCHES "Static")
    IF("${ED_args}" MATCHES "Shared")
      ED_APPEND(ED_cache "BUILD_SHARED_LIBS:BOOL=ON")
    ENDIF("${ED_args}" MATCHES "Shared")
  ENDIF("${ED_args}" MATCHES "Static")
ENDIF(NOT "${ED_cache}" MATCHES "BUILD_SHARED_LIBS:")

IF(NOT "${ED_cache}" MATCHES "BUILDNAME:")
  ED_APPEND(ED_cache "BUILDNAME:STRING=${CTEST_BUILD_NAME}")
ENDIF(NOT "${ED_cache}" MATCHES "BUILDNAME:")

IF("${CTEST_CMAKE_GENERATOR}" MATCHES "Make")
  IF(NOT "${ED_cache}" MATCHES "CMAKE_BUILD_TYPE:")
    ED_APPEND(ED_cache "CMAKE_BUILD_TYPE:STRING=${CTEST_BUILD_CONFIGURATION}")
  ENDIF(NOT "${ED_cache}" MATCHES "CMAKE_BUILD_TYPE:")
ENDIF("${CTEST_CMAKE_GENERATOR}" MATCHES "Make")

IF(NOT "${ED_cache}" MATCHES "CMAKE_INSTALL_PREFIX:")
  ED_APPEND(ED_cache "CMAKE_INSTALL_PREFIX:STRING=${CTEST_BINARY_DIRECTORY} Install")
ENDIF(NOT "${ED_cache}" MATCHES "CMAKE_INSTALL_PREFIX:")

IF(ED_cmd_qmake)
  IF(NOT "${ED_cache}" MATCHES "QT_QMAKE_EXECUTABLE:")
    ED_APPEND(ED_cache "QT_QMAKE_EXECUTABLE:FILEPATH=${ED_cmd_qmake}")
  ENDIF(NOT "${ED_cache}" MATCHES "QT_QMAKE_EXECUTABLE:")
ENDIF(ED_cmd_qmake)

IF(NOT "${ED_cache}" MATCHES "SITE:")
  ED_APPEND(ED_cache "SITE:STRING=${ED_site}")
ENDIF(NOT "${ED_cache}" MATCHES "SITE:")


# If CTEST_UPDATE_COMMAND is *still* not defined, then force
# ED_update to 0 - we cannot update if CTEST_UPDATE_COMMAND is
# not defined...
#
IF(NOT DEFINED CTEST_UPDATE_COMMAND)
  SET(ED_update 0)
ENDIF(NOT DEFINED CTEST_UPDATE_COMMAND)


# Run the stages of the dashboard:
#   (in a WHILE loop if model is Continuous)
#
IF(${ED_clean})
  CTEST_EMPTY_BINARY_DIRECTORY("${CTEST_BINARY_DIRECTORY}")
ENDIF(${ED_clean})


IF(${ED_coverage})
  #
  # Important to set these environment settings prior to the first configure.
  # For Bullseye coverage builds with make and cl, CMake needs to find the Bullseye
  # cl first, so it needs to be at the front of the PATH...
  #
  # Ensure coverage tools are in the PATH
  # and COVFILE is set in the environment:
  #
  IF(NOT "${CTEST_COVERAGE_COMMAND_DIR}" STREQUAL "")
    IF(WIN32)
      STRING(REGEX REPLACE "/" "\\\\" CTEST_COVERAGE_COMMAND_DIR "${CTEST_COVERAGE_COMMAND_DIR}")
      SET(ENV{PATH} "${CTEST_COVERAGE_COMMAND_DIR};$ENV{PATH}")
    ELSE(WIN32)
      SET(ENV{PATH} "${CTEST_COVERAGE_COMMAND_DIR}:$ENV{PATH}")
    ENDIF(WIN32)
  ENDIF(NOT "${CTEST_COVERAGE_COMMAND_DIR}" STREQUAL "")

  SET(ENV{COVFILE} "${CTEST_BINARY_DIRECTORY}/CoverageData.cov")

  # Write a small script that can be executed to set the COVFILE
  # env var "interactively" later on by a developer. (Useful if you
  # need to run the exes with coverage later on -- if COVFILE is
  # different when you run the exes, they complain...)
  #
  FILE(WRITE "${CTEST_BINARY_DIRECTORY}/setCOVFILE.cmd"
    "set COVFILE=${CTEST_BINARY_DIRECTORY}/CoverageData.cov\ncov01 -1\ncov01 -s\n")
ENDIF(${ED_coverage})


ED_GET_EasyDashboardInfo(ED_info)
FILE(APPEND "${CTEST_BINARY_DIRECTORY}/ED_info PreConfigure.xml" "${ED_info}")


IF(NOT EXISTS "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt")
  FILE(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt" "${ED_cache}")
ENDIF(NOT EXISTS "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt")


SET(first_time 1)
SET(done 0)
WHILE(NOT ${done})
  SET(START_TIME ${CTEST_ELAPSED_TIME})


IF(${ED_start})
  MESSAGE("Calling CTEST_START(\"${ED_model}\").  START_TIME: ${START_TIME}")
  CTEST_START("${ED_model}")
ENDIF(${ED_start})


SET(do_svn_switch 0)

IF(${ED_update})
  # For svn, we need to do a "switch" in the source directory
  # prior to the update step... Switch to the repository URL
  # directly or to an ED_tag-inspired URL for tag/branch builds...
  #
  IF("${ED_source_repository_type}" STREQUAL "svn")
    SET(do_svn_switch 1)
  ENDIF("${ED_source_repository_type}" STREQUAL "svn")

  IF(NOT "${CTEST_DATA_DIRECTORY}" STREQUAL "")
    IF(do_svn_switch)
      SET(url "${ED_data_repository}")
      IF(NOT "${ED_tag}" STREQUAL "")
        STRING(REPLACE "/trunk" "/${ED_tag}" url "${ED_data_repository}")
      ENDIF(NOT "${ED_tag}" STREQUAL "")
      EXECUTE_PROCESS(
        COMMAND ${CTEST_UPDATE_COMMAND} switch ${url}
        WORKING_DIRECTORY "${CTEST_DATA_DIRECTORY}"
        )
    ENDIF(do_svn_switch)

    CTEST_UPDATE(SOURCE "${CTEST_DATA_DIRECTORY}")
  ENDIF(NOT "${CTEST_DATA_DIRECTORY}" STREQUAL "")

  IF(do_svn_switch)
    SET(url "${ED_source_repository}")
    IF(NOT "${ED_tag}" STREQUAL "")
      STRING(REPLACE "/trunk" "/${ED_tag}" url "${ED_source_repository}")
    ENDIF(NOT "${ED_tag}" STREQUAL "")
    EXECUTE_PROCESS(
      COMMAND ${CTEST_UPDATE_COMMAND} switch ${url}
      WORKING_DIRECTORY "${CTEST_SOURCE_DIRECTORY}"
      )
  ENDIF(do_svn_switch)

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
IF(EXISTS "${CTEST_BINARY_DIRECTORY}/CTestConfig.cmake")
  INCLUDE("${CTEST_BINARY_DIRECTORY}/CTestConfig.cmake")
ELSE(EXISTS "${CTEST_BINARY_DIRECTORY}/CTestConfig.cmake")
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
ENDIF(EXISTS "${CTEST_BINARY_DIRECTORY}/CTestConfig.cmake")


# If CTEST_DROP_METHOD is the bogus "NoDropMethod", then force
# ED_submit to 0 - we cannot submit with a bogus drop method...
#
IF("${CTEST_DROP_METHOD}" STREQUAL "NoDropMethod")
  SET(ED_submit 0)
ENDIF("${CTEST_DROP_METHOD}" STREQUAL "NoDropMethod")


ED_GET_EasyDashboardInfo(ED_info)
FILE(APPEND "${CTEST_BINARY_DIRECTORY}/ED_info.xml" "${ED_info}")


# Ensure coverage tools are switched on or off.
# (Do this after the configure step so that TRY_COMPILE results do not get
# recorded in the coverage file...)
#
IF(ED_cmd_coverage_switch)
  IF(${ED_coverage})
    EXECUTE_PROCESS(COMMAND ${ED_cmd_coverage_switch} "-1")
  ELSE(${ED_coverage})
    EXECUTE_PROCESS(COMMAND ${ED_cmd_coverage_switch} "-0")
  ENDIF(${ED_coverage})
ENDIF(ED_cmd_coverage_switch)


IF(${ED_build})
  CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}")
ENDIF(${ED_build})


IF(${ED_test})
  CTEST_TEST(BUILD "${CTEST_BINARY_DIRECTORY}")
ENDIF(${ED_test})


IF(${ED_kwstyle})
  EXECUTE_PROCESS(
    COMMAND ${ED_cmd_KWStyle} ${ED_cmd_KWStyle_args}
    WORKING_DIRECTORY "${CTEST_BINARY_DIRECTORY}"
    )
ENDIF(${ED_kwstyle})


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
      MESSAGE("${ED_model} dashboard done. CTEST_ELAPSED_TIME: ${CTEST_ELAPSED_TIME}")
    ELSE(${CTEST_ELAPSED_TIME} GREATER ${ED_duration})
      MESSAGE("Calling CTEST_SLEEP.  ED_interval: ${ED_interval}  CTEST_ELAPSED_TIME: ${CTEST_ELAPSED_TIME}")
      CTEST_SLEEP(${START_TIME} ${ED_interval} ${CTEST_ELAPSED_TIME})
      MESSAGE("Returned from CTEST_SLEEP.  CTEST_ELAPSED_TIME: ${CTEST_ELAPSED_TIME}")
    ENDIF(${CTEST_ELAPSED_TIME} GREATER ${ED_duration})
  ELSE("${ED_model}" STREQUAL "Continuous")
    SET(done 1)
    MESSAGE("${ED_model} dashboard done. CTEST_ELAPSED_TIME: ${CTEST_ELAPSED_TIME}")
  ENDIF("${ED_model}" STREQUAL "Continuous")

ENDWHILE(NOT ${done})


# Turn coverage switch back off if we turned it on above:
#
IF(ED_cmd_coverage_switch)
  IF(${ED_coverage})
    EXECUTE_PROCESS(COMMAND ${ED_cmd_coverage_switch} "-0")
  ENDIF(${ED_coverage})
ENDIF(ED_cmd_coverage_switch)


# Upload build products:
#
IF(${ED_upload})
  IF(NOT "${ED_upload_files}" STREQUAL "")
  IF(NOT "${ED_upload_destination}" STREQUAL "")

    # Since the binary directory is guaranteed to be named uniquely
    # with respect to its siblings, express the FILE(GLOB results
    # relative to its parent directory so the GLOB results include
    # the name of the binary directory as the first bit of each file
    # name. Then we can copy the results from multiple binary directories
    # (for different projects) to the same upload destination without
    # any name clashes. Using ${ED_site} and only Nightly builds as
    # upload targets then guarantees name uniqueness of uploaded files.
    #
    GET_FILENAME_COMPONENT(reldir "${CTEST_BINARY_DIRECTORY}" PATH)

    FILE(GLOB filelist RELATIVE "${reldir}"
      "${CTEST_BINARY_DIRECTORY}/${ED_upload_files}")

    FOREACH(f ${filelist})
      EXECUTE_PROCESS(
        COMMAND ${CMAKE_EXECUTABLE_NAME} -E copy
          "${reldir}/${f}"
          "${ED_upload_destination}/${ED_site}/${f}"
        )
    ENDFOREACH(f)

  ENDIF(NOT "${ED_upload_destination}" STREQUAL "")
  ENDIF(NOT "${ED_upload_files}" STREQUAL "")
ENDIF(${ED_upload})


# Tell ctest not to squawk if all of the above steps were skipped
# because logic turned them all off...
#
SET(CTEST_RUN_CURRENT_SCRIPT 0)
