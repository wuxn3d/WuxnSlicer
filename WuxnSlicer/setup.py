import os
import sys
import subprocess
from cx_Freeze import setup, Executable

dir_path = os.path.abspath(os.getcwd())

setup(
    name="WuxnSlicer",
    version="2.0.0",
    options={
        "build_exe": {
            "packages": [
                "os",
                "sys",
                "ctypes",
                "scipy",
                "PyQt6",
                "zeroconf",
                "trimesh",
                "shapely",
                "numpy",
                "serial",
                "PIL",
                "networkx",
                "pySavitar",
                "pyArcus"
            ],
            "include_files": [
                dir_path + "/plugins",
                dir_path + "/cura",
                dir_path + "/resources",
                dir_path + "/UM",
                dir_path + "/CuraEngine.exe",
                dir_path + "/Charon",
            ],
            "include_msvcr": True,
            "optimize": 1,
            "silent": True
        },
        "bdist_mac": {
            "iconfile": dir_path + "/Icon.icns",
            # "bundle_name": "WuxnSlicer",
            "custom_info_plist": "Property_List.plist",
        },
        "bdist_dmg": {"volume_label": "WuxnSlicer"},
    },
    executables=[Executable("cura_app.py", icon="cura.ico",shortcut_name="WuxnSlicer",
            shortcut_dir="DesktopFolder",base="Win32GUI",)],
)
if sys.platform == "win32":
    pass
else:
    old_app=dir_path + "/build/WuxnSlicer-0.0.0.app"
    subprocess.call(f"mv {old_app} {dir_path}/build/WuxnSlicer.app", shell=True)

    source_um = dir_path + "/build/WuxnSlicer.app/Contents/MacOS/UM"
    source_cura = dir_path + "/build/WuxnSlicer.app/Contents/MacOS/cura"
    source_python_path = dir_path + "/py/Python"

    qt_framework = dir_path + "/build/WuxnSlicer.app/Contents/MacOS/lib/PyQt5/Qt/lib/QtWebEngineCore.framework"
    destination = dir_path + "/build/WuxnSlicer.app/Contents/MacOS/lib"

    subprocess.call(f"sudo rsync -a {source_um} {destination}", shell=True)
    subprocess.call(f"sudo rsync -a {source_cura} {destination}", shell=True)
    subprocess.call(f"sudo rsync -a {source_python_path} {destination}", shell=True)

    subprocess.call(f"sudo rm -rf {qt_framework}", shell=True)

    s_path = dir_path + "/build/WuxnSlicer.app/Contents/MacOS"
    d_path = dir_path + "/build/WuxnSlicer.app/Contents/Resources"

    subprocess.call(f"sudo mv {s_path}/lib {d_path} && sudo mv {s_path}/plugins {d_path} && sudo mv {s_path}/resources {d_path}", shell=True)
    subprocess.call(f"cd {s_path} && sudo ln -s ../Resources/lib lib && sudo ln -s ../Resources/plugins plugins && sudo ln -s ../Resources/resources resources", shell=True)
    #
    # subprocess.call('sudo codesign --deep --force --verbose --sign "TNP489P9LV" WuxnSlicer --continue', shell=True)
    # subprocess.call('codesign --verify --deep --strict --verbose=2 ./WuxnSlicer.app', shell=True)
