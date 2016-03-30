//
//  AdvertisementVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/23/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertisementVC : UIViewController
- (IBAction)getPrintableAdvertiseButtonAction:(id)sender;

- (IBAction)menuButtonAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *menuBtn;

@end
