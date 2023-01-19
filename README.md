<img src="https://user-images.githubusercontent.com/65782241/205936558-3df49ec1-6d08-45b9-b742-45d564ce879e.png" width=40% height=40%>


# Summary 

WuxnSlicer is the recommended software for converting 3D objects into specific instructions for Wuxn 3D printers. The WuxnSlicer engine is based on version 5.2.1 of the CuraEngine open-source slicer project. WuxnSlicer + Wuxn Printers + Wuxn Filament have been engineered to optimize print performance, quality, strength, and speed.

<p align="center">
  <img src="https://user-images.githubusercontent.com/65782241/205957565-7bef4e33-c5ad-495b-ad97-04543e65d5ec.png" width=40% height=40%>
</p>

WuxnSlicer Main Features:
+ Basic slicing features and G-Code viewer
+ Pre-built Wuxn machine files
+ Pre-built Wuxn & Generic material profiles 
+ Enhanced GoTo, Strong, or Fast print profiles
+ Improved material and print profile selection process
+ Custom Wuxn branded UI enhancements
+ Both Macintosh and Windows supported

## Installers

This repository contains the source code needed to compile and build WuxnSlicer software. 
To use WuxnSlicer as intended please download our installers from our website at https://wuxn3d.com/pages/software-firmware.

# Change Log

## **WuxnSlicer 1.2.6**

WuxnSlicer 1.2.6 is the first installment of WuxnSlicer. Enjoy seemless printing with the preconfigured machine, material, and print profiles for the Wuxn 3D printers. WuxnSlicer has two themes, light and dark for both Windows and Machintosh. Along with the color enhancements each machine's build surface graphics have been embedded into the build volume for a more accurate physical representation.

<p align="center">
  <img src="https://user-images.githubusercontent.com/65782241/205959896-17c74780-50fc-4f06-82dc-87b22a3f88f1.png" width=60% height=60%>
</p>

Simply upload your 3D model into WuxnSlicer and slice the object with the preconfigured settings.

## **WuxnSlicer 1.2.7**

WuxnSlicer 1.2.7 is the candidate developed to improve user experience and address numerous issues. The following is a list of the updates: 
+ Defualt printer at install has been updated to reflect our newest 3D printer, the Wuxn WXR. 
+ Removed erronous material selections. 
+ Cleaned up duplicate and out-dated entries in the Print Profile settings.
+ Updated the default Print Profile Setttings from "Fine" to "GoTo".
+ All icons have been updated to reflect Wuxn's new logo.
<img src="https://user-images.githubusercontent.com/65782241/205971380-878edf4b-c695-4042-bec6-5999b1a7eb6c.png">

# Compiling

## One time set up for MacOS

## Xcode & Command Line Tools

1. Go to the Mac App Store, search for "Xcode" and press "Get".
2. After installing, make sure to open Xcode at least once and accept the license agreement.
3. Open Terminal and run the following command to install the Xcode command line tools:

`$ xcode-select --install`

4. A window will prompt you to download and install, click "Install".

## CMake & Command Line Tools

1. Download the CMake macOS binary from the website. It can be found here.
2. Once the download is finished, open the .dmg archive and drag the application to your applications folder (/Applications).
3. Open the terminal and run the following command to install the CMake command line tools:

`$ sudo "/Applications/CMake.app/Contents/bin/cmake-gui" --install`

## Homebrew

Homebrew is used to install software and libraries via the command line, similar to apt-get for Linux, and npm for Node.js/Javascript. To install Homebrew, run the following command in Terminal:

