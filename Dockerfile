FROM ubuntu:14.04.5

ARG DEBIAN_FRONTEND=noninteractive

RUN echo 'debconf shared/accepted-oracle-license-v1-1 select true' | debconf-set-selections && \
    echo 'debconf shared/accepted-oracle-license-v1-1 seen true' | debconf-set-selections && \
    echo 'deb http://archive.ubuntu.com/ubuntu trusty main multiverse' >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:webupd8team/java && \
    add-apt-repository ppa:v-launchpad-jochen-sprickerhof-de/pcl

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      byacc \
      cmake \
      cmake-gui \
      doxygen \
      flex \
      freeglut3 \
      freeglut3-dev \
      imagemagick \
      libavcodec-dev \
      libavformat-dev \
      libboost-all-dev \
      libcurl3 \
      libcurl3-nss \
      libcurl4-nss-dev \
      libdc1394-22 \
      libdc1394-22-dev \
      libdc1394-utils \
      libeigen2-dev \
      libeigen3-dev \
      libespeak-dev \
      libfaac-dev \
      libfftw3-dev \
      libflann-dev \
      libforms-dev \
      libglade2-0 \
      libglade2-dev \
      libglademm-2.4-1c2a \
      libglademm-2.4-dev \
      libglew-dev \
      libglew1.5 \
      libglew1.5-dev \
      libglewmx1.5 \
      libglewmx1.5-dev \
      libgsl0-dev \
      libgsl0ldbl \
      libgtk2.0-dev \
      libgtkglext1 \
      libgtkglext1-dev \
      libgtkglextmm-x11-1.2-0 \
      libgtkglextmm-x11-1.2-dev \
      libgtkmm-2.4-dev \
      libimlib2 \
      libimlib2-dev \
      libjasper-dev \
      libjpeg-dev \
      libkml-dev \
      libkml0 \
      libmagick++-dev \
      libncurses5 \
      libncurses5-dev \
      libopencore-amrnb-dev \
      libopencore-amrwb-dev \
      libopenexr-dev \
      libpcl-all \
      libqt4-dev \
      libqt4-opengl-dev \
      libswscale-dev \
      libtbb-dev \
      libtheora-dev \
      libtiff4-dev \
      liburiparser-dev \
      liburiparser1 \
      libusb-1.0-0 \
      libusb-1.0-0-dev \
      libusb-dev \
      libv4l-dev \
      libvorbis-dev \
      libvtk5-dev \
      libwrap0 \
      libwrap0-dev \
      libx264-dev \
      libxi-dev \
      libxi6 \
      libxmu-dev \
      libxmu6 \
      libxvidcore-dev \
      oracle-java8-installer \
      oracle-java8-set-default \
      python-dev \
      python-numpy \
      python-tk \
      qt-sdk \
      sphinx-common \
      swig \
      tcpd \
      texlive-latex-extra \
      unzip \
      wget \
      yasm && \
    rm -rf /var/lib/apt/lists/*

# Install OpenCV
RUN cd /tmp && \
    wget http://downloads.sourceforge.net/project/opencvlibrary/opencv-unix/2.4.9/opencv-2.4.9.zip && \
    unzip opencv-2.4.9.zip && \
    cd opencv-2.4.9 && \
    mkdir build && cd build && \
    cmake -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D WITH_VTK=ON .. && \
    make && \
    make install && \
    echo '/usr/local/lib' > /etc/ld.so.conf.d/opencv.conf && \
    ldconfig && \
    echo 'PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig' >> /etc/bash.bashrc && \
    echo 'export PKG_CONFIG_PATH' >> /etc/bash.bashrc

# Install bullet
RUN cd /tmp && \
    wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/bullet/bullet-2.78-r2387.tgz && \
    tar -xvf bullet-2.78-r2387.tgz && \
    cd bullet-2.78 && \
    ./configure && \
    make && \
    make install

# Install linuxcan
# TODO: Fix build for linuxcan 
# RUN cd /tmp && \
#     wget http://www.kvaser.com/software/7330130980754/V5_17_0/linuxcan.tar.gz && \
#     tar -xvf linuxcan.tar.gz && \
#     cd linuxcan && \
#     make && \
#     make install

# Install fann
RUN cd /tmp && \
    wget http://downloads.sourceforge.net/project/fann/fann/2.2.0/FANN-2.2.0-Source.tar.gz && \
    tar -xvf FANN-2.2.0-Source.tar.gz && \
    cd FANN-2.2.0-Source && \
    mkdir build && cd build && \
    cmake .. && \
    make && \
    make install 

# Install imlib
RUN cd /tmp && \
    wget https://github.com/LCAD-UFES/carmen_lcad/raw/stable-2.0/ubuntu_packages/imlib_1.9.15-20_amd64.deb && \
    wget https://github.com/LCAD-UFES/carmen_lcad/raw/stable-2.0/ubuntu_packages/imlib-devel_1.9.15-20_amd64.deb && \
    dpkg -i imlib_1.9.15-20_amd64.deb && \
    dpkg -i imlib-devel_1.9.15-20_amd64.deb

# Install flycapture
# NOTE: Instaled inside container and commited because of 
# RUN cd /tmp && \
#     wget https://github.com/LCAD-UFES/carmen_lcad/raw/stable-2.0/ubuntu_packages/flycapture2-2.5.3.4-amd64-pkg.tgz && \
#     tar -xvf flycapture2-2.5.3.4-amd64-pkg.tgz && \
#     cd flycapture2-2.5.3.4-amd64 && \
#     sh install_flycapture.sh

# Install libusb to use Kinect camera
# NOTE: Not instaled beacuse is instaled libusb-1.0-0 via apt
# libusb is a C library that gives applications easy access to USB devices on many different operating systems.
# RUN cd /tmp && \
#     wget http://sourceforge.net/projects/libusb/files/libusb-1.0/libusb-1.0.19/libusb-1.0.19.tar.bz2 && \
#     tar -xvf libusb-1.0.19.tar.bz2 && \
#     cd libusb-1.0.19 && \
#     ./configure && \
#     make && \
#     make install

# Link imlib and Linux Header
RUN ln -s /usr/lib64/libgdk_imlib.so.1.9.15 /usr/lib64/libgdk_imlib.a && \
    ln -s /usr/src/linux-headers-3.8.0-30/ /usr/src/linux
