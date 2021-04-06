# Start by following the steps about privacy and security in this repo
# https://github.com/drduh/macOS-Security-and-Privacy-Guide
# boot into Recovery Mode and start boot to a USB installer

# -----------------------
# 🔴 XCODE AND XCODE CLI
#------------------------
# Copy xip file to applications folder
# After that install Xcode command line tools
xcode-select --install

# Extract Xcode installer
xip -x /Applications/Xcode_12.4.xip

# Then, set the command-line tools directory to point to Xcode
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# And agree to the Xcode license
sudo xcodebuild -license

# -----------------------
# 🔴 OH MY ZSH
#------------------------
# Once that completes, install oh-my-zsh.
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# -----------------------
# 🔴 ZSH For Humans
#------------------------
# Run the following command.
if command -v curl >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v4/install)"
else
  sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v4/install)"
fi


# -----------------------
# 🔴 NVM
#------------------------
# Clone zsh-nvm into the custom plugins repo
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm

# Then load as a plugin in .zshrc
# Keep in mind that plugins need to be added before oh-my-zsh.sh is sourced.
plugins+=(zsh-nvm)


# -----------------------
# 🔴 NODE
#------------------------
# Now that you have nvm installed you can run the following command to install node.
# To see what Node versions are available to install run:
nvm ls-remote

# And then install the selected version
nvm install 14.16.0

# If everything works correctly this step will take a while to compile everything and
# copy the newly built node to the correct install location inside the ~/.nvm directory.
# After the build and install completes. Test the install by running:
node --version

# Finally, you will want to clear the nvm cache to reduce clutter. After the build mine was
# consuming about 11GB, vs about 100MB once the cache was cleared. This can be done using:
nvm cache clear


# Now either quit and reopen your Terminal, or run
source ~/.zshrc

# If you have multiple versions and you want to specify which version you would like to use, simply use:
nvm use {whatever version}


# --------------------------------------------
# 🔴 BOOTSTRAP SCRIPT FOR INSTALLING BREW .SH
#---------------------------------------------
# Then head over to _bootstrap.sh_ is a shell script to automate setup of a new macOS development machine. It is
# _idempotent_, meaning it can be run repeatedly on the same system. To set up a macOS development machine, simply
# open a terminal, set the environment variables `STRAP_GIT_EMAIL`, `STRAP_GIT_NAME`, and `STRAP_GIT_USER` (
# GitHub username), and run the following command
/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/juan-calle/dotfiles/main/bootstrap.sh)"
#_bootstrap.sh_ will set up macOS and Homebrew, run scripts in the _script/_ directory, and install Homebrew packages
# and casks from the _[Brewfile](Brewfile)_.



# -----------------------
# 🔴 MACOS.SH
#------------------------
# MacOS setup is automated BY (script/macos.sh)
# Update macOS to the latest version with the App Store
# Generate a new public and private SSH key](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) by running:
curl https://raw.githubusercontent.com/driesvints/dotfiles/HEAD/ssh.sh | sh -s "<your-email-address>"


# Once the mac settings are applied push/pull to a repo in github
git clone git@github.com/driesvints/dotfiles.git ~/.dotfiles

# To start the installation run
~/.dotfiles/fresh.sh

# After mackup is synced with your cloud storage, restore preferences by running `mackup restore`
# Restart your computer to finalize the process. Your Mac is now ready to use!
# Note: you can use a different location than `~/.dotfiles` if you want. Just make sure you also update the reference in the [`.zshrc`](./.zshrc#L2) file.