`$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

**Python 3.8.10 & Virtual Environments**

pyenv is used to install, remove, and switch between different versions of Python. This is very useful for the macOS development set-up because by default macOS comes with and uses Python 2.7 which is now legacy and a 3.X (3.9.4 at the time of writing) which is the system python. However, we will be installing and using Python 3.8.10, since it is the exact python version used in the official Cura builds. We will also install two more packages to facilitate the sandboxing of the dependencies.

1. To install pyenv, run the following command in Terminal:

`$ brew install pyenv pyenv-virtualenv pyenv-virtualenvwrapper`

2. Before using it, though, we must enable it by adding a few lines to our bash profile. To edit ~/.bash_profile, run the following command in Terminal:

`$ nano ~/.bash_profile`

3. Add the following lines to the file (replace [USERNAME] with your user account name, and [WORKSPACE] with where you'd like to store your virtual environments):

```
export PYENV_ROOT="/Users/[USERNAME]/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
export PATH="/Applications/CMake.app/Contents/bin":"${PATH}"
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"`
source "/usr/bin/virtualenvwrapper.sh"
export WORKON_HOME="/Users/[USERNAME]/[WORKSPACE]"
eval "$(pyenv init -)"
pyenv virtualenvwrapper
```

4. Press Ctrl + O to write the changes to the file, then Return to verify and finally Ctrl + X to close the editor.

5. To ensure it has installed correctly, open a new Terminal window and run the following command:

`$ pyenv`

You should see an output with the pyenv version, and usage commands.

6. Although macOS includes Python, it uses version 2.7 which is getting quite old, plus it is highly likely that after installing and updating Homebrew a newer system python has been installed (v3.9.4 at the time of writing). However, since Cura uses Python 3.8.10 in its official builds, we will install that version and force macOS to use it using pyenv. As a last note, we will also need to enable python to be installed as a framework, so that libpython3.8.dylib is also installed. If we don't do that, some of the dependencies we will install later on will use the system libpython and that might introduce weird behavior. So, to install Python 3.8.10, run the following command in the Terminal:

`$ PYTHON_CONFIGURE_OPTS="--enable-framework" pyenv install 3.8.10`

If you now run...

`$ pyenv global`

...you will see that the system version is still the default global version.

7. To set 3.8.10 as our default global, run the following command:

`$ pyenv global 3.8.10`

If you now run...

`$ pyenv global`

...you will see that the global version is now set to 3.8.10.

8. We will now create a virtual workspace for working on Cura. Give it a descriptive name:

`$ mkvirtualenv Python_3.8.10-PyQt_5.15.2 --copies`

Note: We will be installing PyQt 5.15.2 in the next section.
Info: To deactivate your current workspace, simply run:

`$ deactivate`

## Additional Libraries

Make sure you're in your pyenv workspace by running (replace [VIRTUAL_ENV] with the name supplied in step 8 above:

`$ workon [VIRTUAL_ENV]`

Navigate to your virtual environment directory:

`$ cd [VIRTUAL_ENV]`

You can then install the dependencies using pip:

`$ ./bin/python3.8 -m pip install numpy scipy colorlog netifaces zeroconf pyserial PyQt5==5.15.2 requests shapely trimesh keyring cryptography cx-Freeze==6.5.3 `

Note: We specify PyQt5's version 5.15.2 as the current version.


## SIP

1. Download SIP 4.19.24 from [here](https://www.riverbankcomputing.com/static/Downloads/sip/4.19.24/sip-4.19.24.tar.gz).
2. Extract the archive.
3. In the Terminal, navigate to the extracted folder:

`$ cd [SIP PATH]`

4. Next, we will install SIP by running the following commands:

```
$ python configure.py
$ make
$ make install
```

## Arcus

1. Clone the libArcus repository to a directory of your choosing (replace [LIBARCUS PATH]):

`$ git clone https://github.com/Ultimaker/libArcus.git [LIBARCUS PATH]`

2. Go to the repository directory, and create a build directory and switch to it:

```
$ cd [LIBARCUS PATH]
$ mkdir build && cd build
```

3. Configure and build libArcus using the following commands:

```
$ cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$VIRTUAL_ENV -DCMAKE_PREFIX_PATH=$VIRTUAL_ENV -DSIP_INCLUDE_DIRS=$VIRTUAL_ENV/include/python3.8 -DBUILD_STATIC=ON -DBUILD_PYTHON=ON -DBUILD_EXAMPLES=OFF -DPython3_EXECUTABLE=$VIRTUAL_ENV/bin/python3.8 -DPYTHON_LIBRARY=/Users/$USER/.pyenv/versions/3.8.10/Library/Frameworks/Python.framework/Versions/3.8/lib/libpython3.8.dylib ..
$ make -j4
$ make install
```

## Savitar

1. clone the libSavitar repository to a directory of your choosing (replace [LIBSAVITAR PATH]):

`$ git clone https://github.com/Ultimaker/libSavitar.git [LIBSAVITAR PATH]`

