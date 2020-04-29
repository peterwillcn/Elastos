# Applications

## Launcher

| Test | Priority |
| ---- | -------- |
| Launch a built-in app | High |
| Add/remove favorites | Medium |
| Open settings | High |
| Show running apps | High |
| Close app from running app list | High |

## Wallet App

| Test | Priority |
| ---- | -------- |
| Create a new wallet | High |
| Import a wallet from mnemonic | High |
| Import a wallet from keystore | High |
| Send ELA to another address | High |
| Transfer ELA from mainchain to ID chain | High |

## DID App

| Test | Priority |
| ---- | -------- |
| Create a new DID | High |
| Import an existing (published) DID from mnemonic | High |
| Import a DID from the wallet app mnemonic | Medium |
| Edit a DID profile (modify + add + delete entry) | High |
| Publish an unpublished DID | High |
| Edit credentials visibility and publish a published DID | High |
| Sign data (from the DID Demo) | High |
| Show the QR code | Medium |
| Fingerprint: activate + save profile + deactivate | Medium |

## DPos Voting App

| Test | Priority |
| ---- | -------- |
| Vote for DPoS supernodes | High |

## CRC Voting App

| Test | Priority |
| ---- | -------- |
| Vote for CR Council | High |

## QRScanner App

| Test | Priority |
| ---- | -------- |
| Scan a DID qrcode should open the friends app to add a friend | High |
| Scan a elastos scheme | High |
| Scan ELA address (intent from wallet app) | High |

## Settings App

| Test | Priority |
| ---- | -------- |
| Show all apps info | High |
| Change Language | High |

## Friends App

| Test | Priority |
| ---- | -------- |
| Add a friend with published DID | Medium |
| Browse a friend's app from apps his profile | Medium |

## DApps Store App

| Test | Priority |
| ---- | -------- |
| Launch an app from the DApps store | Medium |

# Others

## Inter-app communication

| Test | Priority |
| ---- | -------- |
| Launch a built-in app from an external url | High |
| Launch a third party app from an external url | High |
| Sign in from the DID Demo | High |
| Sign in from nucleusconsole.com using QR code and scanner | High |

## Security

| Test | Priority |
| ---- | -------- |
| Try to install an app from CLI without developer mode enabled | Medium |
| Try to install an app with no verifiable DID signature | Medium |
| Sign in from a website with an altered JWT token | Medium |

## Robustness

| Test | Priority |
| ---- | -------- |
| Launch quickly saveral favorite apps from the home screen | Medium |
| Start an app and quickly exit it several times | Medium |

## Compatibility

| Test | Priority |
| ---- | -------- |
| Ensure elastOS can upgrade from the previous public release (with user data) to the new release | High |

# Tools

| Test | Priority |
| ---- | -------- |
| Create a new angular/tabs app from the cli (+build + run android/ios) | High |
| Create an app DID from the CLI (without publishing) | Medium |