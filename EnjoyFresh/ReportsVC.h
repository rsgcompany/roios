//
//  ReportsVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 1/28/15.
//  Copyright (c) 2015 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportsVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *reportsTableV;
@property (strong, nonatomic) IBOutlet UIView *transparentBlackView;

@property (strong, nonatomic) IBOutlet UIView *datePickerView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePickerH;
- (IBAction)datePickerCancelAction:(id)sender;
- (IBAction)datePickerDoneAction:(id)sender;


@property (strong, nonatomic) IBOutlet UISegmentedControl *reportsSegmentC;
- (IBAction)reportsSegmentAction:(UISegmentedControl *)sender;

@property (strong, nonatomic) IBOutlet UILabel *fromDateL;
@property (strong, nonatomic) IBOutlet UILabel *toDateL;

- (IBAction)fromDateButtonAction:(id)sender;
- (IBAction)toDateButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;

- (IBAction)menuButtonAction:(id)sender;
- (IBAction)pushBackReports:(id)sender;
@end
