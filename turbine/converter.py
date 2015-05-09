#!/usr/bin/env python
import vtk
reader = vtk.vtkSTLReader()
# path to binary or ascii stl file to be converted
reader.SetFileName("3_-_Front_Shaft.stl")
reader.Update()
write = vtk.vtkSTLWriter()
#uncomment unnecessary 2Ascii or 2Binary 
write.SetFileTypeToASCII()
#write.SetFileTypeToBinary()


write.SetInput(reader.GetOutput())
# path to 
write.SetFileName("test.out")
write.Write()
