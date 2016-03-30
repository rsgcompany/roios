//
//  DishCalendarVC.h
//  EnjoyFresh
//
//  Created by Siva  on 10/07/15.
//  Copyright (c) 2015 Right sourse global. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKCalendarView.h"
#import "MBProgressHUD.h"


@interface DishCalendarVC : UIViewController<MBProgressHUDDelegate>{
    MBProgressHUD *hud;

}
- (IBAction)backBtn_Calendar:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *datelabel;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
