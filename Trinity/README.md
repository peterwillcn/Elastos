Elastos Trinity
==========================
|Android & IOS|Android(Windows)|
|:-:|:-:|
|[![Build Status](https://travis-ci.com/elastos/Elastos.Trinity.svg)](https://travis-ci.com/elastos/Elastos.Trinity)|[![Build status](https://ci.appveyor.com/api/projects/status/hjyv761on883jors?svg=true)](https://ci.appveyor.com/project/Elastos/elastos-trinity)|

## Introduction

Elastos Trinity integrates all the services that Elastos provides and combines them into a singular framework for DApp developers to use. For this reason, DApp developers only need to write their application using ionic javascript framework and have only one set of Runtime APIs to manage.

Elastos Trinity is supported on both Android and iOS, DApp developers only need to develop their application using one set of code in order to run on both platforms.

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

## Roadmap

### S1 2019 - "Roots"

* Base concepts for trinity
* DApp isolations
* Hive, Carrier, Wallet and base plugins
* Basic launcher, SPV wallet DApp
* Runtime bases (installations, uninstallations, manifest information…)
* Basic toolchain to create, pack and sign DApp packages

### Q4 2019/Q1 2020 - "Focus on developers"

* Advanced runtime concepts (inter app communications, elastos scheme, API permissions)
* Wallet DApp phase 2 (Trinity as an SPV wallet) - payments requests support
* DID DApp (Trinity as user identity management)
* Voting DApps (Vote for DPOS, CRC…)
* RedPackets DApp
* Temporary centralized DApp store
* Ethereum and DID plugins
* DMA-light for trinity
* Efficient tool chain (easy initial setup, package, debug, publish, easy switch between dev and prod env or mainnet and testnet)
* Documentation
* Automated testing
* Frequent releases that can break existing DApps
* DApps community programme

### Q2/Q3 2020 - "Focus on end users"

* Versioning / Backward compatibility management (fewer releases, branches strategy)
* Developers able to write production ready DApps
* Releases based on stable sub-module releases
* Great user experience for end users (great UI design, dynamic launcher, home screen widgets, notifications, animations, convenient menus, onboarding information, ELA purchases made easy…)
* DApp store based on the DApp sidechain
* Maintenance of everything existing
* New features to be defined according to initial feedback from both developers and end users during previous phases
* New features integrated according to the main Elastos product roadmap (ex: new sidechains)

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

To update the whole Trinity (main repo + submodules), run this:

```shell
git pull --rebase
git submodule update --init
```

At that time, submodules will be in **detached HEAD** state. To commit changes, run this from the submodule folder before make changes:

```shell
git checkout master
git add/commit/push
```

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

* [Elastos.Trinity.Runtime.Plugins.AppManager](https://github.com/elastos/Elastos.Trinity.Runtime.Plugins.AppManager)
* [Elastos.Trinity.Runtime.Plugins.AppService](https://github.com/elastos/Elastos.Trinity.Runtime.Plugins.AppService)
* [Elastos.Trinity.Plugins.Carrier](https://github.com/elastos/Elastos.Trinity.Plugins.Carrier)
* [Elastos.Trinity.Plugins.File](https://github.com/elastos/Elastos.Trinity.Plugins.File)
* [Elastos.Trinity.Plugins.Hive](https://github.com/elastos/Elastos.Trinity.Plugins.Hive)
* [Elastos.Trinity.Plugins.Media](https://github.com/elastos/Elastos.Trinity.Plugins.Media)
* [Elastos.Trinity.Plugins.QRScanner](https://github.com/elastos/Elastos.Trinity.Plugins.QRScanner)
* [Elastos.Trinity.Plugins.Wallet](https://github.com/elastos/Elastos.Trinity.Plugins.Wallet)

## Contribution

We welcome contributions to the Elastos Trinity Project.

## Acknowledgments

A sincere thank you to all teams and projects that we rely on directly or indirectly.
