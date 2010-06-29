SET(ED_source "VTK")

# In order to work with the new git repository, but with "old style" names for
# branches like "VTK-5-6" -- dashboard clients need to do a git clone manually
# first and then do : "git checkout -b VTK-5-6 origin/release"
#
SET(ED_tag "VTK-5-6")

INCLUDE("${CTEST_SCRIPT_DIRECTORY}/VTK.cmake")
