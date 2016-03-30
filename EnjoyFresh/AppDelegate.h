//
//  AppDelegate.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/5/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionC.h"
#import "OwnerProfileC.h"
#import "NotificationsVC.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
}

@property (strong, nonatomic) UIWindow *window;



@property (strong, nonatomic)connectionC *connection;
@property (nonatomic, strong) OwnerProfileC *CurrentOwnerDetails;



@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *deviceToken;
@property (nonatomic, strong) NSString *ownerEmailId;
@property (nonatomic, strong) NSString *ownerPassword;


@property (nonatomic, retain) NSMutableDictionary *RegisterParameterDic;


@property (nonatomic, retain) NSMutableArray *openOrdersAry;
@property (nonatomic, retain) NSMutableArray *pastOrdersAry;


@property (nonatomic, retain) NSMutableArray *stateAry;
@property (nonatomic, retain) NSMutableArray *cityTaxAray;
@property (nonatomic, retain) NSMutableArray *stateTaxAray;
@property (nonatomic, retain) NSMutableArray *cuisineAry;
@property (nonatomic, retain) NSMutableDictionary *cuisineDic;


@property (nonatomic) NSInteger numberOfcuisines;
@property (nonatomic) NSInteger numberOfCustomCuisines;

@property(assign,nonatomic)BOOL pushFlag;
@property(strong,nonatomic)UINavigationController *nav;


-(void)setUpState_TaxAndCity_TaxWithDictionary:(NSDictionary *)mDictionary;

-(void)arrangeServiceInOrderWithResultArray:(NSArray *)myArray;
-(void)ownerProfileUpDateWithResult:(NSDictionary *)result;
-(void)clearOwnerProfileClass;
-(void)removeCusinesFromCusineArray:(NSMutableArray *)myArray WithComparingArray:(NSMutableArray *)comparingArray;


@end

