//
//  DishReviewsVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/20/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ParserHClass.h"
@interface DishReviewsVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchBarDelegate,parserHDelegate,MBProgressHUDDelegate>{
    
    UISearchBar *search_bar;
    UIView* searchLayer;
    UIView *SecondHeaderView;
    ParserHClass *webParser;
    MBProgressHUD *hud;
    NSString *reviewId;
}
@property (strong, nonatomic) NSString *fromNotificationDict;
@property (strong, nonatomic) NSString *reviewId;
@property (strong, nonatomic) IBOutlet UITableView *reviewDishTable;
- (IBAction)menuButtonAction:(id)sender;
- (IBAction)pushBackBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *menuBtn;

@end
