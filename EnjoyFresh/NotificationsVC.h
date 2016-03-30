//
//  NotificationsVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/23/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationsVC : UIViewController{
    NSArray *notificationArr;
    NSString *orderId;
    NSMutableDictionary *orderDetailDict;
}
@property (weak, nonatomic) IBOutlet UISwitch *EmailSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *FaxSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *TextSwitch;
- (IBAction)menuButtonAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *menuBtn;
@property (strong, nonatomic) IBOutlet UITableView *notificationTbl;

@property (strong, nonatomic) NSString *orderId;
@property (strong, nonatomic) NSMutableDictionary *orderDetailDict;

@end