2. Go to the repository directory, and create a build directory and switch to it:

```
$ cd [LIBSAVITAR PATH]
$ mkdir build && cd build
$ cd build
```

3. Configure and build libSavitar using the following commands:

```
$ cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$VIRTUAL_ENV -DCMAKE_PREFIX_PATH=$VIRTUAL_ENV -DSIP_INCLUDE_DIRS=$VIRTUAL_ENV/include/python3.8 -DBUILD_STATIC=ON -DBUILD_PYTHON=ON -DPython3_EXECUTABLE=$VIRTUAL_ENV/bin/python3.8 -DPYTHON_LIBRARY=/Users/$USER/.pyenv/versions/3.8.10/Library/Frameworks/Python.framework/Versions/3.8/lib/libpython3.8.dylib ..
$ make -j4
$ make install
```

## Charon

1. clone the libCharon repository to a directory of your choosing (replace [LIBCHARON PATH]):

`$ git clone https://github.com/Ultimaker/libCharon.git [LIBCHARON PATH]`

2. Go to the repository directory, and create a build directory and switch to it:

```
$ cd [LIBCHARON PATH]
$ mkdir build && cd build
```

3. Configure and build libCharon using the following commands:

```
$ cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$VIRTUAL_ENV -DCMAKE_PREFIX_PATH=$VIRTUAL_ENV -DPython3_EXECUTABLE=$VIRTUAL_ENV/bin/python3.8 ..
$ make -j4
$ make install
```

## pynest2d

In order to build pynest2d, we first need to install nlopt, clipper, the Boost headers and the linest2d library.

1. nlopt can easily be installed via homebrew using the below command:

`$ brew install nlopt`

2. Clipper cannot be installed via homebrew on macOS, so we have to download it and build it ourselves. The library can be downloaded from: https://sourceforge.net/projects/polyclipping/files/clipper_ver6.4.2.zip

3. Extract the archive to a [CLIPPER PATH] and navigate to:

`$ cd [CLIPPER PATH]/cpp`

4. Create a build directory and switch to it:

`$ mkdir build && cd build`

5. Install this library to your environment.

```
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$VIRTUAL_ENV -DCMAKE_PREFIX_PATH=$VIRTUAL_ENV -DCMAKE_CXX_FLAGS=-fPIC -DBUILD_SHARED_LIBS=OFF ..
make
make install
```

6. Set the $CLIPPER_PATH environment variable:

`$ export CLIPPER_PATH=$VIRTUAL_ENV`

7. Download the Boost headers from [here](http://sourceforge.net/projects/boost/files/boost/1.67.0/boost_1_67_0.tar.bz2)

8. Extract the archive to a [BOOSTHEADERS PATH] and navigate to it:

`cd [BOOSTHEADERS PATH]`

9. Copy the headers to your virtual environment:

`cp -r boost/ $VIRTUAL_ENV/include/boost`

10. Clone the **libnest2d** repository to a directory of your choosing (replace [LIBNEST2D PATH]):

`$ git clone https://github.com/Ultimaker/libnest2d.git [LIBNEST2D PATH]`

11. Go to the repository's directory, create a build directory and switch to it.

```
cd [LIBNEST2D PATH]
mkdir build && cd build
```

12. Install this library to your environment.

```
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$VIRTUAL_ENV -DCMAKE_PREFIX_PATH=$VIRTUAL_ENV ..
make install
```

13. Clone the **pynest2d** repository to a directory of your choosing (replace [PYNEST2D PATH]):

`$ git clone https://github.com/Ultimaker/pynest2d.git [PYNEST2D PATH]`

14. Go to the repository's directory, create a build directory and switch to it.

```
$ cd [PYNEST2D PATH]
$ mkdir build && cd build
```

15. Configure and build pynest2d using the following commands:

```
$ cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$VIRTUAL_ENV -DCMAKE_PREFIX_PATH=$VIRTUAL_ENV -DSIP_INCLUDE_DIRS=$VIRTUAL_ENV/include/python3.8 -DPython3_EXECUTABLE=$VIRTUAL_ENV/bin/python3.8 -DPYTHON_LIBRARY=/Users/$USER/.pyenv/versions/3.8.10/Library/Frameworks/Python.framework/Versions/3.8/lib/libpython3.8.dylib ..
$ make -j4
$ make install
```

## CuraEngine

1. Clone the CuraEngine repository to a directory of your choosing (replace [CURAENGINE PATH]):

`$ git clone https://github.com/Ultimaker/CuraEngine.git [CURAENGINE PATH]`

2. Go to the repository directory, and create a build directory and switch to it:

```
$ cd [CURAENGINE PATH]
$ mkdir build && cd build
```

3. Configure and build CuraEngine using the following commands:

```
$ cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$VIRTUAL_ENV -DCMAKE_PREFIX_PATH=$VIRTUAL_ENV ..
$ make -j4
$ make install
```

## Running WuxnSlicer on MacOS

1. Clone the Wuxn, Uranium and fdm_materials repositories to directories of your choosing (replace [WUXN PATH]], [URANIUM PATH], and [FDM_MATERIALS PATH]):

