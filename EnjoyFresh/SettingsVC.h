//
//  SettingsVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/6/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsVC : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableV;
- (IBAction)BackBtnClicked:(id)sender;
- (IBAction)menuDropDownButtonBlock:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;


@end
