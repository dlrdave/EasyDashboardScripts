SET(ED_source "VTK")
SET(ED_tag "VTK-5-2-1")

SET(ED_update 0)
  # When snapping to a tag, the source tree must be updated to
  # that tag manually prior to running a Nightly dashboard on it.
  # Otherwise, cvs update with both a non-branch tag *and* a
  # -D Nightly start time timestamp yields a confused cvs update...

INCLUDE("${CTEST_SCRIPT_DIRECTORY}/VTK.cmake")
