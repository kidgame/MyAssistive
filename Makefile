include theos/makefiles/common.mk
GO_EASY_ON_ME = 1
export ARCHS = armv7
TWEAK_NAME = MyAssistive
MyAssistive_FILES = MyAssistive.x
MyAssistive_FRAMEWORKS = UIKit CoreGraphics AVFoundation
MyAssistive_PRIVATE_FRAMEWORKS = GraphicsServices BackBoardServices

include $(THEOS_MAKE_PATH)/tweak.mk

BUNDLE_NAME = MyAssistiveSettings
MyAssistiveSettings_FILES = MyAssistivePreferenceController.m
MyAssistiveSettings_INSTALL_PATH = /Library/PreferenceBundles
MyAssistiveSettings_PRIVATE_FRAMEWORKS = Preferences
MyAssistiveSettings_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/MyAssistive.plist$(ECHO_END)
	$(ECHO_NOTHING)find $(THEOS_STAGING_DIR) -name .DS_Store | xargs rm -rf$(ECHO_END)

