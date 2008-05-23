SET(ED_data "VTKData")
SET(ED_data_repository ":pserver:anonymous:vtk@public.kitware.com:/cvsroot/VTKData")
SET(ED_source_repository ":pserver:anonymous:vtk@public.kitware.com:/cvsroot/VTK")

SET(dir "${CTEST_SCRIPT_DIRECTORY}/../EasyDashboardScripts")
INCLUDE("${dir}/EasyDashboard.cmake")
