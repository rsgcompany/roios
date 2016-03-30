//
//  AppDelegate.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/5/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end


@implementation AppDelegate

@synthesize deviceToken;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.window setBackgroundColor:[UIColor blackColor]];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    self.window.clipsToBounds = YES;
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
    self.window.frame =  CGRectMake(0,18,self.window.frame.size.width,self.window.frame.size.height-18);
    self.window.bounds = CGRectMake(0, 18, self.window.frame.size.width, self.window.frame.size.height);
    [UIApplication sharedApplication].statusBarHidden = NO;

    
    _connection = [[connectionC alloc]init];
    _CurrentOwnerDetails = [[OwnerProfileC alloc]init];
    
    
    
    _RegisterParameterDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    
    _openOrdersAry = [[NSMutableArray alloc]initWithCapacity:0];
    _pastOrdersAry = [[NSMutableArray alloc]initWithCapacity:0];
    
    _cuisineAry  = [[NSMutableArray alloc]initWithCapacity:0];
    _cuisineDic  = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    [self setUpStates:YES];
    
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"OwnerProfile"]) {
//        NSLog(@"ownerProf = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"OwnerProfile"]);
        [self ownerProfileUpDateWithResult:[[NSUserDefaults standardUserDefaults] objectForKey:@"OwnerProfile"]];
        
    }
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
     {
     [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
     
     [[UIApplication sharedApplication] registerForRemoteNotifications];
     }
     else
     {
     [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
     }

    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    NSDictionary *tmpDic = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    if (tmpDic != nil) {
        
        _pushFlag=YES;
    }
    else{
        _pushFlag=NO;
    }
    return YES;
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    self.deviceToken = [[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"Device Token= %@",self.deviceToken);
    
   
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    if ( application.applicationState == UIApplicationStateInactive || application.applicationState == UIApplicationStateBackground  )
    {
        //opened from a push notification when the app was on background
        NSDictionary *dict=[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginE_PProfile"];
        
        if(dict !=nil )
        {
            _nav=(UINavigationController *)self.window.rootViewController;
            NSArray *ar=_nav.viewControllers;
            UIViewController *vc=[ar lastObject];
            if ([vc isKindOfClass:[NotificationsVC class]]) {
                
            }
            else{
                [vc performSegueWithIdentifier:@"goToNotificationsView" sender:nil];
                _pushFlag=NO;
                
            }
        }
    }
 
    NSLog(@"user info:%@",userInfo);

}
#pragma mark - Remote notifications handling

-(void)handleRemoteNotifications:(NSDictionary *)userInfo
{
    NSLog(@"Remote: %@", userInfo);
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    NSLog(@"Push error %@",error);
    
}

////////////////////////////////////

-(void)setUpStates:(BOOL)mBool{
    
    _stateAry = [[NSMutableArray alloc]initWithCapacity:0];
    [_stateAry addObject:@"AL"];
    [_stateAry addObject:@"AK"];
    [_stateAry addObject:@"AZ"];
    [_stateAry addObject:@"AR"];
    [_stateAry addObject:@"CA"];
    [_stateAry addObject:@"CO"];
    [_stateAry addObject:@"CT"];
    [_stateAry addObject:@"DE"];
    [_stateAry addObject:@"DC"];
    [_stateAry addObject:@"FL"];
    [_stateAry addObject:@"GA"];
    [_stateAry addObject:@"HI"];
    [_stateAry addObject:@"ID"];
    [_stateAry addObject:@"IL"];
    [_stateAry addObject:@"IN"];
    [_stateAry addObject:@"IA"];
    [_stateAry addObject:@"KS"];
    [_stateAry addObject:@"KY"];
    [_stateAry addObject:@"LA"];
    [_stateAry addObject:@"ME"];
    [_stateAry addObject:@"MD"];
    [_stateAry addObject:@"MA"];
    [_stateAry addObject:@"MI"];
    [_stateAry addObject:@"MN"];
    [_stateAry addObject:@"MS"];
    [_stateAry addObject:@"MO"];
    [_stateAry addObject:@"MT"];
    [_stateAry addObject:@"NE"];
    [_stateAry addObject:@"NV"];
    [_stateAry addObject:@"NH"];
    [_stateAry addObject:@"NJ"];
    [_stateAry addObject:@"NM"];
    [_stateAry addObject:@"NY"];
    [_stateAry addObject:@"NC"];
    [_stateAry addObject:@"ND"];
    [_stateAry addObject:@"OH"];
    [_stateAry addObject:@"OK"];
    [_stateAry addObject:@"OR"];
    [_stateAry addObject:@"PA"];
    [_stateAry addObject:@"RI"];
    [_stateAry addObject:@"SC"];
    [_stateAry addObject:@"SD"];
    [_stateAry addObject:@"TN"];
    [_stateAry addObject:@"TX"];
    [_stateAry addObject:@"UT"];
    [_stateAry addObject:@"VT"];
    [_stateAry addObject:@"VA"];
    [_stateAry addObject:@"WA"];
    [_stateAry addObject:@"WV"];
    [_stateAry addObject:@"WI"];
    [_stateAry addObject:@"WY"];
    
    NSArray *aay = [[NSArray alloc]initWithArray:_stateAry];
    [_stateAry removeAllObjects];
    [_stateAry addObjectsFromArray:[aay sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
 
    
    /*
    _cityTaxAray=[[NSMutableArray alloc]initWithCapacity:0];
    float i = 0;
    while (i <= 5) {
        [_cityTaxAray addObject:[NSString stringWithFormat:@"%.2f",i]];
        i  = i+0.25f;
        NSLog(@"%f",i);
    }
    
    _stateTaxAray=[[NSMutableArray alloc]initWithCapacity:0];
    float j = 7;
    while (j <= 12) {
        [_stateTaxAray addObject:[NSString stringWithFormat:@"%.2f",j]];
        j  = j+0.25f;
        NSLog(@"%f",j);
    }
  
    */
    
}
-(void)setUpState_TaxAndCity_TaxWithDictionary:(NSDictionary *)mDictionary{
    _cityTaxAray=[[NSMutableArray alloc]initWithArray:[mDictionary valueForKey:@"city_taxes"]];
    _stateTaxAray=[[NSMutableArray alloc]initWithArray:[mDictionary valueForKey:@"state_taxes"]];
}

-(void)arrangeServiceInOrderWithResultArray:(NSArray *)myArray{
    
    [_openOrdersAry removeAllObjects];
    [_pastOrdersAry removeAllObjects];
    
    
    
    for (int f=0; f<myArray.count; f++) {
        NSDictionary *fDic=[myArray objectAtIndex:f];
        NSArray *Aarray=[fDic valueForKey:@"orders"];
        for (int a=0; a<Aarray.count; a++) {
            
            NSDictionary *dica=[Aarray objectAtIndex:a];
            
            NSString *dish_title = [fDic valueForKey:@"dish_title"];
            NSString *price = [fDic valueForKey:@"price"];
            NSDictionary *images = [fDic valueForKey:@"images"];
            NSString *dish_id = [fDic valueForKey:@"dish_id"];
            NSString *avail_by_date=[dica valueForKey:@"avail_by_date"];
            NSString *remaining_qty = [dica valueForKey:@"remaining_qty"];
            NSString *avail_qty = [dica valueForKey:@"avail_qty"];
            NSString *order_type = [dica valueForKey:@"order_type"];
            
            NSDictionary *dishDic;
            if ([NSJSONSerialization isValidJSONObject:[dica valueForKey:@"orders"]]) {
                dishDic=[NSDictionary dictionaryWithObject:[dica valueForKey:@"orders"] forKey:@"orders"];
            }else{
                dishDic=[NSDictionary dictionaryWithObject:@"1" forKey:@"orders"];
            }
                        
            
            NSMutableDictionary *DDic=[[NSMutableDictionary alloc]initWithCapacity:0];
            [DDic setObject:dish_title forKey:@"dish_title"];
            [DDic setObject:images forKey:@"images"];
            [DDic setObject:price forKey:@"price"];
            [DDic setObject:avail_by_date forKey:@"avail_by_date"];
            [DDic setObject:remaining_qty forKey:@"remaining_qty"];
            [DDic setObject:avail_qty forKey:@"avail_qty"];
            [DDic setObject:order_type forKey:@"order_type"];
            [DDic setObject:dish_id forKey:@"dish_id"];
            
            
            [DDic setObject:dishDic forKey:@"NextViewDic"];
            
            
            if ([[dica valueForKey:@"order_type"] isEqualToString:@"Open"]) {
                [_openOrdersAry addObject:DDic];
            }else{
                [_pastOrdersAry addObject:DDic];
            }
            
            
        }
    }
    NSSortDescriptor *availBydate=[[NSSortDescriptor alloc]initWithKey:@"avail_by_date" ascending:NO];
    NSArray *sortDescriptors = @[availBydate];
    _openOrdersAry=(NSMutableArray *)[[_openOrdersAry sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    _pastOrdersAry=(NSMutableArray *)[[_pastOrdersAry sortedArrayUsingDescriptors:sortDescriptors] mutableCopy] ;

}
-(void)ownerProfileUpDateWithResult:(NSMutableDictionary *)result{
    
    _numberOfcuisines = 0;
    _numberOfCustomCuisines = 0;
    
    
    
    
    [_RegisterParameterDic removeObjectForKey:@"RestaurentImageData"];
    [_RegisterParameterDic removeObjectForKey:@"TempararyCuisineDictionary"];

        
    
//    OwnerProfile
    
//   _CurrentOwnerDetails.owner_accessToken = @"{D6B0E705-78BB-676D-AD2E-21196BC84ECB}";
//    _CurrentOwnerDetails.owner_accessToken = @"{F034E6BA-A332-8BA7-D5A4-69932A5F2117}";
//   _CurrentOwnerDetails.owner_accessToken = @"{15367DDC-9F11-149D-1A03-C621BE051F2F}";
    
    
    @try {
        _CurrentOwnerDetails.owner_accessToken = [result valueForKey:@"accessToken"];
        NSLog(@"result = %@",[result valueForKey:@"accessToken"]);
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_user_id = [result  valueForKey:@"user_id"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_first_name = [result valueForKey:@"first_name"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_last_name = [result valueForKey:@"last_name"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_email = [result valueForKey:@"email"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_owns_restaurant_id = [result valueForKey:@"owns_restaurant_id"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_devicetoken = [result valueForKey:@"devicetoken"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_title = [result valueForKey:@"title"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_description = [result valueForKey:@"description"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_owner_name = [result valueForKey:@"owner_name"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_phone = [result valueForKey:@"phone"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_address = [result valueForKey:@"address"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_suite = [result valueForKey:@"suite"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_city = [result valueForKey:@"city"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_state = [result valueForKey:@"state"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_zip = [result valueForKey:@"zip"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_payment_method = [result valueForKey:@"payment_method"];
    }
    @catch (NSException *exception) {}
    
    @try {
        _CurrentOwnerDetails.owner_ach_name = [result valueForKey:@"ach_name"];
    }
    @catch (NSException *exception) {}
    
    @try {
        _CurrentOwnerDetails.owner_ach_account_number = [result valueForKey:@"ach_account_number"];
    }
    @catch (NSException *exception) {}
    
    @try {
        _CurrentOwnerDetails.owner_ach_routing_number = [result valueForKey:@"ach_routing_number"];
    }
    @catch (NSException *exception) {}
    
    @try {
        _CurrentOwnerDetails.owner_paypal_name = [result valueForKey:@"paypal_name"];
    }
    @catch (NSException *exception) {}
    
    @try {
        _CurrentOwnerDetails.owner_paypal_email = [result valueForKey:@"paypal_email"];
    }
    @catch (NSException *exception) {}
    
    @try {
        _CurrentOwnerDetails.owner_check_name = [result valueForKey:@"check_name"];
    }
    @catch (NSException *exception) {}
    
    @try {
        _CurrentOwnerDetails.owner_check_address = [result valueForKey:@"check_address"];
    }
    @catch (NSException *exception) {}
    
    @try {
        _CurrentOwnerDetails.owner_check_suite = [result valueForKey:@"check_suite"];
    }
    @catch (NSException *exception) {}
    
    @try {
        _CurrentOwnerDetails.owner_check_city = [result valueForKey:@"check_city"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_check_zip = [result valueForKey:@"check_zip"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_check_state = [result valueForKey:@"check_state"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_city_tax = [result valueForKey:@"city_tax"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_state_tax = [result valueForKey:@"state_tax"];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_website_url = [result valueForKey:@"website_url"];
    }
    @catch (NSException *exception) {}
    
    @try {
        _CurrentOwnerDetails.owner_gplus_url= [result valueForKey:@"gplus_url"];
    }
    @catch (NSException *exception) {}
    
    @try {
        _CurrentOwnerDetails.owner_facebook_url = [result valueForKey:@"facebook_url"];
    }
    @catch (NSException *exception) {}
    
    @try {
        _CurrentOwnerDetails.owner_twitter_url = [result valueForKey:@"twitter_url"];
    }
    @catch (NSException *exception) {}
    
    @try {
        _CurrentOwnerDetails.owner_urbanspoon_url = [result valueForKey:@"urbanspoon_url"];
    }
    @catch (NSException *exception) {}
    
    @try {
        _CurrentOwnerDetails.owner_yelp_url = [result valueForKey:@"yelp_url"];
    }
    @catch (NSException *exception) {}
    
    
    @try {
        _CurrentOwnerDetails.owner_email_ntfn = [[result valueForKey:@"email_ntfn"] boolValue];
    }
    @catch (NSException *exception) {}
    
    
    @try {
        _CurrentOwnerDetails.owner_txt_ntfn = [[result valueForKey:@"txt_ntfn"] boolValue];
    }
    @catch (NSException *exception) {}
    
    
    @try {
        _CurrentOwnerDetails.owner_fax_ntfn = [[result valueForKey:@"fax_ntfn"] boolValue];
    }
    @catch (NSException *exception) {}
    @try {
        _CurrentOwnerDetails.owner_dine_in = [[result valueForKey:@"dine_in"] boolValue];
    }
    @catch (NSException *exception) {}
    
    
    @try {
        _CurrentOwnerDetails.owner_pick_up = [[result valueForKey:@"pick_up"] boolValue];
    }
    @catch (NSException *exception) {}
    
    @try {
        _CurrentOwnerDetails.owner_pdf_advt = [result valueForKey:@"pdf_advt"];
    }
    @catch (NSException *exception) {}
    
    
    _CurrentOwnerDetails.owner_fax = [result valueForKey:@"fax"];
    
    if ([[result valueForKey:@"images"] count] > 0) {
        _CurrentOwnerDetails.owner_profileImagesArray = [result valueForKey:@"images"];
        
        for (NSDictionary *dic in [result valueForKey:@"images"]) {
            if ([[dic valueForKey:@"default"] integerValue] == 1) {
                _CurrentOwnerDetails.owner_ProfilimageDic = dic;
            }
        }
        
        
    }
    
    
    
    if ([[result valueForKey:@"cuisine_types"] count] > 0) {
        
        _CurrentOwnerDetails.owner_profileImagesArray = [result valueForKey:@"images"];
        NSMutableArray *aaryy = [[NSMutableArray alloc]initWithCapacity:0];
        
        for (NSDictionary *dic in [result valueForKey:@"cuisine_types"]) {
            if ([[dic valueForKey:@"is_custom"] integerValue] == 0) {
                [aaryy addObject:dic];
                _numberOfcuisines++;
            }else{
                _CurrentOwnerDetails.owner_customCuisineStg = [dic valueForKey:@"cuisine_title"];
                [aaryy addObject:dic];
                _numberOfCustomCuisines++;
            }
        }
        _CurrentOwnerDetails.owner_cuisineArray = [NSMutableArray arrayWithArray:aaryy];
        
    }

    
   //    [_CurrentOwnerDetails.owner_cuisineArray removeAllObjects];
//    [_CurrentOwnerDetails.owner_cuisineArray addObjectsFromArray:aaryy];
    
    
    
    
    
    NSLog(@"ownerCuisine Ary count= %lu",(unsigned long)_CurrentOwnerDetails.owner_cuisineArray.count);
    
    /*
    NSMutableArray *ary = [[NSMutableArray alloc]initWithCapacity:0];
   
    for (id value in [[result valueForKey:@"cuisine_types"] valueForKey:@"cuisine_title"]) {
//        if ([value isKindOfClass:[NSDictionary class]]) {
////            NSDictionary *dic = [NSJSONSerialization json]
//            NSArray *keys = [value allKeys];
//            for (NSString *key in keys) {
//                [ary addObject:[value valueForKey:key]];
//            }
//        }

        
        NSData *dataa2 =[(NSString *)value dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *dic12=[NSJSONSerialization JSONObjectWithData:dataa2 options:NSJSONReadingMutableContainers error:nil];

        NSLog(@"dic12 = %@",dic12);
        
        
        [ary addObject:(NSString *)value];
    }
    NSLog(@"Cuisine Array = %@",ary);
    
    */
    
}
-(void)clearOwnerProfileClass{
    
    _numberOfcuisines = 0;
    _numberOfCustomCuisines = 0;
    
    
    [_RegisterParameterDic  removeAllObjects];
    
    
    
    _CurrentOwnerDetails.owner_accessToken = @"";
    
    _CurrentOwnerDetails.owner_user_id = @"";
    _CurrentOwnerDetails.owner_first_name = @"";
    _CurrentOwnerDetails.owner_last_name = @"";
    _CurrentOwnerDetails.owner_email = @"";
    _CurrentOwnerDetails.owner_owns_restaurant_id = @"";
    _CurrentOwnerDetails.owner_devicetoken = @"";
    //    _CurrentOwnerDetails.owner_image = [result valueForKey:@"image"];
    _CurrentOwnerDetails.owner_title = @"";
    _CurrentOwnerDetails.owner_description = @"";
    _CurrentOwnerDetails.owner_owner_name = @"";
    _CurrentOwnerDetails.owner_phone = @"";
    _CurrentOwnerDetails.owner_address = @"";
    _CurrentOwnerDetails.owner_suite = @"";
    _CurrentOwnerDetails.owner_city = @"";
    _CurrentOwnerDetails.owner_state = @"";
    _CurrentOwnerDetails.owner_zip = @"";
    _CurrentOwnerDetails.owner_payment_method = @"";
    _CurrentOwnerDetails.owner_ach_name = @"";
    _CurrentOwnerDetails.owner_paypal_name = @"";
    _CurrentOwnerDetails.owner_paypal_email = @"";
    _CurrentOwnerDetails.owner_check_name = @"";
    _CurrentOwnerDetails.owner_check_address = @"";
    _CurrentOwnerDetails.owner_check_suite = @"";
    _CurrentOwnerDetails.owner_check_city = @"";
    _CurrentOwnerDetails.owner_check_zip = @"";
    _CurrentOwnerDetails.owner_check_state = @"";
    _CurrentOwnerDetails.owner_city_tax = @"";
    _CurrentOwnerDetails.owner_state_tax = @"";
    _CurrentOwnerDetails.owner_fax = @"";
    
    _CurrentOwnerDetails.owner_profileImagesArray = nil;
    _CurrentOwnerDetails.owner_ProfilimageDic=nil;
    _CurrentOwnerDetails.owner_cuisineArray = nil;
    
    _CurrentOwnerDetails.owner_pdf_advt = @"";

}

-(void)removeCusinesFromCusineArray:(NSMutableArray *)myArray WithComparingArray:(NSMutableArray *)comparingArray{
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
    [array addObjectsFromArray:myArray];
    
    NSLog(@"cusineAry Count = %lu",(unsigned long)_cuisineAry.count);
    // remove category cuisine array values
    for (NSDictionary *dic in myArray) {
        for (NSDictionary *dic1 in comparingArray) {
            if ([[dic valueForKey:@"title"] isEqualToString:[dic1 valueForKey:@"cuisine_title"]]) {
//                [myArray removeObject:dic];
                [array removeObject:dic];
            }
        }
        
    }
    [_cuisineAry removeAllObjects];
    [_cuisineAry addObjectsFromArray:array];
    
    NSLog(@"cusineAry Count1 = %lu",(unsigned long)_cuisineAry.count);


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
