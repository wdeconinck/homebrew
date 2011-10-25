require 'formula'

class Paraview < Formula
  url 'http://www.paraview.org/files/v3.12/ParaView-3.12.0-RC2.tar.gz'
  homepage 'http://www.paraview.org'
  md5 '1df2c6d1353519084533f281ca6be1e0'
  version '3.12.0-RC2'
  depends_on 'cmake' => :build
  # depends_on 'open-mpi'

  def install

    mkdir 'paraview-build'

    args = std_cmake_parameters.split
    args.concat [
      "-DBUILD_SHARED_LIBS:BOOL=ON",
      
      # This flag should be ON, but breaks cmake build for now.
      # Will be fixed in version 3.12
      "-DPARAVIEW_INSTALL_DEVELOPMENT=OFF",
      
      "-DPARAVIEW_USE_MPI=ON",
      "-DPARAVIEW_ENABLE_PYTHON=ON",
  
      # Turn off GUI because it installs .app, Precompiled GUI can be downloaded from paraview.org
      "-DPARAVIEW_BUILD_QT_GUI=OFF"
    ]

    Dir.chdir 'paraview-build' do
      system "cmake", "..", *args
      system "make"
      system "make install"
      #system "cpack -G TGZ --config Applications/ParaView/CPackParaView-DevelopmentConfig.cmake"
      #system "tar -xzvf *.tar.gz -C #{prefix}"
    end
  end
end
