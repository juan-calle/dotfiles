# Dotfiles
Juan Calle ([br3ndonland](https://github.com/juan-calle))

## Table of Contents <!-- omit in toc -->
- [Before Re-Installing macOSX](#before-beginning)
  - [Downloading macOSX](#osx-download)
  - [Creating Bootable Drive](#bootable-drive)
  - [Downloading Xcode](#xcode-download)
  - [Check Security & Privacy](#security&privacy)
- [Installing macOS Cleanly](#fresh-install)
  - [Apple Silicon](#m1)
  - [Intel Processor](#intel)
- [Before Bootstrapping](#before-bootstrapping)
  - [Install Xcode, Xcode CLI & Rosetta2](#xcode)
  - [Install Oh My ZSH](#oh-my-zsh)
  - [Clone dotfiles repository](#clone)
  - [Install Powerlevel 10k](#powerlevel-10k)
  - [Download Cobalt2 color scheme](#cobalt2-download)
  - [Install NVM as an Oh My ZSH plugin](#nvm)
  - [Install Node](#node)
- [Bootstrapping](#bootstrapping)
- [Create a Rosetta2 Terminal](#rosetta-terminal)
- [Apply Color Scheme to iTerm](#iterm-color)
- [MackUp](#mackup)


## Before Re-Installing macOSX

First, go through the checklist below to make sure you didn't forget anything before you wipe your hard drive.

* Did you commit and push any changes/branches to your git repositories?
* Did you remember to save all important documents from non-iCloud directories?
* Did you save all of your work from apps which aren't synced through iCloud?
* Did you remember to export important data from your local database?
* Did you update [mackup](https://github.com/lra/mackup) to the latest version and ran `mackup backup`?

### Downloading macOSX

Download MacOS Big Sur 11.2.3 disk image to the Downloads folder

```sh
sudo curl -s https://raw.githubusercontent.com/grahampugh/macadmin-scripts/master/installinstallmacos.py | sudo python - --workdir ~/Downloads --version 11.2.3
```

### Creating Bootable Drive

Connect the USB flash drive or other volume that you're using for the bootable installer.

Type or paste one of the following commands in Terminal. These assume that the installer is in your **Applications** folder, and **MyVolume** is the name of the USB flash drive or other volume you're using. If it has a different name, replace MyVolume in these commands with the name of your volume.

Big Sur:

```sh
sudo /Applications/Install\ macOS\ Big\ Sur.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume
```

Mojave:

```sh
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume
```

### Downloading Xcode

This method downloads the given Xcode by URL from the Apple Developer Portal, but uses up to 16 separate connections to do so. You will see a significant download speed improvement.

First, install aria2 from Homebrew if is not already installed

```sh
brew install aria2
```

Make sure you use the 'More' site at https://developer.apple.com/download/more/ even for downloading the latest version of Xcode.

Find the version of Xcode to download and start the download.

Open Develepor tools and go to the 'Application' tab
Find the ADCDownloadAuth cookie and copy its value

Download the script and run it.

Follow the instructions and when prompted, paste the value of the ADCDownloadAuth cookie

```sh
curl -LJO https://gist.githubusercontent.com/iandundas/fabe07455e5216442a421922361f698c/raw/7216e89d4d058510939641fcb1c88debd3770157/xcode-downloader.rb

ruby xccode-downloader.rb
```

If everything goes well you will have a .xip file in your ~/Downloads
Copy the file to a usb drive to install it in the new machine

Clean-up a bit

```sh
cd ~
rm xccode-downloader.rb
```

### Check Security & Privacy

To improve your security and privacy standards check out [this repository](https://github.com/drduh/macOS-Security-and-Privacy-Guide)

## Installing macOS Cleanly

For further info, follow [this article](https://www.imore.com/how-do-clean-install-macos) on how to cleanly install the latest macOS version.

[Determine whether you're using a Mac with Apple silicon](https://support.apple.com/en-gb/HT211814), then follow the appropriate steps:

### Apple Silicon

1. Turn on your Mac and continue to hold the power button until you see the startup options window. Select 'Options'.

2. Select Disk Utility and erase the main hard drive (named data).

3. Turn off the mac

4. Plug the bootable installer into the Mac which is connected to the internet and compatible with the version of macOS you're installing.

5. Turn on your Mac and continue to hold the power button until you see the startup options window, which shows your bootable volumes and a gear icon labled Options.

6. Select the volume containing the bootable installer, then click Continue.

7. When the macOS installer opens, follow the onscreen instructions.

### Intel Processor

1. Turn on your Mac and immediately Press and hold the Option (Alt) ⌥ key.

2. Select Disk Utility and erase the main hard drive (named data).

3. Turn off the mac

4. Plug the bootable installer into the Mac which is connected to the internet and compatible with the version of macOS you're installing.

5. Turn on your Mac and immediately Press and hold the Option (Alt) ⌥ key.

6. Release the Option key when you see a dark screen showing your bootable volumes.

7. Select the volume containing the bootable installer. Then click the up arrow or press Return.

8. If you can't start up from the bootable installer, make sure that the External Boot setting in Startup Security Utility is set to allow booting from external media. Choose your language, if prompted.

9. Select Install macOS (or Install OS X) from the Utilities window, then click Continue and follow the onscreen instructions.

## Before Bootstrapping

Before running the [bootstrap.sh script](bootstrap.sh) we have to manually configure a couple of things first.

### Install Xcode, Xcode CLI & Rosetta2

Insert the usb containing the Xcode_12.4.xip file and copy the .xip file to the Desktop.

Install Xcode Command Line Tools:

```sh
xcode-select --install
```

Move Xcode_12.4.xip to Applications folder and extract it

```sh
sudo mv Xcode_12.4.xip /Applications/Xcode_12.4.xip
sudo xip -x /Applications/Xcode_12.4.xip
```

Then, set the command-line tools directory to point to Xcode

```sh
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```

And agree to the Xcode license

```sh
sudo xcodebuild -license
```

Then, delete the .xip file

```sh
sudo rm /Applications/Xcode_12.4.xip
```

Finally, open Xcode at least once and install the required components and also **Rosetta2**


### Install Oh My ZSH

Once that completes, install oh-my-zsh.

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Clone dotfiles repository

```sh
git clone https://github.com/juan-calle/dotfiles.git ~/.dotfiles/
```

### Install Powerlevel 10k

Execute ths command and follow installation instructions

```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

After that set `ZSH_THEME="powerlevel10k/powerlevel10k"` in `~/.zshrc`

### Download Cobalt2 color scheme
Download the color scheme for iterm

```sh
curl -LJO https://raw.githubusercontent.com/wesbos/Cobalt2-iterm/master/cobalt2.itermcolors
```

### Install NVM as an Oh My ZSH plugin

Clone zsh-nvm into the custom plugins folder

```sh
git clone https://github.com/lukechilds/zsh-nvm ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-nvm
```

Then load as a plugin in .zshrc
Keep in mind that plugins need to be added before oh-my-zsh.sh is sourced.

### Install Node

Now that you have nvm installed you can run the following command to install node.
To see what Node versions are available to install run:

```sh
nvm ls-remote
```

And then install the selected version

```sh
nvm install 14.16.0
```

If everything works correctly this step will take a while to compile everything and
copy the newly built node to the correct install location inside the `~/.nvm` directory.

After the build and install completes. Test the install by running:

```sh
node --version
```

Finally, you will want to clear the nvm cache to reduce clutter. After the build mine was consuming about 11GB, vs about 100MB once the cache was cleared. This can be done using:

```sh
nvm cache clear
```

Now either quit and reopen your Terminal, or run:

```sh
source ~/.zshrc
```

If you have multiple versions and you want to specify which version you would like to use, simply use:

```sh
nvm use whatever_version
```

## Bootstrapping

We're now ready to run  **[bootstrap.sh script](./bootstrap.sh)**, which is a shell script to automate setup of a new macOS development machine.

The script is **idempotent**, meaning it can be run repeatedly on the same system.

To set up a macOS development machine, simply open a terminal, set the environment variables `STRAP_GIT_EMAIL`, `STRAP_GIT_NAME`, and `STRAP_GIT_USER` (GitHub username)

```sh
export STRAP_GIT_EMAIL=juancmcalle@gmail.com
export STRAP_GIT_NAME="Juan Calle"
export STRAP_GIT_USER=juan-calle
```

Then run the following command

```sh
/usr/bin/env bash -c ~/.dotfiles/bootstrap.sh
```

<!-- ```sh
/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/juan-calle/dotfiles/main/bootstrap.sh)"
``` -->

**[bootstrap.sh script](./bootstrap.sh)** will set up macOS and Homebrew, run scripts in the _script/_ directory, and install Homebrew packages
and casks from the **[Brewfile](./Brewfile)**.

## Create a Rosetta2 Terminal

1. Duplicate iTerm.
2. Rename the duplicate with **iTerm-Rosetta.app**
3. **Right click** on the newly created **iTerm-rosetta** > `Get info` > and check the option `Open using Rosetta`

## Apply Color Scheme to iTerm

In iTerm2 access the **Preferences** pane on the **Profiles** tab.

Under the **Colors** tab import the `cobalt2.itermcolors` file via the **Color Presets** drop-down.

Clean-up a bit

```sh
cd ~
rm cobalt2.itermcolors
```

## MackUp

Once the mac settings are applied push/pull to a repo in github
```sh
git clone git@github.com/driesvints/dotfiles.git ~/.dotfiles
```

To start the installation run
```sh
~/.dotfiles/fresh.sh
```

After mackup is synced with your cloud storage, restore preferences by running:

```sh
mackup restore
```

Restart your computer to finalize the process. Your Mac is now ready to use!
Note: you can use a different location than `~/.dotfiles` if you want. Just make sure you also update the reference in the [`.zshrc`](./.zshrc#L2) file.




