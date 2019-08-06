Elastos Trinity
==========================
|Android & IOS|Android(Windows)|
|:-:|:-:|
|[![Build Status](https://travis-ci.com/elastos/Elastos.Trinity.svg)](https://travis-ci.com/elastos/Elastos.Trinity)|[![Build status](https://ci.appveyor.com/api/projects/status/hjyv761on883jors?svg=true)](https://ci.appveyor.com/project/Elastos/elastos-trinity)|

## Introduction

Elastos Trinity integrates all the services that Elastos provides and combines them into a singular framework for DApp developers to use. For this reason, DApp developers only need to write their application using ionic javascript framework and have only one set of Runtime APIs to manage.

Elastos Trinity is supported on both Android and iOS, DApp developers only need to develop their application using one set of code in order to run on both platforms.

## Table of Contents

- [Elastos Trinity](#elastos-trinity)
	- [Introduction](#introduction)
	- [Table of Contents](#table-of-contents)
- [Checking out the source code](#checking-out-the-source-code)
- [How to build](#how-to-build)
	- [Build on Ubuntu / Debian / Linux Host](#build-on-ubuntu--debian--linux-host)
	- [Build on MacOS Host](#build-on-macos-host)
	- [Build on Windows Host](#build-on-windows-host)
- [How to develop dapp](#how-to-develop-dapp)
- [Repositories](#repositories)
- [Contribution](#contribution)
- [Acknowledgments](#acknowledgments)

## Checking out the source code

To clone the repository in your environment:

```shell
git clone --recurse-submodules -b dev -j8 git@github.com:elastos/Elastos.Trinity.git
```

We use --recurse-submodules here because we need to download the submodules as well. If you forgot to use the argument, you could download the submodules later by typing:

```shell
git submodule update --init --recursive
```

To update submodules with the lastest changes, type:

```shell
git submodule update --rebase --remote
```

And then use git add, commit and push to submit your changes to current project.

## How to build

### Requirements
- cordova
- ionic
- node
- npm
- python

##### For Android:
- Java JDK 1.8 or greater
- Android SDK
- Android NDK (android-ndk-r16b or higher)

 The supported way of doing this nowadays is to use Android Studio.
 
 Set the ANDROID_HOME environment variable to match the Android SDK path.

 on Mac and Linux, add the following line to your login script (e.g., ~/.bashrc, ~/.bash_profile, etc...):

 ```
 export ANDROID_HOME="YOU-PATH/sdk"
 ```

 On Windows, set the environment variable in the control panel.

##### For iOS:
- Xcode 10 or higher

### Build on Ubuntu / Debian / Linux Host

```shell
cd YOU-PATH/Elastos.Trinity
./ToolChains/bin/build all
```

NOTE：You could type `./ToolChains/bin/build --help` for more detail

**Using Android Studio:**

Open project from YOU-PATH/Elastos.Trinity/Runtime/platforms/android


### Build on MacOS Host

```shell
cd YOU-PATH/Elastos.Trinity
./ToolChains/bin/build all
```

**Using Android Studio:**

Open project from YOU-PATH/Elastos.Trinity/Runtime/platforms/android

**Using Xcode:**

Open project from YOU-PATH/Elastos.Trinity/Runtime/platforms/ios


### Build on Windows Host

```shell
cd YOU-PATH/Elastos.Trinity
python ToolChains/bin/build all
```

**Using Android Studio:**

Open project from YOU-PATH/Elastos.Trinity/Runtime/platforms/android

## [How to develop dapp](https://github.com/elastos/Elastos.Trinity.ToolChains/blob/master/README.md)

## Repositories

Elastos.Trinity is composite repository to Elastos Trinity infrastructure, which can be divided into the following submodules:

* [Elastos.Trinity.Runtime](https://github.com/elastos/Elastos.Trinity.Runtime)
* Elastos.Trinity.DApps
* Elastos.Trinity.Plugins
* [Elastos.Trinity.Toolchains](https://github.com/elastos/Elastos.Trinity.Toolchains)

where category **DApps** includes several specific DApps repositories:

* [Elastos.Trinity.DApps.Launcher](https://github.com/elastos/Elastos.Trinity.DApps.Launcher)
* [Elastos.Trinity.DApps.Wallet](https://github.com/elastos/Elastos.Trinity.DApps.Wallet)
* Elastos.Trinity.DApps.IM (Todo)

while category **Plugins** includes the following repostiories:

* [Elastos.Trinity.Plugins.AppManager](https://github.com/elastos/Elastos.Trinity.Plugins.AppManager)
* [Elastos.Trinity.Plugins.AppService](https://github.com/elastos/Elastos.Trinity.Plugins.AppService)
* [Elastos.Trinity.Plugins.BatteryStatus](https://github.com/elastos/Elastos.Trinity.Plugins.BatteryStatus)
* [Elastos.Trinity.Plugins.Carrier](https://github.com/elastos/Elastos.Trinity.Plugins.Carrier)
* [Elastos.Trinity.Plugins.Camera](https://github.com/elastos/Elastos.Trinity.Plugins.Camera)
* [Elastos.Trinity.Plugins.Device](https://github.com/elastos/Elastos.Trinity.Plugins.Device)
* [Elastos.Trinity.Plugins.DeviceMotion](https://github.com/elastos/Elastos.Trinity.Plugins.DeviceMotion)
* [Elastos.Trinity.Plugins.Dialog](https://github.com/elastos/Elastos.Trinity.Plugins.Dialog)
* [Elastos.Trinity.Plugins.File](https://github.com/elastos/Elastos.Trinity.Plugins.File)
* [Elastos.Trinity.Plugins.Flashlight](https://github.com/elastos/Elastos.Trinity.Plugins.Flashlight)
* [Elastos.Trinity.Plugins.Geolocation](https://github.com/elastos/Elastos.Trinity.Plugins.Geolocation)
* [Elastos.Trinity.Plugins.InappBrowser](https://github.com/elastos/Elastos.Trinity.Plugins.InappBrowser)
* [Elastos.Trinity.Plugins.NetWorkInformation](https://github.com/elastos/Elastos.Trinity.Plugins.NetWorkInformation)
* [Elastos.Trinity.Plugins.Media](https://github.com/elastos/Elastos.Trinity.Plugins.Media)
* [Elastos.Trinity.Plugins.MediaCapture](https://github.com/elastos/Elastos.Trinity.Plugins.MediaCapture)
* [Elastos.Trinity.Plugins.QRScanner](https://github.com/elastos/Elastos.Trinity.Plugins.QRScanner)
* [Elastos.Trinity.Plugins.ScreenOrientation](https://github.com/elastos/Elastos.Trinity.Plugins.ScreenOrientation)
* [Elastos.Trinity.Plugins.SplashScreen](https://github.com/elastos/Elastos.Trinity.Plugins.SplashScreen)
* [Elastos.Trinity.Plugins.Statusbar](https://github.com/elastos/Elastos.Trinity.Plugins.Statusbar)
* [Elastos.Trinity.Plugins.Vibration](https://github.com/elastos/Elastos.Trinity.Plugins.Vibration)
* [Elastos.Trinity.Plugins.Wallet](https://github.com/elastos/Elastos.Trinity.Plugins.Wallet)

## Contribution

We welcome contributions to the Elastos Trinity Project.

## Acknowledgments

A sincere thank you to all teams and projects that we rely on directly or indirectly.
