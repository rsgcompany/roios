//
//  DishesVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/19/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface DishesVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchBarDelegate,MBProgressHUDDelegate>{
    
    UISearchBar *search_bar;
    UIView* searchLayer;
    UISegmentedControl *openPostSegment;
    UIView *SecondHeaderView;
    MBProgressHUD *hud;
    
}
@property(assign,nonatomic) BOOL fromNotifications;

@property (nonatomic,retain) NSMutableArray *dishesAvaliableArray;
@property (nonatomic,retain) NSMutableArray *dishesUnAvaliableArray;
@property (strong, nonatomic) IBOutlet UITableView *DishesTable;
- (IBAction)menuButtonAction:(id)sender;
- (IBAction)pushBackBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;

@end
