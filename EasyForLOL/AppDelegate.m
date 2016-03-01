//
//  AppDelegate.m
//  EasyForLOL
//
//  Created by qingyun on 16/1/23.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "QYTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //创建窗口
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window = window;
    window.hidden = NO;
    window.backgroundColor = [UIColor whiteColor];
    
    /*
     //设置tabBar为跟视图控制器
     QYTabBarController *tabBarController = [[QYTabBarController alloc] init];
     UITabBar *tabBar = tabBarController.tabBar;
     [tabBar setTintColor:[UIColor colorWithRed:243.0/255.0 green:123.0/255.0 blue:30.0/255.0 alpha:1.0]];
     
     window.rootViewController = tabBarController;
     */
    window.rootViewController = [self instantiateRootViewController];
    return YES;
}


-(UIViewController *)instantiateRootViewController
{
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userAppear = [user objectForKey:@"appear"];
    
    if ([userAppear isEqualToString:currentVersion]) {
        
        
        QYTabBarController *tabBarController = [[QYTabBarController alloc] init];
        UITabBar *tabBar = tabBarController.tabBar;
        [tabBar setTintColor:[UIColor colorWithRed:243.0/255.0 green:123.0/255.0 blue:30.0/255.0 alpha:1.0]];
        
        self.window.rootViewController = tabBarController;
        return tabBarController;
        
        //        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //        UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"second"];
        //        return vc;
    }else{
        /*
         UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
         
         UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
         
         }];
         
         UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
         
         }];
         [controller addAction:cancelAction];
         [controller addAction:okAction];
         */
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }
        
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"first"];
        return vc;
    }
    return nil;
}

-(void)guideEnd
{
    QYTabBarController *tabBarController = [[QYTabBarController alloc] init];
    UITabBar *tabBar = tabBarController.tabBar;
    [tabBar setTintColor:[UIColor colorWithRed:243.0/255.0 green:123.0/255.0 blue:30.0/255.0 alpha:1.0]];
    
    self.window.rootViewController = tabBarController;
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"appear"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
