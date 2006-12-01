CMAKE_MINIMUM_REQUIRED(VERSION 2.4 FATAL_ERROR)

GET_FILENAME_COMPONENT(ED_script_EasyDashboard "${CMAKE_CURRENT_LIST_FILE}" ABSOLUTE)
GET_FILENAME_COMPONENT(ED_dir_EasyDashboard "${CMAKE_CURRENT_LIST_FILE}" PATH)

SET(ED_revision_EasyDashboard "$Revision: 1.1 $")
SET(ED_date_EasyDashboard "$Date: 2006/12/01 16:55:24 $")
SET(ED_author_EasyDashboard "$Author: david.cole $")
SET(ED_rcsfile_EasyDashboard "$RCSfile: EasyDashboard.cmake,v $")

IF(NOT DEFINED ED_script_EasyDashboardVariables)
  INCLUDE("${ED_dir_EasyDashboard}/EasyDashboardVariables.cmake")
ENDIF(NOT DEFINED ED_script_EasyDashboardVariables)

IF(NOT DEFINED CTEST_SOURCE_DIRECTORY)
  IF(NOT "${ED_source}" STREQUAL "")
    IF(NOT "${ED_tag}" STREQUAL "")
      SET(CTEST_SOURCE_DIRECTORY "${ED_dir_mytests}/${ED_tag}/${ED_source}")
    ELSE(NOT "${ED_tag}" STREQUAL "")
      SET(CTEST_SOURCE_DIRECTORY "${ED_dir_mytests}/${ED_source}")
    ENDIF(NOT "${ED_tag}" STREQUAL "")
  ENDIF(NOT "${ED_source}" STREQUAL "")

  IF(NOT "${ED_data}" STREQUAL "")
    IF(NOT "${ED_tag}" STREQUAL "")
      SET(CTEST_DATA_DIRECTORY "${ED_dir_mytests}/${ED_tag}/${ED_data}")
    ELSE(NOT "${ED_tag}" STREQUAL "")
      SET(CTEST_DATA_DIRECTORY "${ED_dir_mytests}/${ED_data}")
    ENDIF(NOT "${ED_tag}" STREQUAL "")
  ENDIF(NOT "${ED_data}" STREQUAL "")
ENDIF(NOT DEFINED CTEST_SOURCE_DIRECTORY)

IF(NOT DEFINED CTEST_BINARY_DIRECTORY)
  IF(NOT "${ED_tag}" STREQUAL "")
    SET(CTEST_BINARY_DIRECTORY "${ED_dir_mytests}/${ED_sourcename} ${ED_tag}-${ED_buildname}")
  ELSE(NOT "${ED_tag}" STREQUAL "")
    SET(CTEST_BINARY_DIRECTORY "${ED_dir_mytests}/${ED_sourcename} ${ED_buildname}")
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
    #
    # TODO: set correct options for updating via svn...
    #
    IF(NOT "${ED_tag}" STREQUAL "")
      #
      # TODO: ...with a tag...
      #
      #SET(CTEST_UPDATE_OPTIONS "-dAP -r ${ED_tag}")
    ELSE(NOT "${ED_tag}" STREQUAL "")
      #
      # TODO: ...and without...
      #
      #SET(CTEST_UPDATE_OPTIONS "-dAP")
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
#
IF(${ED_clean})
  CTEST_EMPTY_BINARY_DIRECTORY("${CTEST_BINARY_DIRECTORY}")
ENDIF(${ED_clean})


ED_GET_EasyDashboardInfo(ED_info)
FILE(APPEND "${CTEST_BINARY_DIRECTORY}/ED_info PreConfigure.xml" "${ED_info}")

IF(NOT EXISTS "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt")
  FILE(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt" "${ED_cache}")
ENDIF(NOT EXISTS "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt")


CTEST_START("${ED_model}")


IF(${ED_update})
  IF(NOT "${CTEST_DATA_DIRECTORY}" STREQUAL "")
    CTEST_UPDATE(SOURCE "${CTEST_DATA_DIRECTORY}")
  ENDIF(NOT "${CTEST_DATA_DIRECTORY}" STREQUAL "")

  CTEST_UPDATE(SOURCE "${CTEST_SOURCE_DIRECTORY}")
ENDIF(${ED_update})


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


IF(${ED_submit})
  CTEST_SUBMIT()
ENDIF(${ED_submit})


IF(${ED_verbose})
  ED_DUMP_EasyDashboardInfo()
ENDIF(${ED_verbose})


SET(CTEST_RUN_CURRENT_SCRIPT 0)
