//
//  OrderDetailVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/7/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParserHClass.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"




@interface OrderDetailVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,parserHDelegate,MBProgressHUDDelegate>{
    
    UISearchBar *search_bar;
    UIView* searchLayer;
    
    UISegmentedControl *Segment;
    UIView *SecondHeaderView;

    ParserHClass *webParser;
    MBProgressHUD *hud;

    NSString *isFrom;
}
@property (nonatomic,strong)NSString *isFrom;
@property (nonatomic,retain) NSMutableArray *tableCheckMarkAry;

@property (strong, nonatomic) IBOutlet UILabel *OrderDishNameLBl;


@property (weak, nonatomic) IBOutlet UITableView *DetailTable;

//@property (nonatomic,retain) NSArray *detailArray;
//@property (nonatomic,retain) NSString *detailOrderName;
//@property (nonatomic,retain) NSString *orderType;
//@property (nonatomic,retain) NSString *detailOrdeeDish_id;
//@property (nonatomic,retain) NSMutableDictionary *detailDictionary;

@property (nonatomic,retain) NSDictionary *IndetailDictionary;


@property (nonatomic,retain) NSMutableArray *WebIdsPendingArray;
@property (nonatomic,retain) NSMutableArray *WebIdsConfirmArray;
- (IBAction)PushBack:(id)sender;
- (IBAction)CheckMarkButtonAction:(id)sender;
- (IBAction)ConfirmCellButtonAction:(id)sender;
- (IBAction)MarkAllButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *markAllButton;
- (IBAction)ConfirmAllOrdersButtonAction:(id)sender;
- (IBAction)menuButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;

@property (nonatomic) BOOL markAllSelectedInSeg0;
@property (nonatomic) BOOL markAllSelectedInSeg1;

@property (strong, nonatomic) IBOutlet UIButton *ConfirmOrdersButton;

@end
