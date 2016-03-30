//
//  connectionC.h
//  MApBOxApp
//
//  Created by cprompt solutions on 11/25/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface connectionC : NSObject


@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) BOOL isReachable;

-(BOOL)isNetworkReachable;

@end
