# CMake requires CVSCOMMAND and SVNCOMMAND in the cache for a
# successful run of the test named CTestTest3. It does two complete
# checkouts of KWSys using CVSCOMMAND and SVNCOMMAND...
#
IF("${CTEST_UPDATE_COMMAND}" MATCHES "cvs")
  ED_APPEND(ED_cache "CVSCOMMAND:FILEPATH=${CTEST_UPDATE_COMMAND}")
ENDIF("${CTEST_UPDATE_COMMAND}" MATCHES "cvs")

FIND_PROGRAM(CMAKE_ED_SVNCOMMAND svn
  "C:/Program Files/Subversion/bin"
  "C:/Program Files (x86)/Subversion/bin"
  "C:/cygwin/bin"
  "/usr/bin"
  "/usr/local/bin"
  )
IF(CMAKE_ED_SVNCOMMAND)
  ED_APPEND(ED_cache "SVNCOMMAND:FILEPATH=${CMAKE_ED_SVNCOMMAND}")
ENDIF(CMAKE_ED_SVNCOMMAND)
