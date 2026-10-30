// TrollOpenJB - URL Scheme Support
#import <UIKit/UIKit.h>

static NSArray *_Commands = nil;
static NSArray *Commands() {
    if (!_Commands) {
        _Commands = @[
            @"cmd_toggle_wifi", @"cmd_toggle_bluetooth", @"cmd_toggle_airplane_mode",
            @"cmd_toggle_cellular_data", @"cmd_toggle_vpn", @"cmd_toggle_personal_hotspot",
            @"cmd_toggle_mute", @"cmd_toggle_silent_mode", @"cmd_take_screenshot",
            @"cmd_screen_record", @"cmd_front_app_split", @"cmd_respring",
            @"cmd_reboot_device", @"cmd_activate_siri", @"cmd_flashlight_toggle",
            @"cmd_low_power_mode", @"cmd_orientation_lock", @"cmd_auto_lock",
            @"cmd_display_brightness", @"cmd_display_dim", @"cmd_volume_up",
            @"cmd_volume_down", @"cmd_speaker_volume_up", @"cmd_speaker_volume_down",
            @"cmd_media_play", @"cmd_media_pause", @"cmd_media_next",
            @"cmd_media_previous", @"cmd_shuffle_enabled", @"cmd_repeat_mode",
            @"cmd_current_playing_info", @"cmd_current_album", @"cmd_current_artist",
            @"cmd_current_track", @"cmd_current_album_art", @"cmd_current_time",
            @"cmd_current_duration", @"cmd_is_playing", @"cmd_media_seek",
            @"cmd_play_at_time", @"cmd_set_shuffle", @"cmd_set_repeat_mode",
            @"cmd_skip_forward", @"cmd_skip_backward", @"cmd_change_playback_rate",
            @"cmd_set_volume", @"cmd_set_brightness", @"cmd_lock_screen",
            @"cmd_go_to_home", @"cmd_control_center", @"cmd_notification_center",
            @"cmd_app_switcher", @"cmd_spotlight_search", @"cmd_today_view"
        ];
    }
    return _Commands;
}

%hook SpringBoard

%new
- (void)troll_openjb_handleURL:(NSURL *)url {
    NSString *host = url.host;
    if (!host && url.path.length > 1) {
        host = [url.path substringFromIndex:1];
    }
    NSLog(@"[TrollOpenJB] URL: scheme=%@ host=%@", url.scheme, host);
    
    if (host && [Commands containsObject:host]) {
        SEL sel = NSSelectorFromString(host);
        if ([self respondsToSelector:sel]) {
            ((void(*)(id, SEL))objc_msgSend)(self, sel);
        }
    }
}

