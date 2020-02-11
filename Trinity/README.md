Elastos Trinity
==========================
|Android & IOS|Android(Windows)|
|:-:|:-:|
|[![Build Status](https://travis-ci.com/elastos/Elastos.Trinity.svg)](https://travis-ci.com/elastos/Elastos.Trinity)|[![Build status](https://ci.appveyor.com/api/projects/status/hjyv761on883jors?svg=true)](https://ci.appveyor.com/project/Elastos/elastos-trinity)|

## Introduction

Elastos Trinity integrates all the services that Elastos provides and combines them into a singular framework for DApp developers to use. For this reason, DApp developers only need to write their application using ionic javascript framework and have only one set of Runtime APIs to manage.

Elastos Trinity is supported on both Android and iOS.

While Elastos Trinity is the project codename, this product is also known as the elastOS browser on traditional app stores.

## Table of Contents

- [Roadmap](#roadmap)
- [Download Trinity for Android](#download-trinity-for-android)
- [Checking out the source code](#checking-out-the-source-code)
- [How to build](#how-to-build)
	- [Build on Ubuntu / Debian / Linux Host](#build-on-ubuntu--debian--linux-host)
	- [Build on MacOS Host](#build-on-macos-host)
	- [Build on Windows Host](#build-on-windows-host)
- [How to develop dapp](#how-to-develop-dapp)
- [Repositories](#repositories)
- [Contribution](#contribution)
- [Acknowledgments](#acknowledgments)



## Download Trinity for Android
[stable version](https://github.com/elastos/Elastos.Trinity/releases/latest)

[latest version(tag starting with daily)](https://github.com/elastos/Elastos.Trinity/releases)


## Checking out the source code

To clone the repository in your environment:

```shell
git clone --recurse-submodules git@github.com:elastos/Elastos.Trinity.git
```

We use --recurse-submodules here because we need to download the submodules as well. If you forgot to use the argument, you could download the submodules later by typing:

```shell
git submodule update --init --recursive
```

And then use git add, commit and push to submit your changes to current project.

To update the whole Trinity (main repo + submodules) to latest master commits, run this:

```shell
# Pull all submodules on latest master
./synccode.sh
./ToolChains/bin/build clean
./ToolChains/bin/build all
```

If you know what you are doing, you can also only **build runtime**, **build plugin ...**, etc.

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
 export ANDROID_HOME="YOUR-PATH/sdk"
 ```

 On Windows, set the environment variable in the control panel.

##### For iOS:
- Xcode 10 or higher

### Build on Ubuntu / Debian / Linux Host

```shell
cd YOUR-PATH/Elastos.Trinity
./ToolChains/bin/build all
```

**Using Android Studio:**

Open project from YOUR-PATH/Elastos.Trinity/Runtime/platforms/android


### Build on MacOS Host

```shell
cd YOUR-PATH/Elastos.Trinity
./ToolChains/bin/build all
```

**Using Android Studio:**

Open project from YOUR-PATH/Elastos.Trinity/Runtime/platforms/android

**Using Xcode:**

Open project from YOUR-PATH/Elastos.Trinity/Runtime/platforms/ios


### Build on Windows Host

```shell
cd YOUR-PATH/Elastos.Trinity
python ToolChains/bin/build all
```

**Using Android Studio:**

Open project from YOUR-PATH/Elastos.Trinity/Runtime/platforms/android

### Build script options

- build clean: deletes runtime platforms.

    if you update plugins, you should call build clean, then build runtime. Otherwise, latest plugins changes are not applied inside the native app.

- build clobber: deletes all generated or downloaded files (everything).

- build runtime: builds runtime module.
- build launcher: builds launcher and runtime module.
- build all: builds all modules, include runtime, launcher and dapps.

- build plugin -p plugin_path: reinstalls the specified plugin.

NOTE：You can type `./ToolChains/bin/build --help` for more details.

**build all** takes time, so it is advised to build the relevant target only.

Dapp developer should not use any of this and instead get the latest APK from app stores or github releases and follow the [Elastos Developer Website Trinity guides](https://developer.elastos.org/elastos_trinity/).

## Repositories

Elastos.Trinity is composite repository to Elastos Trinity infrastructure, which can be divided into the following submodules:

* [Elastos.Trinity.Runtime](https://github.com/elastos/Elastos.Trinity.Runtime)
* Elastos.Trinity.DApps
* Elastos.Trinity.Plugins
* [Elastos.Trinity.ToolChains](https://github.com/elastos/Elastos.Trinity.ToolChains)

where category **DApps** includes several specific DApps repositories:

* [Elastos.Trinity.DApps.Launcher](https://github.com/elastos/Elastos.Trinity.DApps.Launcher)
* [Elastos.Trinity.DApps.Wallet](https://github.com/elastos/Elastos.Trinity.DApps.Wallet)
* Elastos.Trinity.DApps.IM (Todo)

while category **Plugins** includes the following repostiories:

* [Elastos.Trinity.Runtime.Plugins.AppManager](https://github.com/elastos/Elastos.Trinity.Runtime.Plugins.AppManager)
* [Elastos.Trinity.Plugins.Carrier](https://github.com/elastos/Elastos.Trinity.Plugins.Carrier)
* [Elastos.Trinity.Plugins.File](https://github.com/elastos/Elastos.Trinity.Plugins.File)
* [Elastos.Trinity.Plugins.Hive](https://github.com/elastos/Elastos.Trinity.Plugins.Hive)
* [Elastos.Trinity.Plugins.Media](https://github.com/elastos/Elastos.Trinity.Plugins.Media)
* [Elastos.Trinity.Plugins.QRScanner](https://github.com/elastos/Elastos.Trinity.Plugins.QRScanner)
* [Elastos.Trinity.Plugins.Wallet](https://github.com/elastos/Elastos.Trinity.Plugins.Wallet)

## Contribution

We welcome contributions to the Elastos Trinity Project.

## Roadmap

[Elastos Trinity Roadmap](ROADMAP.md)

## Acknowledgments

A sincere thank you to all teams and projects that we rely on directly or indirectly.
