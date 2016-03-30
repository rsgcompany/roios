//
//  OrderTypesVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/23/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTypesVC : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *DineInSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *PickupSwitch;

@property (strong, nonatomic) IBOutlet UIButton *menuBtn;

@end
