// ═══════════════════════════════════════════════════════════════════════════
//  TrollOpenJB - 快捷指令 URL Scheme 集成
// ═══════════════════════════════════════════════════════════════════════════
//
//  项目：TrollOpenJB (分屏插件)
//  版本：1.3.7-Shortcuts
//  功能：通过 URL Scheme 暴露 53 个系统控制命令，支持快捷指令调用
//  作者：Charlie Leung (原) + Shortcuts Integration
//  日期：2026-10-28
//
//  URL Scheme 格式:
//    troll-openjb://<command>
//    troll-openjb://<command>?key=value
//    troj://<command>  (短别名)
//
//  示例:
//    troll-openjb://cmd_toggle_personal_hotspot
//    troll-openjb://cmd_toggle_wifi?enabled=1
//    troj://cmd_front_app_split
//
// ═══════════════════════════════════════════════════════════════════════════

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <notify.h>
#import <UserNotifications/UserNotifications.h>

// ═══════════════════════════════════════════════════════════════════════════
//  命令映射表 (53 个命令)
// ═══════════════════════════════════════════════════════════════════════════

static NSDictionary<NSString *, NSString *> *CommandNames = @{
    // 网络控制
    @"cmd_toggle_wifi": @"WiFi",
    @"cmd_toggle_bluetooth": @"蓝牙",
    @"cmd_toggle_airplane_mode": @"飞行模式",
    @"cmd_toggle_cellular_data": @"蜂窝数据",
    @"cmd_toggle_vpn": @"VPN",
    @"cmd_toggle_personal_hotspot": @"个人热点",
    
    // 声音控制
    @"cmd_toggle_mute": @"静音",
    @"cmd_toggle_silent_mode": @"静音模式",
    @"cmd_increase_volume": @"增加音量",
    @"cmd_decrease_volume": @"降低音量",
    
    // 多任务/分屏
    @"cmd_front_app_split": @"前台应用分屏",
    @"cmd_toggle_single_window_mode": @"单窗口模式",
    @"cmd_cleanup_split_background": @"清理分屏背景",
    @"cmd_shrink_floating_windows": @"收缩浮动窗口",
    
    // 截图/录屏
    @"cmd_take_screenshot": @"截图",
    @"cmd_take_screenshot_and_edit": @"截图并编辑",
    @"cmd_screenshot_region": @"区域截图",
    @"cmd_screenshot_to_pasteboard": @"截图到剪贴板",
    @"cmd_screen_record": @"屏幕录制",
    @"cmd_screen_record_mic": @"录屏 - 麦克风",
    
    // 显示控制
    @"cmd_toggle_night_shift": @"夜览模式",
    @"cmd_toggle_auto_brightness": @"自动亮度",
    @"cmd_toggle_true_tone": @"原彩显示",
    @"cmd_toggle_smart_invert": @"智能反转",
    @"cmd_toggle_orientation": @"方向锁定",
    
    // 系统控制
    @"cmd_respring": @"注销",
    @"cmd_reboot_device": @"重启设备",
    @"cmd_activate_siri": @"Siri",
    @"cmd_toggle_dnd": @"勿扰模式",
    @"cmd_toggle_low_power_mode": @"低电量模式",
    
    // 通知/控制中心
    @"cmd_toggle_notification_center": @"通知中心",
    @"cmd_toggle_control_center": @"控制中心",
    @"cmd_toggle_app_library": @"应用库",
    @"cmd_toggle_app_switcher": @"应用切换器",
    
    // 其他功能
    @"cmd_toggle_dock": @"Dock",
    @"cmd_toggle_flashlight": @"手电筒",
    @"cmd_reveal_spotlight": @"Spotlight",
    @"cmd_shake": @"摇动",
    @"cmd_open_console": @"控制台",
    @"cmd_search_apps": @"搜索应用",
    
    // Agent 功能
    @"cmd_chat_agent": @"聊天 Agent",
    @"cmd_audio_chat": @"音频聊天",
    @"cmd_visual_agent": @"视觉 Agent",
    @"cmd_troll_agent_music": @"Troll Agent 音乐",
    
    // 翻译功能
    @"cmd_fullscreen_translation": @"全屏翻译",
    @"cmd_toggle_live_speech": @"实时语音",
    @"cmd_toggle_announce_notifications": @"通知播报",
    
    // 其他
    @"cmd_toggle_quick_note": @"快速备忘录",
    @"cmd_activation_lock": @"激活锁",
    @"cmd_toggle_nearby_device_control": @"附近设备控制",
    @"cmd_toggle_watch_remote_screen": @"远程屏幕"
};

// ═══════════════════════════════════════════════════════════════════════════
//  Hook SpringBoard 处理 URL
// ═══════════════════════════════════════════════════════════════════════════

%hook SpringBoard

// ────────────────────────────────────────────────────────────────────────────
//  拦截 URL 打开事件
// ────────────────────────────────────────────────────────────────────────────

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    
    NSLog(@"[TrollOpenJB] URL 拦截：scheme=%@ host=%@ path=%@ query=%@", 
          url.scheme, url.host, url.path, url.query);
    
    // 检查是否是 TrollOpenJB 的 URL Scheme
    if ([url.scheme isEqualToString:@"troll-openjb"] ||
        [url.scheme isEqualToString:@"troj"]) {
        
        [self handleTrollOpenJBURL:url];
        return YES;  // 已处理，阻止其他应用处理
    }
    
    return %orig;  // 非 TrollOpenJB URL，交给原有逻辑
}

