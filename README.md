# dotfiles


##This git contains some dotfiles

It's purpose is to help me reconfigure the Unix part of my system.
I have the following tools installed :

- Homebrew : http://http://brew.sh
*To install, run*

		$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

*Then, you might want to run the script "brew.sh" for some useful tools*

- Xquartz : http://xquartz.macosforge.org/landing/

- MacTeX : https://tug.org/mactex/

- Aquamacs : http://aquamacs.org

- Xcode (see Mac AppStore)

- THEOS (development environment for iOS cydia tweaks ) : http://iphonedevwiki.net/index.php/Theos/Getting_Started#On_Mac_OS_X_or_Linux

- Github desktop app : https://desktop.github.com

Then, here is the description of the files :

### Paths & shells files

	/etc/paths
	/etc/shells

These files update the path and add /usr/local/bin/bash (bash version from Homebrew)

### eMacs configuration

	~/.emacs
	~/.emacs.d

### Aquamacs configuration

	~/Library/Preferences/Aquamacs Emacs

### Shell configuration

- Those files are contained in the folder configUnix.
*To install them, run :*

	$ ./bootstrap.sh

**This script will copy the .files to ~**

You might want to take a look to this script since it's excluding some files you might want copied.

- *./brew.sh* installs some useful utilities from homebrew. Make sure HomeBrew is installed.

**Look at the bootstrap.sh file given that it excludes some files from the installation, you might want to copy **

### Git config file

Git config files to be copied :

	~/