%new -I
- (void)cmd_toggle_wifi { NSLog(@"[TrollOpenJB] WiFi"); }
%new -I
- (void)cmd_toggle_bluetooth { NSLog(@"[TrollOpenJB] BT"); }
%new -I
- (void)cmd_toggle_airplane_mode { NSLog(@"[TrollOpenJB] Airplane"); }
%new -I
- (void)cmd_toggle_cellular_data { NSLog(@"[TrollOpenJB] Cellular"); }
%new -I
- (void)cmd_toggle_vpn { NSLog(@"[TrollOpenJB] VPN"); }
%new -I
- (void)cmd_toggle_personal_hotspot { NSLog(@"[TrollOpenJB] Hotspot"); }
%new -I
- (void)cmd_toggle_mute { NSLog(@"[TrollOpenJB] Mute"); }
%new -I
- (void)cmd_toggle_silent_mode { NSLog(@"[TrollOpenJB] Silent"); }
%new -I
- (void)cmd_take_screenshot { NSLog(@"[TrollOpenJB] Screenshot"); }
%new -I
- (void)cmd_screen_record { NSLog(@"[TrollOpenJB] Record"); }
%new -I
- (void)cmd_front_app_split { NSLog(@"[TrollOpenJB] Split"); }
%new -I
- (void)cmd_respring { 
    [[UIApplication sharedApplication] performSelector:@selector(_relaunch) withObject:nil afterDelay:0.5];
}
%new -I
- (void)cmd_reboot_device { NSLog(@"[TrollOpenJB] Reboot"); }
%new -I
- (void)cmd_activate_siri { NSLog(@"[TrollOpenJB] Siri"); }
%new -I
- (void)cmd_flashlight_toggle { NSLog(@"[TrollOpenJB] Flashlight"); }
%new -I
- (void)cmd_low_power_mode { NSLog(@"[TrollOpenJB] LowPower"); }
%new -I
- (void)cmd_orientation_lock { NSLog(@"[TrollOpenJB] Orientation"); }
%new -I
- (void)cmd_auto_lock { NSLog(@"[TrollOpenJB] AutoLock"); }
%new -I
- (void)cmd_display_brightness { NSLog(@"[TrollOpenJB] Brightness"); }
%new -I
- (void)cmd_display_dim { NSLog(@"[TrollOpenJB] Dim"); }
%new -I
- (void)cmd_volume_up { NSLog(@"[TrollOpenJB] Vol+"); }
%new -I
- (void)cmd_volume_down { NSLog(@"[TrollOpenJB] Vol-"); }
%new -I
- (void)cmd_speaker_volume_up { NSLog(@"[TrollOpenJB] Spk+"); }
%new -I
- (void)cmd_speaker_volume_down { NSLog(@"[TrollOpenJB] Spk-"); }
%new -I
- (void)cmd_media_play { NSLog(@"[TrollOpenJB] Play"); }
%new -I
- (void)cmd_media_pause { NSLog(@"[TrollOpenJB] Pause"); }
%new -I
- (void)cmd_media_next { NSLog(@"[TrollOpenJB] Next"); }
%new -I
- (void)cmd_media_previous { NSLog(@"[TrollOpenJB] Prev"); }
%new -I
- (void)cmd_shuffle_enabled { NSLog(@"[TrollOpenJB] Shuffle"); }
%new -I
- (void)cmd_repeat_mode { NSLog(@"[TrollOpenJB] Repeat"); }
%new -I
- (void)cmd_current_playing_info { NSLog(@"[TrollOpenJB] Info"); }
%new -I
- (void)cmd_current_album { NSLog(@"[TrollOpenJB] Album"); }
%new -I
- (void)cmd_current_artist { NSLog(@"[TrollOpenJB] Artist"); }
%new -I
- (void)cmd_current_track { NSLog(@"[TrollOpenJB] Track"); }
%new -I
- (void)cmd_current_album_art { NSLog(@"[TrollOpenJB] Artwork"); }
%new -I
- (void)cmd_current_time { NSLog(@"[TrollOpenJB] Time"); }
%new -I
- (void)cmd_current_duration { NSLog(@"[TrollOpenJB] Duration"); }
%new -I
- (void)cmd_is_playing { NSLog(@"[TrollOpenJB] Playing"); }
%new -I
- (void)cmd_media_seek { NSLog(@"[TrollOpenJB] Seek"); }
%new -I
- (void)cmd_play_at_time { NSLog(@"[TrollOpenJB] PlayAt"); }
%new -I
- (void)cmd_set_shuffle { NSLog(@"[TrollOpenJB] SetShuffle"); }
%new -I
- (void)cmd_set_repeat_mode { NSLog(@"[TrollOpenJB] SetRepeat"); }
%new -I
- (void)cmd_skip_forward { NSLog(@"[TrollOpenJB] Fwd"); }
%new -I
- (void)cmd_skip_backward { NSLog(@"[TrollOpenJB] Bwd"); }
%new -I
- (void)cmd_change_playback_rate { NSLog(@"[TrollOpenJB] Rate"); }
%new -I
- (void)cmd_set_volume { NSLog(@"[TrollOpenJB] SetVol"); }
%new -I
- (void)cmd_set_brightness { NSLog(@"[TrollOpenJB] SetBri"); }
%new -I
- (void)cmd_lock_screen { NSLog(@"[TrollOpenJB] Lock"); }
%new -I
- (void)cmd_go_to_home { NSLog(@"[TrollOpenJB] Home"); }
%new -I
- (void)cmd_control_center { NSLog(@"[TrollOpenJB] CC"); }
%new -I
- (void)cmd_notification_center { NSLog(@"[TrollOpenJB] NC"); }
%new -I
- (void)cmd_app_switcher { NSLog(@"[TrollOpenJB] Switcher"); }
%new -I
- (void)cmd_spotlight_search { NSLog(@"[TrollOpenJB] Spotlight"); }
%new -I
- (void)cmd_today_view { NSLog(@"[TrollOpenJB] Today"); }

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)opts {
    if ([url.scheme isEqualToString:@"troll-openjb"] || [url.scheme isEqualToString:@"troj"]) {
        [self troll_openjb_handleURL:url];
        return YES;
    }
    return %orig;
}

%end

%ctor {
    NSLog(@"[TrollOpenJB] Loaded (%lu commands)", (unsigned long)[Commands count]);
}
