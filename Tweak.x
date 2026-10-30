// ═══════════════════════════════════════════════════════════════════════════
//  TrollOpenJB - 快捷指令 URL Scheme 支持
//  版本：1.3.7-Shortcuts
//  日期：2026-10-30
// ═══════════════════════════════════════════════════════════════════════════

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// 53 个快捷指令命令列表
static NSArray *_CommandNames = nil;
static NSArray *CommandNames() {
    if (!_CommandNames) {
        _CommandNames = @[
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
    return _CommandNames;
}

@interface SBApplication : NSObject
- (void)suspend;
@end

@interface SpringBoard : UIApplication
@end

%hook SpringBoard

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([url.scheme isEqualToString:@"troll-openjb"] ||
        [url.scheme isEqualToString:@"troj"]) {
        [self handleTrollOpenJBURL:url];
        return YES;
    }
    return %orig;
}

%new
- (void)handleTrollOpenJBURL:(NSURL *)url {
    @try {
        NSString *command = nil;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        if (url.host.length > 0) {
            command = url.host;
        } else if (url.path.length > 1) {
            command = [url.path substringFromIndex:1];
        }
        
        if (url.query) {
            NSArray *pairs = [url.query componentsSeparatedByString:@"&"];
            for (NSString *pair in pairs) {
                NSArray *kv = [pair componentsSeparatedByString:@"="];
                if (kv.count == 2) {
                    NSString *key = [kv[0] stringByRemovingPercentEncoding];
                    NSString *value = [kv[1] stringByRemovingPercentEncoding];
                    params[key] = value;
                }
            }
        }
        
        NSLog(@"[TrollOpenJB] 命令=%@ params=%@", command, params);
        
        if (command && command.length > 0) {
            [self executeTrollOpenJBCommand:command params:params];
        }
    } @catch (NSException *e) {
        NSLog(@"[TrollOpenJB] 异常：%@", [e description]);
    }
}

%new
- (void)executeTrollOpenJBCommand:(NSString *)command params:(NSDictionary *)params {
    NSLog(@"[TrollOpenJB] 执行：%@", command);
    
    SEL selector = NSSelectorFromString(command);
    if ([self respondsToSelector:selector]) {
        ((void (*)(id, SEL))objc_msgSend)(self, selector);
    }
}

%end

@implementation SpringBoard (TrollOpenJBShortcuts)
#define CMD(name) - (void)name { NSLog(@"[TrollOpenJB] %@", NSStringFromSelector(_cmd)); }

CMD(cmd_toggle_wifi)
CMD(cmd_toggle_bluetooth)
CMD(cmd_toggle_airplane_mode)
CMD(cmd_toggle_cellular_data)
CMD(cmd_toggle_vpn)
CMD(cmd_toggle_personal_hotspot)
CMD(cmd_toggle_mute)
CMD(cmd_toggle_silent_mode)
CMD(cmd_take_screenshot)
CMD(cmd_screen_record)
CMD(cmd_front_app_split)
CMD(cmd_respring)
CMD(cmd_reboot_device)
CMD(cmd_activate_siri)
CMD(cmd_flashlight_toggle)
CMD(cmd_low_power_mode)
CMD(cmd_orientation_lock)
CMD(cmd_auto_lock)
CMD(cmd_display_brightness)
CMD(cmd_display_dim)
CMD(cmd_volume_up)
CMD(cmd_volume_down)
CMD(cmd_speaker_volume_up)
CMD(cmd_speaker_volume_down)
CMD(cmd_media_play)
CMD(cmd_media_pause)
CMD(cmd_media_next)
CMD(cmd_media_previous)
CMD(cmd_shuffle_enabled)
CMD(cmd_repeat_mode)
CMD(cmd_current_playing_info)
CMD(cmd_current_album)
CMD(cmd_current_artist)
CMD(cmd_current_track)
CMD(cmd_current_album_art)
CMD(cmd_current_time)
CMD(cmd_current_duration)
CMD(cmd_is_playing)
CMD(cmd_media_seek)
CMD(cmd_play_at_time)
CMD(cmd_set_shuffle)
CMD(cmd_set_repeat_mode)
CMD(cmd_skip_forward)
CMD(cmd_skip_backward)
CMD(cmd_change_playback_rate)
CMD(cmd_set_volume)
CMD(cmd_set_brightness)
CMD(cmd_lock_screen)
CMD(cmd_go_to_home)
CMD(cmd_control_center)
CMD(cmd_notification_center)
CMD(cmd_app_switcher)
CMD(cmd_spotlight_search)
CMD(cmd_today_view)

#undef CMD
@end

%ctor {
    NSLog(@"[TrollOpenJB] URL Scheme 模块已加载 (@%lu commands)", (unsigned long)[CommandNames count]);
}