```
$ git clone https://github.com/wuxn3d/WuxnSlicer.git [WUXN PATH]
$ git clone https://github.com/Ultimaker/Uranium.git [URANIUM PATH]
$ git clone https://github.com/Ultimaker/fdm_materials.git [FDM_MATERIALS PATH]
```

2. Go to the repository directory:

`$ cd [Wuxn PATH]`

3. Link CuraEngine to Wuxn by running the following command:

`$ ln -s $VIRTUAL_ENV/bin/CuraEngine .`

4. Link the fdm_materials to Wuxn by running the following command:

`$ ln -s [FDM_MATERIALS PATH] ./resources/materials`

5. Add Uranium to the Python path by running the following command:

`$ export PYTHONPATH=[URANIUM PATH]:${PYTHONPATH}`

6. Copy UM to WuxnSlicer:

`copy to /Uranium/UM to /WuxnSlicer`

7. Copy CuraEngine to WuxnSlicer:

`copy /usr/local/bin/curaengine to /WuxnSlicer`

8. Run Wuxn with the following command:

`$ python wuxnslicer.py`

## Building the app for MacOS

`sudo python3 setup.py bdist_mac`


**Signing the app for MacOS**

```
sudo python3 setup.py bdist_mac
python3 remove.py
sudo  codesign -s {key} -v --deep  --timestamp --force --entitlements entitlements.plist -o runtime "./WuxnSlicer.app"
python3 sign.py
sudo  codesign -s {key} -v --timestamp --force --entitlements entitlements.plist -o runtime "./WuxnSlicer.app/Contents/MacOS/WuxnSlicer"
```

**Verify the app for MacOS**

```
codesign --verify --deep --strict --verbose=2 ./WuxnSlicer.app
sudo ditto -c -k --keepParent "./WuxnSlicer.app" ./WuxnSlicer-{version}.zip
```

**Notarize the app for MacOS**

```
sudo xcrun altool --notarize-app -t osx -f ./WuxnSlicer-{version}.zip  --primary-bundle-id com.wuxn3d.wuxnslicer -u {email} --password {password}
sudo xcrun altool --notarization-info {RequestUUID} -u {email}
```

**Staple the app for MacOS**

```
sudo xcrun stapler staple "WuxnSlicer.app"
spctl --assess --type execute -vvv WuxnSlicer.app
```

**Move wuxn app to target directory:**

`sudo mv ~/{path}/Wuxn/build/WuxnSlicer.app ~/{path}/Wuxn/target`

**Build dmg for MacOS**

```
cd /wuxn/target
sudo fbs installer
```

**Signing the dmg for MacOS**

```
sudo  codesign -s {key} -v --timestamp --force -o runtime "./WuxnSlicer-{version}.dmg"
sudo ditto -c -k --keepParent  "./WuxnSlicer-{version}.dmg" ./WuxnSlicer-{version}.zip
```

**Notarize the dmg for MacOS**

```
sudo xcrun altool --notarize-app -t osx -f ./WuxnSlicer-{version}.zip  --primary-bundle-id com.wuxn3d.wuxnslicer -u {email} --password {password}
sudo xcrun altool --notarization-info {RequestUUID} -u {email}
```

**Staple the dmg for MacOS**

`sudo xcrun stapler staple "WuxnSlicer-{version}.dmg"`

-----------------------------------------------------------------------

## One time set up for Windows

### Note

