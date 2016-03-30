//
//  ReportdetailVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 1/31/15.
//  Copyright (c) 2015 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportdetailVC : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *navTitleL;

@property (strong, nonatomic) IBOutlet UIView *salesReportContainer;
@property (strong, nonatomic) IBOutlet UILabel *DishNameL;
@property (strong, nonatomic) IBOutlet UILabel *RDishSold;
@property (strong, nonatomic) IBOutlet UILabel *RTotalSales;
@property (strong, nonatomic) IBOutlet UILabel *RFees;
@property (strong, nonatomic) IBOutlet UILabel *RTax;
@property (strong, nonatomic) IBOutlet UILabel *RNetRevenue;


@property (strong, nonatomic) IBOutlet UIView *paymentReportsContainer;
@property (strong, nonatomic) IBOutlet UILabel *paymentAmountL;
@property (strong, nonatomic) IBOutlet UILabel *paymentTypeL;
@property (strong, nonatomic) IBOutlet UILabel *amountpaymentL;
@property (strong, nonatomic) IBOutlet UILabel *creditCardFeesL;
@property (strong, nonatomic) IBOutlet UILabel *paymentTaxL;
@property (strong, nonatomic) IBOutlet UILabel *netAmountPaidL;




@property (strong, nonatomic) IBOutlet UIButton *menuBtn;

- (IBAction)menuButtonAction:(id)sender;
- (IBAction)pushBackDetailReport:(id)sender;

@property (nonatomic,retain) NSDictionary *DetailReportDic;
@property (nonatomic,retain) NSString *SelectedDate;
@property (nonatomic) NSInteger SelectedSegment;


@property (strong, nonatomic) IBOutlet UITableView *DetailReportTableV;





@end
