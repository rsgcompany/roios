//
//  AdvertiseDetailVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 2/19/15.
//  Copyright (c) 2015 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertiseDetailVC : UIViewController
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activIndicator;

@property (strong, nonatomic) IBOutlet UIWebView *advertiseWebView;
- (IBAction)pushBackAction:(id)sender;
@end
