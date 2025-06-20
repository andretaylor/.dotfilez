#!/bin/bash

function setup_macos_defaults() {
	clear

	# Define color variables
	local COLOR_GREEN='\033[0;32m'
	local COLOR_RED='\033[0;31m'
	local RESET_COLOR='\033[0m'

	begin_setup() {
		printf "%b\n" "${COLOR_GREEN}Setting macOS defaults...${RESET_COLOR}"

		# Close any open System Preferences panes, to prevent them from overriding
		osascript -e 'tell application "System Preferences" to quit'

		# Ask for the administrator password upfront
		sudo -v
	}

	apply_ui_settings() {
		printf "%b\n" "${COLOR_GREEN}Applying General UI/UX settings.${RESET_COLOR}"

		# Set computer name (as done via System Preferences → Sharing)
		# sudo scutil --set ComputerName "SystemName"
		# sudo scutil --set HostName "SystemName"
		# sudo scutil --set LocalHostName "SystemName"
		sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "SystemName"

		# Disable the sound effects on boot
		sudo nvram SystemAudioVolume=" "

		# Set highlight color to green
		defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

		# Set sidebar icon size to medium (1: small, 2: medium, 3: large)
		defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

		# Always show scrollbars (Possible values: `WhenScrolling`, `Automatic` and `Always`)
		defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

		# Disable the over-the-top focus ring animation
		defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

		# Adjust toolbar title rollover delay
		defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0

		# Set menu bar clock to 24-hour format
		defaults write com.apple.menuextra.clock DateFormat -string "HH:mm"

		# Show battery percentage in the menu bar
		defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist BatteryShowPercentage -bool true

		# Increase window resize speed for Cocoa applications (default is 0.2)
		defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

		# Expand save panel by default
		defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
		defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

		# Expand print panel by default
		defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
		defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

		# Save to disk by default
		defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

		# Automatically quit printer app once the print jobs complete
		defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

		# Disable the “Are you sure you want to open this application?” dialog
		defaults write com.apple.LaunchServices LSQuarantine -bool false

		# Remove duplicates in the “Open With” menu
		/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

		# Display ASCII control characters using caret notation in standard text views
		# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
		defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

		# Disable automatic termination of inactive apps
		defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

		# Disable the crash reporter dialog
		defaults write com.apple.CrashReporter DialogType -string "none"

		# Set Help Viewer windows to non-floating mode
		defaults write com.apple.helpviewer DevMode -bool true

		# Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
		sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

		# Disable Notification Center and remove the menu bar icon
		launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2>/dev/null

		# Disable automatic capitalization
		defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

		# Disable smart dashes
		defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

		# Disable automatic period substitution
		defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

		# Disable smart quotes
		defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

		# Disable auto-correct
		defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

		# Set a custom wallpaper image. `DefaultDesktop.jpg` is already a symlink, and
		# all wallpapers are in `/Library/Desktop Pictures/`. The default is `Wave.jpg`.
		osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/System/Library/Desktop Pictures/Solid Colors/Black.png"'

	}

	apply_input_device_settings() {
		printf "%b\n" "${COLOR_GREEN}Applying Input Device settings.${RESET_COLOR}"

		# Trackpad: Disable the Notification Center Gesture
		defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipe -int 0

		# Trackpad: enable tap to click for this user and for the login screen
		defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
		defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
		defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

		# Trackpad: map bottom right corner to right-click
		defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
		defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
		defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
		defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

		# Enable “natural” (Lion-style) scrolling
		defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

		# Increase sound quality for Bluetooth headphones/headsets
		defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

		# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
		defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

		# Disable press-and-hold for keys in favor of key repeat
		defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

		# Set keyboard repeat rate
		defaults write NSGlobalDomain KeyRepeat -int 3
		defaults write NSGlobalDomain InitialKeyRepeat -int 25

		# Set language and text formats
		# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
		# `Inches`, `en_GB` with `en_US`, and `true` with `false`.
		defaults write NSGlobalDomain AppleLanguagses -array "en" "nl"
		defaults write NSGlobalDomain AppleLocale -string "en_US@currency=US"
		defaults write NSGlobalDomain AppleMeasurementUnits -string "Inches"
		defaults write NSGlobalDomain AppleMetricUnits -bool false

		# Show language menu in the top right corner of the boot screen
		sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

		# Set the timezone; see `sudo systemsetup -listtimezones` for other values
		sudo systemsetup -settimezone "America/Los_Angeles" >/dev/null

		# Stop iTunes from responding to the keyboard media keys
		# launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2>/dev/null
	}

	apply_energy_saving_settings() {
		printf "%b\n" "${COLOR_GREEN}Applying Energy Saving settings.${RESET_COLOR}"

		# Enable lid wakeup
		sudo pmset -a lidwake 1

		# Restart automatically on power loss
		sudo pmset -a autorestart 1

		# Restart automatically if the computer freezes
		sudo systemsetup -setrestartfreeze on

		# Sleep the display after 15 minutes
		sudo pmset -a displaysleep 15 2>/dev/null

		# Disable machine sleep while charging
		sudo pmset -c sleep 0

		# Sleep the display after 15 minutes
		sudo pmset -b displaysleep 15 2>/dev/null

		# Set machine sleep to 15 minutes on battery
		sudo pmset -b sleep 15

		# Set standby delay to 24 hours (default is 1 hour)
		sudo pmset -a standbydelay 86400

		# Never go into computer sleep mode
		# sudo systemsetup -setcomputersleep Off > /dev/null

		# Hibernation mode
		# 0: Disable hibernation (speeds up entering sleep mode)
		# 3: Copy RAM to disk so the system state can still be restored in case of a
		#    power failure.
		sudo pmset -a hibernatemode 0

		# Enable Low Power Mode (makes battery icon yellow)
		sudo pmset -a lowpowermode 1

	}

	apply_screen_related_settings() {
		printf "%b\n" "${COLOR_GREEN}Applying Screen settings.${RESET_COLOR}"

		# Require password immediately after sleep or screen saver begins
		defaults write com.apple.screensaver askForPassword -int 1
		defaults write com.apple.screensaver askForPasswordDelay -int 0

		# Save screenshots to the desktop
		defaults write com.apple.screencapture location -string "${HOME}/Desktop"

		# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
		defaults write com.apple.screencapture type -string "png"

		# Disable shadow in screenshots
		defaults write com.apple.screencapture disable-shadow -bool true

		# Enable subpixel font rendering on non-Apple LCDs
		# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
		defaults write NSGlobalDomain AppleFontSmoothing -int 1

		# Enable HiDPI display modes (requires restart)
		sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

	}

	apply_finder_settings() {
		printf "%b\n" "${COLOR_GREEN}Applying Finder settings.${RESET_COLOR}"

		# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
		defaults write com.apple.finder QuitMenuItem -bool true

		# Finder: disable window animations and Get Info animations
		defaults write com.apple.finder DisableAllAnimations -bool true

		# Set Desktop as the default location for new Finder windows
		# For other paths, use `PfLo` and `file:///full/path/here/`
		defaults write com.apple.finder NewWindowTarget -string "PfDe"
		defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

		# Show icons for hard drives, servers, and removable media on the desktop
		defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
		defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
		defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
		defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

		# Finder: show hidden files by default
		defaults write com.apple.finder AppleShowAllFiles -bool true

		# Finder: show all filename extensions
		defaults write NSGlobalDomain AppleShowAllExtensions -bool true

		# Finder: show status bar
		defaults write com.apple.finder ShowStatusBar -bool true

		# Finder: show path bar
		defaults write com.apple.finder ShowPathbar -bool true

		# Display full POSIX path as Finder window title
		defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

		# Keep folders on top when sorting by name
		defaults write com.apple.finder _FXSortFoldersFirst -bool true

		# When performing a search, search the current folder by default
		defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

		# Disable the warning when changing a file extension
		defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

		# Enable spring loading for directories
		defaults write NSGlobalDomain com.apple.springing.enabled -bool true

		# Remove the spring loading delay for directories
		defaults write NSGlobalDomain com.apple.springing.delay -float 0

		# Avoid creating .DS_Store files on network or USB volumes
		defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
		defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

		# Disable disk image verification
		defaults write com.apple.frameworks.diskimages skip-verify -bool true
		defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
		defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

		# Automatically open a new Finder window when a volume is mounted
		defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
		defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
		defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

		# Show item info near icons on the desktop and in other icon views
		/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
		/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
		/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

		# Show item info to the right of the icons on the desktop
		/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

		# Enable snap-to-grid for icons on the desktop and in other icon views
		/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
		/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
		/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

		# Increase grid spacing for icons on the desktop and in other icon views
		/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
		/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
		/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

		# Increase the size of icons on the desktop and in other icon views
		/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
		/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
		/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

		# Use list view in all Finder windows by default
		# List view (Nlsv).
		# Icon view (icnv),
		# Column view (clmv)
		# Gallery view (glyv)
		defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

		# Disable the warning before emptying the Trash
		defaults write com.apple.finder WarnOnEmptyTrash -bool false

		# Show the ~/Library folder
		chflags nohidden ~/Library
		if xattr -p com.apple.FinderInfo ~/Library &>/dev/null; then
			xattr -d com.apple.FinderInfo ~/Library
		fi

		# Show the /Volumes folder
		sudo chflags nohidden /Volumes

		# Expand the following File Info panes:
		# “General”, “Open with”, and “Sharing & Permissions”
		defaults write com.apple.finder FXInfoPanesExpanded -dict \
			General -bool true \
			OpenWith -bool true \
			Privileges -bool true
	}

	apply_launchpad_settings() {
		printf "%b\n" "${COLOR_GREEN}Applying Launchpad settings.${RESET_COLOR}"

		# Reset Launchpad
		# defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock

		# Display Launchpad as a grid
		defaults write com.apple.dock springboard-columns -int 7
		defaults write com.apple.dock springboard-rows -int 5

		# Disable Launchpad gesture (pinch with thumb and three fingers)
		defaults write com.apple.dock showLaunchpadGestureEnabled -int 0
	}

	apply_dock_settings() {
		printf "%b\n" "${COLOR_GREEN}Applying Dock settings.${RESET_COLOR}"

		# Add a spacer to the left side of the Dock (where the applications are)
		#defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
		# Add a spacer to the right side of the Dock (where the Trash is)
		#defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'

		# Don’t automatically rearrange Spaces based on most recent use
		defaults write com.apple.dock mru-spaces -bool false

		# Remove the auto-hiding Dock delay
		defaults write com.apple.dock autohide-delay -float 0
		# Remove the animation when hiding/showing the Dock
		defaults write com.apple.dock autohide-time-modifier -float 0

		# Automatically hide and show the Dock
		defaults write com.apple.dock autohide -bool true
		defaults write com.apple.Dock autohide-delay -float 0

		# Make Dock icons of hidden applications translucent
		defaults write com.apple.dock showhidden -bool true

		# Don’t show recent applications in Dock
		defaults write com.apple.dock show-recents -bool false

		# Enable highlight hover effect for the grid view of a stack (Dock)
		defaults write com.apple.dock mouse-over-hilite-stack -bool true

		# Set the icon size of Dock items to 36 pixels
		defaults write com.apple.dock tilesize -int 16

		# Change minimize/maximize window effect
		defaults write com.apple.dock mineffect -string "scale"

		# Minimize windows into their application’s icon
		defaults write com.apple.dock minimize-to-application -bool true

		# Enable spring loading for all Dock items
		defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

		# Show indicator lights for open applications in the Dock
		defaults write com.apple.dock show-process-indicators -bool true

		# Wipe all (default) app icons from the Dock
		# This is only really useful when setting up a new Mac, or if you don’t use
		# the Dock to launch apps.
		defaults write com.apple.dock persistent-apps -array

		# Show only open applications in the Dock
		defaults write com.apple.dock static-only -bool true

		# Don’t animate opening applications from the Dock
		defaults write com.apple.dock launchanim -bool false
	}

	apply_dashboard_settings() {
		printf "%b\n" "${COLOR_GREEN}Applying Dashboard settings.${RESET_COLOR}"

		# Disable Dashboard
		defaults write com.apple.dashboard mcx-disabled -bool true

		# Don’t show Dashboard as a Space
		defaults write com.apple.dock dashboard-in-overlay -bool true
	}

	apply_spotlight_settings() {
		printf "%b\n" "${COLOR_GREEN}Applying Spotlight settings.${RESET_COLOR}"

		# Hide Spotlight tray-icon (and subsequent helper)
		sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
		# Disable Spotlight indexing for any volume that gets mounted and has not yet
		# been indexed before.
		# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
		sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

		# Change indexing order and disable some search results
		defaults write com.apple.spotlight orderedItems -array \
			'{"enabled" = 1;"name" = "APPLICATIONS";}' \
			'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
			'{"enabled" = 1;"name" = "DIRECTORIES";}' \
			'{"enabled" = 1;"name" = "PDF";}' \
			'{"enabled" = 1;"name" = "FONTS";}' \
			'{"enabled" = 0;"name" = "DOCUMENTS";}' \
			'{"enabled" = 0;"name" = "MESSAGES";}' \
			'{"enabled" = 0;"name" = "CONTACT";}' \
			'{"enabled" = 0;"name" = "EVENT_TODO";}' \
			'{"enabled" = 0;"name" = "IMAGES";}' \
			'{"enabled" = 0;"name" = "BOOKMARKS";}' \
			'{"enabled" = 0;"name" = "MUSIC";}' \
			'{"enabled" = 0;"name" = "MOVIES";}' \
			'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
			'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
			'{"enabled" = 0;"name" = "SOURCE";}' \
			'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
			'{"enabled" = 0;"name" = "MENU_OTHER";}' \
			'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
			'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
			'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
			'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

		killall mds >/dev/null 2>&1    # Load new settings before rebuilding the index
		sudo mdutil -i on / >/dev/null # Make sure indexing is enabled for the main volume
		sudo mdutil -E / >/dev/null    # Rebuild the index from scratch
	}

	apply_mac_app_store_settings() {
		printf "%b\n" "${COLOR_GREEN}Applying Mac App Store settings.${RESET_COLOR}"

		# Enable the WebKit Developer Tools in the Mac App Store
		defaults write com.apple.appstore WebKitDeveloperExtras -bool true

		# Enable Debug Menu in the Mac App Store
		defaults write com.apple.appstore ShowDebugMenu -bool true

		# Enable the automatic update check
		defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

		# Check for software updates daily, not just once per week
		defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

		# Download newly available updates in background
		defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

		# Install System data files & security updates
		defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

		# Automatically download apps purchased on other Macs
		defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

		# Turn on app auto-update
		defaults write com.apple.commerce AutoUpdate -bool true

		# Allow the App Store to reboot machine on macOS updates
		defaults write com.apple.commerce AutoUpdateRestartRequired -bool true
	}

	apply_terminal_settings() {
		printf "%b\n" "${COLOR_GREEN}Applying Terminal settings.${RESET_COLOR}"

		# Only use UTF-8 in Terminal.app
		defaults write com.apple.terminal StringEncodings -array 4

		# Enable “focus follows mouse” for Terminal.app and all X11 apps
		# i.e. hover over a window and start typing in it without clicking first
		defaults write com.apple.terminal FocusFollowsMouse -bool true
		defaults write org.x.X11 wm_ffm -bool true

		# Enable Secure Keyboard Entry in Terminal.app
		# See: https://security.stackexchange.com/a/47786/8918
		defaults write com.apple.terminal SecureKeyboardEntry -bool true

		# Disable the annoying line marks
		defaults write com.apple.Terminal ShowLineMarks -int 0

		# Quit without asking for confirmation
		defaults write com.googlecode.iterm2 PromptOnQuit -bool false
	}

	apply_activity_monitor_settings() {
		printf "%b\n" "${COLOR_GREEN}Applying Activity Monitor settings.${RESET_COLOR}"

		# Show the main window when launching Activity Monitor
		defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

		# Visualize CPU usage in the Activity Monitor Dock icon
		defaults write com.apple.ActivityMonitor IconType -int 5

		# Show all processes in Activity Monitor
		defaults write com.apple.ActivityMonitor ShowCategory -int 0

		# Sort Activity Monitor results by CPU usage
		defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
		defaults write com.apple.ActivityMonitor SortDirection -int 0
	}

	apply_miscellaneous_system_settings() {
		printf "%b\n" "${COLOR_GREEN}Applying Miscellaneous System settings.${RESET_COLOR}"

		###############################################################################
		# Hot Corners					                                                            #
		###############################################################################
		# Possible values:
		#  0: no-op
		#  2: Mission Control
		#  3: Show application windows
		#  4: Desktop
		#  5: Start screen saver
		#  6: Disable screen saver
		#  7: Dashboard
		# 10: Put display to sleep
		# 11: Launchpad
		# 12: Notification Center
		# 13: Lock Screen
		# Top left screen corner → Mission Control
		defaults write com.apple.dock wvous-tl-corner -int 5
		defaults write com.apple.dock wvous-tl-modifier -int 0
		# Top right screen corner → Desktop
		defaults write com.apple.dock wvous-tr-corner -int 4
		defaults write com.apple.dock wvous-tr-modifier -int 0
		# Bottom left screen corner → Start screen saver
		defaults write com.apple.dock wvous-bl-corner -int 3
		defaults write com.apple.dock wvous-bl-modifier -int 0

		###############################################################################
		# Launchpad					                                                            #
		###############################################################################
		# Disable the Launchpad gesture (pinch with thumb and three fingers)
		#defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

		###############################################################################
		# Photos					                                                            #
		###############################################################################

		# Prevent Photos from opening automatically when devices are plugged in
		defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

		###############################################################################
		# Mission Control					                                                            #
		###############################################################################

		# Speed up Mission Control animations
		defaults write com.apple.dock expose-animation-duration -float 0.1

		# Don’t group windows by application in Mission Control
		# (i.e. use the old Exposé behavior instead)
		defaults write com.apple.dock expose-group-by-app -bool false

		###############################################################################
		# Time Machine                                                                #
		###############################################################################

		# Prevent Time Machine from prompting to use new hard drives as backup volume
		defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

		# Disable the sound effects on boot
		sudo nvram SystemAudioVolume=" "
	}

	apply_google_chrome_settings() {
		printf "%b\n" "${COLOR_GREEN}Applying Google Chrome settings.${RESET_COLOR}"

		# Disable the all too sensitive backswipe on trackpads
		defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
		defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

		# Disable the all too sensitive backswipe on Magic Mouse
		defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
		defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false

		# Use the system-native print preview dialog
		defaults write com.google.Chrome DisablePrintPreview -bool true
		defaults write com.google.Chrome.canary DisablePrintPreview -bool true

		# Expand the print dialog by default
		defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
		defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true
	}

	restart_affected_apps() {
		printf "%b\n" "${COLOR_GREEN}Restarting affected applications...${RESET_COLOR}"

		# List of applications to restart
		local apps=(
			"Activity Monitor"
			"ControlCenter"
			"Dock"
			"Finder"
			"Google Chrome Canary"
			"Google Chrome"
			"Opera"
			"Photos"
			"SystemUIServer"
			"Terminal"
			"iCal"
		)

		printf "%b\n" "${COLOR_GREEN}Setting defaults...${RESET_COLOR}"

		for app in "${apps[@]}"; do
			if killall "$app" &>/dev/null; then
				printf "%b\n" "${COLOR_GREEN}Restarted ${app}.${RESET_COLOR}"
			else
				printf "%b\n" "${COLOR_RED}${app} is not running.${RESET_COLOR}"
			fi
		done

		printf "%b\n" "${COLOR_GREEN}Done.${RESET_COLOR}"
		printf "%b\n" "${COLOR_GREEN}Note that some of these changes require a logout/restart to take effect.${RESET_COLOR}"
	}

	begin_setup
	apply_ui_settings
	apply_input_device_settings
	apply_energy_saving_settings
	apply_screen_related_settings
	apply_finder_settings
	apply_launchpad_settings
	apply_dock_settings
	apply_dashboard_settings
	apply_spotlight_settings
	apply_mac_app_store_settings
	apply_terminal_settings
	apply_activity_monitor_settings
	apply_miscellaneous_system_settings
	apply_google_chrome_settings
	restart_affected_apps

	printf "%b\n" "${COLOR_GREEN}Defaults set.${RESET_COLOR}"
}

setup_macos_defaults