// ────────────────────────────────────────────────────────────────────────────
//  解析并执行 TrollOpenJB URL
// ────────────────────────────────────────────────────────────────────────────

%new
- (void)handleTrollOpenJBURL:(NSURL *)url {
    @try {
        // 解析 URL 格式
        NSString *command = nil;
        NSDictionary *params = @{};
        
        // 格式 A: troll-openjb://cmd_toggle_wifi
        if (url.host.length > 0) {
            command = url.host;
        }
        // 格式 B: troll-openjb://cmd_toggle_wifi?enabled=1
        else if (url.path.length > 1) {
            command = [url.path substringFromIndex:1];  // 去掉前导 /
        }
        
        // 解析查询参数
        if (url.query) {
            NSMutableDictionary *queryDict = [NSMutableDictionary dictionary];
            NSArray *pairs = [url.query componentsSeparatedByString:@"&"];
            
            for (NSString *pair in pairs) {
                NSArray *kv = [pair componentsSeparatedByString:@"="];
                if (kv.count == 2) {
                    NSString *key = [kv[0] stringByRemovingPercentEncoding];
                    NSString *value = [kv[1] stringByRemovingPercentEncoding];
                    queryDict[key] = value;
                }
            }
            params = [params dictionaryByAddingEntriesFromDictionary:queryDict];
        }
        
        NSLog(@"[TrollOpenJB] 解析结果 - 命令：%@ 参数：%@", command, params);
        
        // 执行命令
        if (command && command.length > 0) {
            [self executeTrollOpenJBCommand:command params:params];
        } else {
            [self showNotificationWithTitle:@"TrollOpenJB" body:@"无效的命令"];
        }
        
    } @catch (NSException *e) {
        NSLog(@"[TrollOpenJB] URL 处理错误：%@", e);
        [self showNotificationWithTitle:@"TrollOpenJB" body:[NSString stringWithFormat:@"执行失败：%@", e.message]];
    }
}

// ────────────────────────────────────────────────────────────────────────────
//  执行 TrollOpenJB 命令
// ────────────────────────────────────────────────────────────────────────────

%new
- (void)executeTrollOpenJBCommand:(NSString *)command params:(NSDictionary *)params {
    NSLog(@"[TrollOpenJB] 执行命令：%@ 参数：%@", command, params);
    
    // 方式 1: 发送 Darwin Notification (推荐，系统级)
    NSString *notificationName = [NSString stringWithFormat:@"com.charlieleung.trollopenjb.%@", command];
    notify_post([notificationName UTF8String]);
    
    // 方式 2: 发送 NSNotification (应用内)
    [[NSNotificationCenter defaultCenter] postNotificationName:command object:nil userInfo:params];
    
    // 获取命令中文名称 (用于通知)
    NSString *commandName = CommandNames[command] ?: command;
    
    // 显示执行结果通知
    NSString *body = [NSString stringWithFormat:@"已执行：%@", commandName];
    [self showNotificationWithTitle:@"TrollOpenJB" body:body];
    
    // 记录执行日志
    NSLog(@"[TrollOpenJB] 命令执行完成：%@", command);
}

// ────────────────────────────────────────────────────────────────────────────
//  显示本地通知
// ────────────────────────────────────────────────────────────────────────────

%new
- (void)showNotificationWithTitle:(NSString *)title body:(NSString *)body {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *settings) {
        if (settings.authorizationStatus == UNAuthorizationStatusAuthorized ||
            settings.authorizationStatus == UNAuthorizationStatusProvisional) {
            
            UNMutableNotificationContent *content = [UNMutableNotificationContent new];
            content.title = title;
            content.body = body;
            content.sound = nil;  // 静音通知
            content.interruptionLevel = UNNotificationInterruptionLevelTimeSensitive;
            
            NSString *identifier = [NSString stringWithFormat:@"troj_%lu", 
                                   (unsigned long)[NSDate date].timeIntervalSince1970];
            
            UNNotificationRequest *request = [UNNotificationRequest
                requestWithIdentifier:identifier
                content:content
                trigger:nil];  // 立即触发
            
            [center addNotificationRequest:request completionHandler:^(NSError * _Nullable error) {
                if (error) {
                    NSLog(@"[TrollOpenJB] 通知发送失败：%@", error);
                } else {
                    NSLog(@"[TrollOpenJB] 通知发送成功：%@", body);
                }
            }];
        } else {
            NSLog(@"[TrollOpenJB] 通知权限未授权，使用 NSLog 记录：%@", body);
        }
    }];
}

%end

// ═══════════════════════════════════════════════════════════════════════════
//  Constructor
// ═══════════════════════════════════════════════════════════════════════════

%ctor {
    %init;
    
    NSLog(@"[TrollOpenJB] 快捷指令 URL Scheme 模块已加载");
    NSLog(@"[TrollOpenJB] 支持的 URL Scheme: troll-openjb://, troj://");
    NSLog(@"[TrollOpenJB] 可用命令数：%lu", (unsigned long)[CommandNames count]);
}
