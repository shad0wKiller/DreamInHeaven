
#import "AppDelegate.h"
#import "DiNHusTugViewController.h"
#import "DinMyTugViewController.h"
#import "DiNTabBarController.h"
#import <Photos/Photos.h>
#import <UserNotifications/UserNotifications.h>
#import "TZImagePickerController.h"
#import "DiNTugsPhotoManager.h"
#import "DiNHotTugViewController.h"

@interface AppDelegate () <InsTagTabBarControllerDelegate>
@property (nonatomic, strong)UINavigationController *navigationController;
@property (nonatomic, strong)DiNTabBarController *tabBarController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    DiNHusTugViewController *firstVC = [DiNHusTugViewController new];
    DinMyTugViewController *secondeVC = [DinMyTugViewController new];
    DiNHotTugViewController *thirdVC = [DiNHotTugViewController new];
    
    DiNTabBarController *tabBarCtrl = [[DiNTabBarController alloc] init];
    tabBarCtrl.insTagTabBarDelegate = self;
    tabBarCtrl.view.backgroundColor = [UIColor whiteColor];
    
    tabBarCtrl.viewControllers = @[firstVC, secondeVC, thirdVC];
    
    // 设置窗口的跟视图控制器为分栏控制器
    UINavigationController *bootNav = [[UINavigationController alloc]initWithRootViewController:tabBarCtrl];
    self.window.rootViewController = bootNav;
    self.tabBarController = tabBarCtrl;
    self.navigationController = bootNav;
    
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"HasTags" image:[UIImage imageNamed:@"tab_hashtags"] selectedImage:[UIImage imageNamed:@"tab_hashtags_selected"]];
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"MyTags" image:[UIImage imageNamed:@"tab_mytags"] selectedImage:[UIImage imageNamed:@"tab_mytags_selected"]];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"HotTags" image:[UIImage imageNamed:@"tab_mytags"] selectedImage:[UIImage imageNamed:@"tab_mytags_selected"]];
        
    firstVC.tabBarItem = item1;
    secondeVC.tabBarItem = item2;
    thirdVC.tabBarItem = item3;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:-1];
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - push
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString* token = [[deviceToken description] stringByTrimmingCharactersInSet:
                       [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    [[NSUserDefaults standardUserDefaults] setValue:[token stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:@"push_token"];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
}

// 收到远程推送
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSLog(@"Userinfo %@",notification.request.content.userInfo);
    
    //功能：可设置是否在应用内弹出通知
    completionHandler(UNNotificationPresentationOptionBadge|
                      UNNotificationPresentationOptionSound|
                      UNNotificationPresentationOptionAlert);
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    NSLog(@"Userinfo %@",response.notification.request.content.userInfo);
    
}

#pragma mark - InsTagTabBarControllerDelegate

- (void)addButtonClick:(DiNTabBarController *)tabBarVC{
    TZImagePickerController *tz = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    tz.allowTakePicture = NO;
    tz.sortAscendingByModificationDate = NO;
    __weak __typeof(self)weakSelf = self;
    [tz setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSArray<NSDictionary *> *infos) {
        NSString *filePath = [infos[0] valueForKey:@"PHImageFileSandboxExtensionTokenKey"];
        NSURL *filePathURL = [infos[0] valueForKey:@"PHImageFileURLKey"];
        NSString *imagePath;
        if (filePathURL && filePathURL.absoluteString.length > 0) {
            //            imagePath = filePathURL.absoluteString;
            imagePath = filePath;
        }
        [[DiNTugsPhotoManager manager] savePhotoOld:photos[0]];
        //@"assets-library://asset/asset.JPG?id=87F9BBE9-5E09-4A94-81F4-1F5DE9B4EB2B&ext=JPG"
        DinMyTugViewController *selectTagVC = [[DinMyTugViewController alloc] initWith:imagePath];
        selectTagVC.title = @"Select tag to share";
        [weakSelf.navigationController pushViewController:selectTagVC animated:YES];
    }];
    [self.tabBarController presentViewController:tz animated:YES completion:nil];
}
@end