These instructions are taking for granted that the user is using a Windows 10 machine with a Windows version >= 1809 (i.e., OS Build 17763). In order to check your version of Windows you can either click on 'Start' and write `winver` and press `Enter` or using powershell you can enter:

```
PS > [System.Environment]::OSVersion.Version

Major  Minor  Build  Revision
-----  -----  -----  --------
10     0      17763  0
```


This guide was tested and performed on a 20H2 Windows version (i.e., OS Build 19042). Please note that Windows 10 versions earlier than 1809 or Windows Operating Systems such as Windows 7, 8 or 8.1 are **not** taken into account in this guide.

## Microsoft Visual Studio
For compiling the libraries on Windows, Microsoft Visual Studio C++ is required. Microsoft Visual Studio 2015 and 2019 are supported.

### Microsoft Visual Studio 2019 (recommended install)

1. Download Microsoft Visual Studio 2019 from [here (Web Installer)](https://visualstudio.microsoft.com/). The free version is the Community edition.
2. Run the web installer. It will take some time to download everything needed.
3. When the installer loads, check `Desktop development with C++` under `Windows`. Also select `MSVC v140 - VS 2015 C++ build tools (v14.00)` under `Installation details`. The complete installation will be large (>6 GB) and will take a while to complete.
4. When building files (using cmake or nmake) in the steps below **be sure to use the 'x64 Native Tools Command Prompt for VS 2019**'. This ensures that the Visual Studio 2019 build tools are used.

### Microsoft Visual Studio 2015 (used on earlier builds, still works)

1. Download Microsoft Visual Studio from [here (Web Installer)](https://go.microsoft.com/fwlink/?LinkId=532606&clcid=0x409) or [here (ISO Image)](https://go.microsoft.com/fwlink/?LinkId=615448&clcid=0x409).
2. Run the installer. To save on space, Custom can be selected with only `Visual C++` selected in Programming Languages. The complete installation will be large (>12 GB) and will take a while to complete.

## CMake

1. Download CMake for Windows "win64-x64" from [here](https://cmake.org/download/).
2. Run the installer.
3. When selecting the PATH option, select either `Add CMake to system PATH for all users` or `Add CMake to the system PATH for the current user`. The allows the `cmake` command to be run from the command line.
4. Verify the installation of CMake by opening up a command window and typing `cmake --version`.

## MinGW-w64

MinGW-w64 is needed if you are building the CuraEngine. If only the libraries are being compiled, this can be skipped.

1. Download the mingw-w64 installer (not the zip) from [here](https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/installer/mingw-w64-install.exe/download).
2. Run the installer. The architecture should be changed to `x86_64` and the threading architecture should be `posix` (pthread).
3. Add MinGW to the PATH environment containg the `bin` directory (e.g., `C:\Program Files\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0\mingw64\bin`).
4. Check if mingw32-make can be found by opening a terminal and typing 'mingw32-make'. It should say 'No targets specified and no makefile found. Stop.'

## Git (Optional)

Git is recommended for cloning the other repositiories using the command line. Git is not required since all of the files can be downloaded repositories.

1. Download Git for Windows from [here](https://git-scm.com/downloads).
2. Run the installer. Select either Git from command line and also from 3rd-party software (default) or Use Git and optional Unix tools from the Command Prompt are selected in the Adjusting your PATH environment section.
3. Verify the installation of git by opening up a command window and typing git --version.

## Python 3.8.10 (32 bit)

1. Download Python 3.8.X from [here](https://www.python.org/downloads/release/python-3810/) (3.8.10).
2. Before using `Install Now` or `Customize installation`, check `Add Python 3.8 to PATH` so it can be referenced in the command line.
3. Verify the install of Python by opening up a command window and typing `python --version`. Also verify that `pip3` (the tool for installing packages) is installed by typing `python -m pip --version`. If either of them aren't working, make sure the Windows `PATH` variable contains both the root directory of Python (like `%localappdata%/Programs/Python/Python38/`) and the `Scripts` folder (like `%localappdata%/Programs/Python/Python38/Scripts`).
4. Download the Numpy library from [here](https://www.lfd.uci.edu/~gohlke/pythonlibs/#numpy) using the `MKL` version for your Python version (3.8) and using the 64-bit version of the installation for 64-bit installations. It can be installed using `pip3 install [WHL FILE]` in the command line.
5. Download the Shapely library from [here](https://www.lfd.uci.edu/~gohlke/pythonlibs/#shapely) using the `cp38‑cp38m‑win32.whl` version for 32-bit installs and the `cp38‑cp38m‑win_amd64.whl` version for 64-bit installs. It can be installed using `pip3 install [WHL FILE]` in the command line.
6. Install the other required libraries using:

`python -m pip install scipy cryptography colorlog netifaces zeroconf trimesh sentry_sdk pyserial PyQt5==5.15.2 keyring requests pywin32 cx-Freeze==6.6 `

**Note**: PyQt5 Version 5.15.2 is specificly required.

## Compiled Libraries

Compiling the libraries requires using the '**x64 Native Tools Command Prompt for VS 2019**' that is installed with Microsoft Visual Studio. This allows the nmake command to be used. Since compling some of the libraries requires referencing other libraries, the steps will us a C:/dev directory. Any directory can be used as long as the changes are made when running the commands.

### Protobuf

1. Download Protobuf 3.15.7 from [here](https://github.com/protocolbuffers/protobuf/archive/refs/tags/v3.15.7.tar.gz).
2. Extract it to `C:/dev` so that you then have a `C:/dev/protobuf-3.15.7` directory.
3. Navigate to the `protobuf-3.15.7` directory:

`cd C:/dev/protobuf-3.15.7`

4. Create the build and install directories.

```
mkdir install_dir
mkdir cmake_build && cd cmake_build
```

5. Build and install Protobuf:

```
cmake -DCMAKE_INSTALL_PREFIX=../install_dir -DCMAKE_INSTALL_LIBDIR=lib -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Release -G "NMake Makefiles" ../cmake
nmake
nmake install
```

### SIP

1. Download SIP 4.19.24 from [here](https://www.riverbankcomputing.com/static/Downloads/sip/4.19.24/sip-4.19.24.tar.gz).
2. Extract it to `C:/dev` so it creates a `C:/dev/sip-4.19.24` directory. The last part of the version should be removed from the name.
3. Navigate to the `sip-4.19.24` directory:

`cd C:/dev/sip-4.19.24`

4. Build and install SIP (again making sure to use the command prompt provided by Visual Studio):
```
python configure.py
nmake
nmake install
```

### Arcus

1. Clone the `libArcus` repository:

`git clone -b "build_from_source_windows" https://github.com/Ultimaker/libArcus.git C:\dev\libArcus`

2. Navigate to the `libArcus` directory:

`cd C:\dev\libArcus`

3. Create the build directory:
```
mkdir install_dir
mkdir build && cd build
```
4. Set the environment variables for Protobuf:
```
set PROTOBUF_SRC=C:\dev\protobuf-3.15.7
set PROTOBUF_INSTALL=%PROTOBUF_SRC%\install_dir
```
5. Build and install `libArcus` (again making sure to use the command prompt provided by visual studio):
```
cmake -DCMAKE_INSTALL_PREFIX=../install_dir -DPROTOBUF_SRC_ROOT_FOLDER=%PROTOBUF_SRC% -DPROTOBUF_LIBRARY=%PROTOBUF_INSTALL%/lib/libprotobuf.lib  -DPROTOBUF_INCLUDE_DIR=%PROTOBUF_INSTALL%/include -DPROTOBUF_PROTOC_EXECUTABLE=%PROTOBUF_INSTALL%/bin/protoc.exe -DBUILD_EXAMPLES=OFF -DBUILD_STATIC=ON -DMSVC_STATIC_RUNTIME=ON -DCMAKE_BUILD_TYPE=Release -G "NMake Makefiles" ..
nmake
nmake install
```

### Savitar

1. Clone the `libSavitar` repository:

`git clone https://github.com/Ultimaker/libSavitar.git C:\dev\libSavitar`

2. Navigate to the `libSavitar` directory:

`cd C:\dev\libSavitar`

3. Create the build and install directories:
```
mkdir install_dir
mkdir build && cd build
```
4. Build and install `libSavitar` (again making sure to use the command prompt provided by visual studio):
```
cmake -DCMAKE_INSTALL_PREFIX=../install_dir -DBUILD_STATIC=ON -DCMAKE_BUILD_TYPE=Release -G "NMake Makefiles" ..
nmake
nmake install
```

### Charon

1. Clone the `libCharon` repository:

`git clone https://github.com/Ultimaker/libCharon.git C:\dev\libCharon`

2. Navigate to the `libCharon` directory:

`cd C:\dev\libCharon`

3. Create the build and install directories:
```
mkdir install_dir
mkdir build && cd build
```
4. Build and install `libCharon` (again making sure to use the command prompt provided by visual studio):
```
cmake -DCMAKE_INSTALL_PREFIX=../install_dir -DCMAKE_BUILD_TYPE=Release -G "NMake Makefiles" ..
nmake
nmake install
```

### Pynest2D

1. Clone the Ultimaker `libnest2d` repository:

`git clone https://github.com/Ultimaker/libnest2d.git C:\dev\libnest2d`

2. Navigate to the `libnest2d` directory:

`cd C:\dev\libnest2d`

3. Create the build and install directories:

```
mkdir install_dir
mkdir build && cd build
```

4. (Optional) If you already have boost in your system make sure that it doesn't appear when building libnest2D:

`set BOOST_ROOT=`

5. Build and install libnest2d, instructing it to download and build its dependencies too (-DRP_ENABLE_DOWNLOADING=ON):
```
cmake .. -DLIBNEST2D_HEADER_ONLY=OFF -DRP_ENABLE_DOWNLOADING=ON -DCMAKE_INSTALL_PREFIX=..\install_dir
cmake --build . --target install
```
**Note**: If you don't want libnest2d to automatically download and install the necessary dependencies (boost, NLopt, Clipper), then remove the flag `-DRP_ENABLE_DOWNLOADING=ON` and make sure you have these dependencies installed in your system

6. Clone the `pynest2d` repository:

`git clone https://github.com/Ultimaker/pynest2d.git C:\dev\pynest2d`

7. Navigate to the `pynest2d` directory:

`cd C:\dev\pynest2d`

8. Create the build and install directories:
```
mkdir install_dir
mkdir build && cd build
```
9. Set the required environment variables:
```
set CLIPPER_PATH=C:\dev\libnest2d\build\dependencies
set NLopt_PATH=C:\dev\libnest2d\build\dependencies
set BOOST_ROOT=C:\dev\libnest2d\build\dependencies
```
**Note**: If you did not download these dependencies using libnest2d, then set the correct paths in your system

10. Build and install `pynest2d` (again making sure to use the command prompt provided by visual studio):
```
cmake -DCMAKE_INSTALL_PREFIX=../install_dir -DLIBNEST2D_INCLUDE_DIRS=C:\dev\libnest2d\install_dir\include -DCMAKE_BUILD_TYPE=Release -G "NMake Makefiles" ..
nmake
nmake install
```

### Uranium

Uranium, or `UM`, is a required library, but does not need to be compiled.

1. Clone the `Uranium` repository:

`git clone https://github.com/Ultimaker/Uranium.git C:\dev\Uranium`

2. Add the `Uranium` directory to your `PYTHONPATH` environment variable. It can be done with the following command, even if `PYTHONPATH` is not set up:

`set PYTHONPATH=%PYTHONPATH%;C:\dev\Uranium`

If you decide to add `UM` to the main Python install, the contents of the `plugins` and `resources` directories will need to be copied to the `C:\dev\Wuxn\plugins` and `C:\dev\Wuxn\resources` directories respectively when the `Wuxn` repository is cloned.

### CuraEngine

**Note**: Certain libraries will be built again. This is intentional, since we need mingw for the engine (and we need the nmake for the sip dependencies!).

1. Download Protobuf 3.15.7 from [here](https://github.com/protocolbuffers/protobuf/archive/refs/tags/v3.15.7.tar.gz).
2. Extract it to `C:\dev` with a `-mingw` suffix so it creates a `C:/dev/protobuf-3.15.7-mingw` directory.
3. Navigate to the `protobuf-3.15.7-mingw` directory:

`cd C:\dev\protobuf-3.15.7-mingw`

4. Create the build and install directories.
```
mkdir install_dir
mkdir cmake_build && cd cmake_build
```
5. Build and install Protobuf:
```
cmake -DCMAKE_INSTALL_PREFIX=../install_dir -DCMAKE_PREFIX_PATH=../install_dir -DCMAKE_INSTALL_LIBDIR=lib -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_CXX_FLAGS="-std=c++11" -DCMAKE_BUILD_TYPE=Release -G "MinGW Makefiles" ../cmake
mingw32-make
mingw32-make install
```
6. Clone the `libArcus` repository with a `-mingw` suffix:

`$ git clone https://github.com/Ultimaker/libArcus.git C:\dev\libArcus-mingw`

7.  Navigate to the `libArcus-mingw` directory:

`cd C:\dev\libArcus-mingw`

8. Create the build directory:
```
mkdir install_dir
mkdir build && cd build
```
9. Set the environment variables for Protobuf:
```
set PROTOBUF_MINGW_SRC=C:/dev/protobuf-3.15.7-mingw
set PROTOBUF_MINGW_INSTALL=%PROTOBUF_MINGW_SRC%/install_dir
```
10. Build and install `libArcus`:
```
cmake -DCMAKE_INSTALL_PREFIX=../install_dir -DPROTOBUF_SRC_ROOT_FOLDER=%PROTOBUF_MINGW_SRC% -DPROTOBUF_LIBRARY=%PROTOBUF_MINGW_INSTALL%/lib/libprotobuf.a -DPROTOBUF_INCLUDE_DIR=%PROTOBUF_MINGW_INSTALL%/include -DPROTOBUF_PROTOC_EXECUTABLE=%PROTOBUF_MINGW_INSTALL%/bin/protoc -DBUILD_EXAMPLES=OFF -DBUILD_STATIC=ON -DBUILD_PYTHON=OFF -DCMAKE_BUILD_TYPE=Release -G "MinGW Makefiles" ..
mingw32-make
mingw32-make install
```
11. Clone the `CuraEngine` repository:

`git clone https://github.com/Ultimaker/CuraEngine.git C:\dev\CuraEngine`

12. Navigate to the `CuraEngine` directory:

`cd C:\dev\CuraEngine`

13. Create the build and install directories.
```
mkdir install_dir
mkdir cmake_build && cd cmake_build
```
14. Set the environment variables for Arcus:

`set ARCUS_DIR=C:/dev/libArcus-mingw/install_dir/lib/cmake/Arcus`

15. Build and install `CuraEngine`:
```
cmake -DCMAKE_INSTALL_PREFIX=../install_dir -DCMAKE_BUILD_TYPE=Release -DArcus_DIR=%ARCUS_DIR% -DPROTOBUF_SRC_ROOT_FOLDER=%PROTOBUF_MINGW_SRC% -DPROTOBUF_LIBRARY=%PROTOBUF_MINGW_INSTALL%/lib/libprotobuf.a -DProtobuf_INCLUDE_DIR=%PROTOBUF_MINGW_INSTALL%/include -DPROTOBUF_PROTOC_EXECUTABLE=%PROTOBUF_MINGW_INSTALL%/bin/protoc.exe -DPROTOC=%PROTOBUF_MINGW_INSTALL%/bin/protoc.exe -G "MinGW Makefiles" ..
mingw32-make
mingw32-make install
```

### Running WuxnSlicer on Windows

1. Clone the WuxnSlicer repository

git clone https://github.com/wuxn3d/WuxnSlicer.git C:\dev\Wuxn

2. Clone the fdm_materials in the resources/materials directory of Wuxn:

`git clone https://github.com/Ultimaker/fdm_materials.git C:\dev\Wuxn\resources\materials`

3. Navigate to the Wuxn directory:

`cd C:\dev\Wuxn`

4. Add the `CuraEngine` executable:

`copy "C:\dev\CuraEngine\install_dir\bin\CuraEngine.exe" CuraEngine.exe`

5. Copy UM to WuxnSlicer:

`copy "C:\dev\Uranium\UM" WuxnSlicer`

5. Run Wuxn:

`python wuxnslicer.py`

## Building the msi for Windows

`python setup.py bdist_msi`

**Signing the msi for Windows**

`signtool.exe sign /f .\{filename}.pfx /p "{password}" /d "Wuxn3d" /tr http://timestamp.digicert.com /v WuxnSlicer-{version}-win32.msi`

# License 

<footer>
Published by Wuxn LLC. 
*
www.wuxn3d.com
*
info@wuxn3d.com.
