//
//  connectionC.m
//  MApBOxApp
//
//  Created by cprompt solutions on 11/25/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "connectionC.h"

@implementation connectionC
-(id)init{
    self = [super init];
    if(self){
        //for Internet Activity
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityHasChanged:) name:kReachabilityChangedNotification object:nil];
        self.internetReachability = [Reachability reachabilityForInternetConnection];
        [self.internetReachability startNotifier];
       
    }
    
    return self;
  
}
// Check Network Status
-(void) reachabilityHasChanged:(NSNotification *)notice
{
    // called after network status changes
    NetworkStatus internetStatus = [self.internetReachability currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:
        {
            _isReachable=NO;
            
            break;
        }
        case ReachableViaWiFi:
        {
            _isReachable=YES;
            
            break;
        }
        case ReachableViaWWAN:
        {
            _isReachable=YES;
            break;
        }
    }
}

-(BOOL)isNetworkReachable{
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus != NotReachable) {
        return YES;
    } else {
        return NO;
    }
}
@end
