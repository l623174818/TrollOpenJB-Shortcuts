// TrollOpenJB - URL Scheme Support
#import <UIKit/UIKit.h>

static const char *kCommands[] = {
    "cmd_toggle_wifi", "cmd_toggle_bluetooth", "cmd_toggle_airplane_mode",
    "cmd_toggle_cellular_data", "cmd_toggle_vpn", "cmd_toggle_personal_hotspot",
    "cmd_toggle_mute", "cmd_toggle_silent_mode", "cmd_take_screenshot",
    "cmd_screen_record", "cmd_front_app_split", "cmd_respring",
    "cmd_reboot_device", "cmd_activate_siri", "cmd_flashlight_toggle",
    "cmd_low_power_mode", "cmd_orientation_lock", "cmd_auto_lock",
    "cmd_display_brightness", "cmd_display_dim", "cmd_volume_up",
    "cmd_volume_down", "cmd_speaker_volume_up", "cmd_speaker_volume_down",
    "cmd_media_play", "cmd_media_pause", "cmd_media_next",
    "cmd_media_previous", "cmd_shuffle_enabled", "cmd_repeat_mode",
    "cmd_current_playing_info", "cmd_current_album", "cmd_current_artist",
    "cmd_current_track", "cmd_current_album_art", "cmd_current_time",
    "cmd_current_duration", "cmd_is_playing", "cmd_media_seek",
    "cmd_play_at_time", "cmd_set_shuffle", "cmd_set_repeat_mode",
    "cmd_skip_forward", "cmd_skip_backward", "cmd_change_playback_rate",
    "cmd_set_volume", "cmd_set_brightness", "cmd_lock_screen",
    "cmd_go_to_home", "cmd_control_center", "cmd_notification_center",
    "cmd_app_switcher", "cmd_spotlight_search", "cmd_today_view", NULL
};

%hook SpringBoard

%new
- (void)troll_openjb_exec:(NSString *)cmd {
    NSLog(@"[TrollOpenJB] exec: %@", cmd);
}

%new
- (void)cmd_toggle_wifi { NSLog(@"[TrollOpenJB] WiFi"); }
%new - (void)cmd_toggle_bluetooth { NSLog(@"BT"); }
%new - (void)cmd_toggle_airplane_mode { NSLog(@"Airplane"); }
%new - (void)cmd_toggle_cellular_data { NSLog(@"Cellular"); }
%new - (void)cmd_toggle_vpn { NSLog(@"VPN"); }
%new - (void)cmd_toggle_personal_hotspot { NSLog(@"Hotspot"); }
%new - (void)cmd_toggle_mute { NSLog(@"Mute"); }
%new - (void)cmd_toggle_silent_mode { NSLog(@"Silent"); }
%new - (void)cmd_take_screenshot { NSLog(@"Screenshot"); }
%new - (void)cmd_screen_record { NSLog(@"Record"); }
%new - (void)cmd_front_app_split { NSLog(@"Split"); }
%new - (void)cmd_respring { [[UIApplication sharedApplication] performSelector:@selector(_relaunch) withObject:nil afterDelay:0.5]; }
%new - (void)cmd_reboot_device { NSLog(@"Reboot"); }
%new - (void)cmd_activate_siri { NSLog(@"Siri"); }
%new - (void)cmd_flashlight_toggle { NSLog(@"Flashlight"); }
%new - (void)cmd_low_power_mode { NSLog(@"LowPower"); }
%new - (void)cmd_orientation_lock { NSLog(@"Orientation"); }
%new - (void)cmd_auto_lock { NSLog(@"AutoLock"); }
%new - (void)cmd_display_brightness { NSLog(@"Brightness"); }
%new - (void)cmd_display_dim { NSLog(@"Dim"); }
%new - (void)cmd_volume_up { NSLog(@"Vol+"); }
%new - (void)cmd_volume_down { NSLog(@"Vol-"); }
%new - (void)cmd_speaker_volume_up { NSLog(@"Spk+"); }
%new - (void)cmd_speaker_volume_down { NSLog(@"Spk-"); }
%new - (void)cmd_media_play { NSLog(@"Play"); }
%new - (void)cmd_media_pause { NSLog(@"Pause"); }
%new - (void)cmd_media_next { NSLog(@"Next"); }
%new - (void)cmd_media_previous { NSLog(@"Prev"); }
%new - (void)cmd_shuffle_enabled { NSLog(@"Shuffle"); }
%new - (void)cmd_repeat_mode { NSLog(@"Repeat"); }
%new - (void)cmd_current_playing_info { NSLog(@"Info"); }
%new - (void)cmd_current_album { NSLog(@"Album"); }
%new - (void)cmd_current_artist { NSLog(@"Artist"); }
%new - (void)cmd_current_track { NSLog(@"Track"); }
%new - (void)cmd_current_album_art { NSLog(@"Artwork"); }
%new - (void)cmd_current_time { NSLog(@"Time"); }
%new - (void)cmd_current_duration { NSLog(@"Duration"); }
%new - (void)cmd_is_playing { NSLog(@"Playing"); }
%new - (void)cmd_media_seek { NSLog(@"Seek"); }
%new - (void)cmd_play_at_time { NSLog(@"PlayAt"); }
%new - (void)cmd_set_shuffle { NSLog(@"SetShuffle"); }
%new - (void)cmd_set_repeat_mode { NSLog(@"SetRepeat"); }
%new - (void)cmd_skip_forward { NSLog(@"Fwd"); }
%new - (void)cmd_skip_backward { NSLog(@"Bwd"); }
%new - (void)cmd_change_playback_rate { NSLog(@"Rate"); }
%new - (void)cmd_set_volume { NSLog(@"SetVol"); }
%new - (void)cmd_set_brightness { NSLog(@"SetBri"); }
%new - (void)cmd_lock_screen { NSLog(@"Lock"); }
%new - (void)cmd_go_to_home { NSLog(@"Home"); }
%new - (void)cmd_control_center { NSLog(@"CC"); }
%new - (void)cmd_notification_center { NSLog(@"NC"); }
%new - (void)cmd_app_switcher { NSLog(@"Switcher"); }
%new - (void)cmd_spotlight_search { NSLog(@"Spotlight"); }
%new - (void)cmd_today_view { NSLog(@"Today"); }

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)opts {
    if ([url.scheme isEqualToString:@"troll-openjb"] || [url.scheme isEqualToString:@"troj"]) {
        NSString *cmd = url.host ?: (url.path.length > 1 ? [url.path substringFromIndex:1] : nil);
        NSLog(@"[TrollOpenJB] URL: scheme=%@ cmd=%@", url.scheme, cmd);
        if (cmd) {
            SEL sel = NSSelectorFromString(cmd);
            if ([self respondsToSelector:sel]) {
                ((void(*)(id, SEL))objc_msgSend)(self, sel);
            }
        }
        return YES;
    }
    return %orig;
}

%end

%ctor {
    int count = 0;
    while (kCommands[count]) count++;
    NSLog(@"[TrollOpenJB] Loaded (%d commands)", count);
}
