//
//  OrdersVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/7/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"




@interface OrdersVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchBarDelegate,MBProgressHUDDelegate>{
    
    UISearchBar *search_bar;
    UIView *searchLayer;
    
    
    UISegmentedControl *openPostSegment;
    UIView *SecondHeaderView;
    
    MBProgressHUD *hud;
    
    NSString *orderId;


}


@property (nonatomic, retain) NSString *isFrom;
@property (nonatomic, retain) NSString *notificationDict;
@property (nonatomic, retain) NSString *orderId;

@property (weak, nonatomic) IBOutlet UITableView *OrdersTable;
- (IBAction)PushBack:(id)sender;
- (IBAction)menuButtonAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *menuBtn;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

@end
