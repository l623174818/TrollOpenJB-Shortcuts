// ═══════════════════════════════════════════════════════════════════════════
//  TrollOpenJB - 快捷指令 URL Scheme 支持
//  版本：1.3.7-Shortcuts
//  日期：2026-10-30
// ═══════════════════════════════════════════════════════════════════════════

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

static NSArray *_CommandList = nil;
static NSArray *GetCommandList() {
    if (!_CommandList) {
        _CommandList = @[
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
    return _CommandList;
}

@interface SpringBoard (TrollOpenJBURLHandler)
- (void)trollOpenJB_handleURL:(NSURL *)url;
- (void)trollOpenJB_executeCommand:(NSString *)command params:(NSDictionary *)params;
@end

@implementation SpringBoard (TrollOpenJBURLHandler)

- (void)trollOpenJB_handleURL:(NSURL *)url {
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
                    params[[kv[0] stringByRemovingPercentEncoding]] = [kv[1] stringByRemovingPercentEncoding];
                }
            }
        }
        
        NSLog(@"[TrollOpenJB] 命令=%@ params=%@", command, params);
        if (command && command.length > 0) {
            [self trollOpenJB_executeCommand:command params:params];
        }
    } @catch (NSException *e) {
        NSLog(@"[TrollOpenJB] 异常：%@", [e description]);
    }
}

- (void)trollOpenJB_executeCommand:(NSString *)command params:(NSDictionary *)params {
    NSLog(@"[TrollOpenJB] 执行：%@", command);
    SEL selector = NSSelectorFromString(command);
    if ([self respondsToSelector:selector]) {
        ((void (*)(id, SEL))objc_msgSend)(self, selector);
    }
}

@end

@implementation SpringBoard (TrollOpenJBCommands)
- (void)cmd_toggle_wifi { NSLog(@"[TrollOpenJB] WiFi"); }
- (void)cmd_toggle_bluetooth { NSLog(@"[TrollOpenJB] 蓝牙"); }
- (void)cmd_toggle_airplane_mode { NSLog(@"[TrollOpenJB] 飞行模式"); }
- (void)cmd_toggle_cellular_data { NSLog(@"[TrollOpenJB] 蜂窝数据"); }
- (void)cmd_toggle_vpn { NSLog(@"[TrollOpenJB] VPN"); }
- (void)cmd_toggle_personal_hotspot { NSLog(@"[TrollOpenJB] 热点"); }
- (void)cmd_toggle_mute { NSLog(@"[TrollOpenJB] 静音"); }
- (void)cmd_toggle_silent_mode { NSLog(@"[TrollOpenJB] 静音模式"); }
- (void)cmd_take_screenshot { NSLog(@"[TrollOpenJB] 截图"); }
- (void)cmd_screen_record { NSLog(@"[TrollOpenJB] 录屏"); }
- (void)cmd_front_app_split { NSLog(@"[TrollOpenJB] 分屏"); }
- (void)cmd_respring { [[UIApplication sharedApplication] performSelector:@selector(_relaunch) withObject:nil afterDelay:0.5]; }
- (void)cmd_reboot_device { NSLog(@"[TrollOpenJB] 重启"); }
- (void)cmd_activate_siri { NSLog(@"[TrollOpenJB] Siri"); }
- (void)cmd_flashlight_toggle { NSLog(@"[TrollOpenJB] 手电筒"); }
- (void)cmd_low_power_mode { NSLog(@"[TrollOpenJB] 低电量"); }
- (void)cmd_orientation_lock { NSLog(@"[TrollOpenJB] 方向锁定"); }
- (void)cmd_auto_lock { NSLog(@"[TrollOpenJB] 自动锁定"); }
- (void)cmd_display_brightness { NSLog(@"[TrollOpenJB] 亮度"); }
- (void)cmd_display_dim { NSLog(@"[TrollOpenJB] 调暗"); }
- (void)cmd_volume_up { NSLog(@"[TrollOpenJB] 音量+"); }
- (void)cmd_volume_down { NSLog(@"[TrollOpenJB] 音量-"); }
- (void)cmd_speaker_volume_up { NSLog(@"[TrollOpenJB] 扬声器+"); }
- (void)cmd_speaker_volume_down { NSLog(@"[TrollOpenJB] 扬声器-"); }
- (void)cmd_media_play { NSLog(@"[TrollOpenJB] 播放"); }
- (void)cmd_media_pause { NSLog(@"[TrollOpenJB] 暂停"); }
- (void)cmd_media_next { NSLog(@"[TrollOpenJB] 下一曲"); }
- (void)cmd_media_previous { NSLog(@"[TrollOpenJB] 上一曲"); }
- (void)cmd_shuffle_enabled { NSLog(@"[TrollOpenJB] 随机播放"); }
- (void)cmd_repeat_mode { NSLog(@"[TrollOpenJB] 重复模式"); }
- (void)cmd_current_playing_info { NSLog(@"[TrollOpenJB] 播放信息"); }
- (void)cmd_current_album { NSLog(@"[TrollOpenJB] 专辑"); }
- (void)cmd_current_artist { NSLog(@"[TrollOpenJB] 艺术家"); }
- (void)cmd_current_track { NSLog(@"[TrollOpenJB] 曲目"); }
- (void)cmd_current_album_art { NSLog(@"[TrollOpenJB] 封面"); }
- (void)cmd_current_time { NSLog(@"[TrollOpenJB] 时间"); }
- (void)cmd_current_duration { NSLog(@"[TrollOpenJB] 时长"); }
- (void)cmd_is_playing { NSLog(@"[TrollOpenJB] 播放中"); }
- (void)cmd_media_seek { NSLog(@"[TrollOpenJB] 跳转"); }
- (void)cmd_play_at_time { NSLog(@"[TrollOpenJB] 定时播放"); }
- (void)cmd_set_shuffle { NSLog(@"[TrollOpenJB] 设置随机"); }
- (void)cmd_set_repeat_mode { NSLog(@"[TrollOpenJB] 设置重复"); }
- (void)cmd_skip_forward { NSLog(@"[TrollOpenJB] 前进"); }
- (void)cmd_skip_backward { NSLog(@"[TrollOpenJB] 后退"); }
- (void)cmd_change_playback_rate { NSLog(@"[TrollOpenJB] 速率"); }
- (void)cmd_set_volume { NSLog(@"[TrollOpenJB] 设置音量"); }
- (void)cmd_set_brightness { NSLog(@"[TrollOpenJB] 设置亮度"); }
- (void)cmd_lock_screen { NSLog(@"[TrollOpenJB] 锁屏"); }
- (void)cmd_go_to_home { NSLog(@"[TrollOpenJB] 主页"); }
- (void)cmd_control_center { NSLog(@"[TrollOpenJB] 控制中心"); }
- (void)cmd_notification_center { NSLog(@"[TrollOpenJB] 通知中心"); }
- (void)cmd_app_switcher { NSLog(@"[TrollOpenJB] 应用切换"); }
- (void)cmd_spotlight_search { NSLog(@"[TrollOpenJB] 搜索"); }
- (void)cmd_today_view { NSLog(@"[TrollOpenJB] 今天视图"); }
@end

%hook SpringBoard
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([url.scheme isEqualToString:@"troll-openjb"] || [url.scheme isEqualToString:@"troj"]) {
        [self trollOpenJB_handleURL:url];
        return YES;
    }
    return %orig;
}
%end

%ctor {
    NSLog(@"[TrollOpenJB] URL Scheme 模块已加载 (%lu commands)", (unsigned long)[GetCommandList count]);
}
