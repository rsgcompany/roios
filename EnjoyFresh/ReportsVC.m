//
//  ReportsVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 1/28/15.
//  Copyright (c) 2015 VrindaTech. All rights reserved.
//

#import "ReportsVC.h"
#import "Global.h"
#import "TableViewCellH.h"
#import "ParserHClass.h"
#import "MBProgressHUD.h"
#import "GlobalMethods.h"
#import "CustomTableViewH.h"
#import "ReportdetailVC.h"


@interface ReportsVC ()<parserHDelegate,MBProgressHUDDelegate,CustomTableViewHDelegate>{
    ParserHClass *webParser;
    MBProgressHUD *hud;
    CustomTableViewH *dropDownV;

    NSArray *tableArray;
    
    NSDate *fromdateD,*toDateD;
    
    NSDictionary *IndexDic;
    
    
}
@property (nonatomic,retain) NSArray *salesArray;
@property (nonatomic,retain) NSArray *paymentsArray;


@end

@implementation ReportsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpDatePicker:YES];
    [self setUpGestures:YES];
    [self setUpSegmentController:YES];
    
//    [_datePickerH setTimeZone:[NSTimeZone timeZoneWithName: @"PST"]];
    
    

    
    fromdateD = [self OneWeekBackDateFromDate:[NSDate date]];
    toDateD = [NSDate date];
    _fromDateL.text = [NSString stringWithFormat:@"FROM: %@ >",[self dateToStringConvertionForLabel:[self OneWeekBackDateFromDate:[NSDate date]]]];
    _toDateL.text = [NSString stringWithFormat:@"TO: %@ >",[self dateToStringConvertionForLabel:[NSDate date]]];
    
    [_datePickerH setMaximumDate:[NSDate date]];
    
    
}
-(void)setUpallFonts{
    
}
-(void)viewDidAppear:(BOOL)animated{
    [self PrepareServices:YES];

}
-(void)viewWillAppear:(BOOL)animated{
    [_reportsTableV deselectRowAtIndexPath:[_reportsTableV indexPathForSelectedRow] animated:YES];

}
-(NSDate *)OneWeekBackDateFromDate:(NSDate *)mDate{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:-7];
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:mDate options:0];
}


-(void)setUpDatePicker:(BOOL)myBool{
    _datePickerView.frame = CGRectMake(0, self.view.bounds.size.height, _datePickerView.bounds.size.width, _datePickerView.bounds.size.height);
    [self.view addSubview:_datePickerView];
}
-(void)setUpGestures:(BOOL)myBool{
    UITapGestureRecognizer *TransparectBlackVG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(datePickerCancelAction:)];
    [_transparentBlackView addGestureRecognizer:TransparectBlackVG];
}
-(void)setUpSegmentController:(BOOL)myBool{
    _reportsSegmentC.selectedSegmentIndex = 0;
    [GlobalMethods changeSegmentContrilTintColor:_reportsSegmentC];
}
-(void)datePickerShows:(BOOL)myBool{
    [self.view endEditing:YES];
    
    if (!myBool) {
        [UIView animateWithDuration:0.3f animations:^{
            _transparentBlackView.hidden = YES;
            _datePickerView.frame = CGRectMake(0, self.view.bounds.size.height, _datePickerView.bounds.size.width, _datePickerView.bounds.size.height);
        } completion:nil];
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            _transparentBlackView.hidden = NO;
            _datePickerView.frame = CGRectMake(0, self.view.bounds.size.height-_datePickerView.bounds.size.height, _datePickerView.bounds.size.width, _datePickerView.bounds.size.height);
        } completion:nil];
    }
    
}



#pragma mark
#pragma mark - TableviewDataSource Delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return tableArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    for (int i=0; i<tableArray.count; i++) {
//        if (section == i) {
        return [[[tableArray objectAtIndex:section] valueForKey:@"dishes"] count];
//        }
//    }
//    
//    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdent = @"reviewCellIdentifier";
    TableViewCellH *cell = (TableViewCellH *)[tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
    
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[[[tableArray objectAtIndex:indexPath.section] valueForKey:@"dishes"] objectAtIndex:indexPath.row]];
    
    for (NSString * key in [dict allKeys]){
        if ([[dict objectForKey:key] isKindOfClass:[NSNull class]])
            [dict setObject:@"" forKey:key];
    }
    IndexDic = dict;

    
  

    if (_reportsSegmentC.selectedSegmentIndex == 0) {
        
        cell.dishPaymentTypeL.hidden = YES;
        cell.dishPaymentAmountL.hidden = YES;
        cell.dishNameC.hidden = NO;

        
        cell.dishNameC.text = [NSString stringWithFormat:@"%@",[IndexDic  valueForKey:@"dish_title"]];
        cell.dishQuantityC.text = [NSString stringWithFormat:@"%@",[[IndexDic valueForKey:@"orders"]valueForKey:@"dishes_sold"]];
        cell.dishTaxC.text = [GlobalMethods appendDollerToString:[[IndexDic valueForKey:@"orders"]valueForKey:@"total_taxes"]];

        if ([[IndexDic valueForKey:@"orders"] valueForKey:@"total_sales"] != nil) {
            cell.dishTotalSalesC.text = [GlobalMethods appendDollerToString:[[IndexDic valueForKey:@"orders"] valueForKey:@"total_sales"]];
        }else {
            cell.dishTotalSalesC.text = @"";
        }

        cell.dishNetRevenue.text = [GlobalMethods appendDollerToString:[[IndexDic valueForKey:@"orders"]valueForKey:@"net_revenue"]] ;
        cell.dishNetRevenue.textColor = [UIColor darkGrayColor];
    }else{
        cell.dishNameC.hidden = YES;
        cell.dishPaymentTypeL.hidden = NO;
        cell.dishPaymentAmountL.hidden = NO;

        
        cell.dishPaymentAmountL.text = [GlobalMethods appendDollerToString:[[[IndexDic valueForKey:@"orders"] valueForKey:@"pmt_amt"] lastObject]];
        cell.dishPaymentTypeL.text = [NSString stringWithFormat:@"%@",[[[IndexDic valueForKey:@"orders"] valueForKey:@"pmt_type"] lastObject]];
        cell.dishQuantityC.text = [GlobalMethods appendDollerToString:[IndexDic valueForKey:@"price"]];
        cell.dishTaxC.text = [GlobalMethods appendDollerToString:[[[IndexDic valueForKey:@"orders"] valueForKey:@"total_fees"] lastObject]];
        cell.dishTotalSalesC.text = [GlobalMethods appendDollerToString:[[[IndexDic valueForKey:@"orders"] valueForKey:@"total_taxes"]lastObject]];
        cell.dishNetRevenue.text = [GlobalMethods appendDollerToString:[[[IndexDic valueForKey:@"orders"] valueForKey:@"net_paid"]lastObject]];
        cell.dishNetRevenue.textColor = [UIColor redColor];


    }
    
    return cell;
}
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *cellIdent = @"reviewSectionIdentifier";
    TableViewCellH *cell = (TableViewCellH *)[tableView dequeueReusableCellWithIdentifier:cellIdent];
    
    if (_reportsSegmentC.selectedSegmentIndex == 0) {
        cell.sectionNameC.text = [GlobalMethods dateFormettForCell:[[tableArray objectAtIndex:section] valueForKey:@"order_by_date"]];
        cell.sectionPaymentContainerV.hidden = YES;
        
    }else{
        cell.sectionNameC.text = [GlobalMethods dateFormettForCell:[[tableArray objectAtIndex:section] valueForKey:@"paid_date"]];
        cell.sectionContainerV.hidden = YES;
    }
    

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}


- (IBAction)datePickerCancelAction:(id)sender {
    [self.view endEditing:YES];
    [self datePickerShows:NO];
}

- (IBAction)datePickerDoneAction:(id)sender {
    [self showCustomActivityIndicatorInReports:YES];

    [self.view endEditing:YES];
    if (_datePickerH.tag == 12001) {
        fromdateD = _datePickerH.date;
        _fromDateL.text = [NSString stringWithFormat:@"FROM : %@ >",[self dateToStringConvertionForLabel:_datePickerH.date]];
    }else{
        toDateD = _datePickerH.date;
        _toDateL.text = [NSString stringWithFormat:@"TO : %@ >",[self dateToStringConvertionForLabel:_datePickerH.date]];
    }
    [self datePickerShows:NO];
    
    if ([self checkValidToFromDates]) {
        [self PrepareServices:YES];
    }
}
-(BOOL)checkValidToFromDates{
    
    [self showCustomActivityIndicatorInReports:NO];

    if ([toDateD compare:fromdateD] == NSOrderedAscending) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"TO Date cannot be less than FROM Date"];
        return NO;
    }else{
//        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Dates Are Propre"];
        return YES;
    }
}
- (IBAction)fromDateButtonAction:(id)sender {
    [self.view endEditing:YES];
    _datePickerH.tag = 12001;
    [self datePickerShows:YES];
    
}

- (IBAction)toDateButtonAction:(id)sender {
    [self.view endEditing:YES];
    _datePickerH.tag = 12002;
    [self datePickerShows:YES];
    
}



-(NSString *)dateToStringConvertionForLabel:(NSDate *)myDate{
    NSDateFormatter *formD = [[NSDateFormatter alloc]init];
    [formD setDateFormat:@"MM/dd/yyyy"];
    return [formD stringFromDate:myDate];
}
-(NSString *)dateToStringConvertionForServer:(NSDate *)myDate{
    NSDateFormatter *formD = [[NSDateFormatter alloc]init];
    [formD setDateFormat:@"yyyy-MM-dd"];
    return [formD stringFromDate:myDate];
}

-(void)PrepareServices:(BOOL)mBool{
    tableArray = nil;
    [self.reportsTableV reloadData];
    [self showCustomActivityIndicatorInReports:YES];
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    
    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    
//    [paramDict setObject:@"{D2FC784F-00C0-1EC3-0417-4E360C04F510}" forKey:@"accessToken"];
//    NSString *fromDateS = @"2015-01-01";
//    NSString *toDateS = @"2015-01-29";
    
    
    [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
    NSString *fromDateS = [self dateToStringConvertionForServer:fromdateD];
    NSString *toDateS = [self dateToStringConvertionForServer:toDateD];
    
    [paramDict setObject:fromDateS forKey:@"fromDate"];
    [paramDict setObject:toDateS forKey:@"toDate"];
    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"reports"];

};



#pragma mark
#pragma mark - ActivityIndicator
-(void)showCustomActivityIndicatorInReports:(BOOL)mybool{
    if (mybool) {
        if(hud != nil)
        {
            [self.view addSubview:hud];
            hud = nil;
        }
        
        
        if(hud==nil)
        {
            hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            hud.delegate = self;
            [hud show:YES];
            [self.view addSubview:hud];
        }
        
    }else{
        [hud hide:YES];
    }
    
    
    
}



#pragma mark
#pragma mark - WebParsing Delegates
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{
    [self showCustomActivityIndicatorInReports:NO];
    
    if (![[result valueForKey:@"error"] boolValue]) {
        [self setUpResultentData:[result valueForKey:@"data"]];
    }else{
        [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"]integerValue]];
    }
    
    
}
-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    [self showCustomActivityIndicatorInReports:NO];
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
}
-(void)setUpResultentData:(NSArray *)myArray{
    _salesArray = [myArray valueForKey:@"sales"];
    _paymentsArray =[myArray valueForKey:@"payment"];

    if (_reportsSegmentC.selectedSegmentIndex == 0) {
        tableArray = _salesArray;
    }else{
        tableArray = _paymentsArray;
    }
    
        _reportsTableV.dataSource = self;
    _reportsTableV.delegate = self;
    [_reportsTableV reloadData];
}

- (IBAction)reportsSegmentAction:(UISegmentedControl *)sender {
    [GlobalMethods changeSegmentContrilTintColor:sender];
    
    if (_reportsSegmentC.selectedSegmentIndex == 0) {
        tableArray = _salesArray;
    }else{
        tableArray = _paymentsArray;
    }
    
    _reportsTableV.dataSource = self;
    _reportsTableV.delegate = self;
    [_reportsTableV reloadData];
    
}

- (IBAction)menuButtonAction:(id)sender {
    
    [self.view endEditing:YES];
    
    if(dropDownV==nil){
        [self menuViewShow:YES];
    }
    else{
        [self menuViewShow:NO];
    }
    
}
-(void)menuViewShow:(BOOL)myBool{
    [self.view endEditing:YES];
    
    if (myBool) {
        dropDownV = [[CustomTableViewH alloc] initWithStyle:UITableViewStylePlain];
        [dropDownV.view setFrame:CGRectMake(100, 55, 220, 0)];
        //        dropDownV.view.backgroundColor=[UIColor colorWithWhite:0.9f alpha:0.8f];
        dropDownV.view.backgroundColor=[UIColor whiteColor];
        
        dropDownV.delegate = self;
        
        
        [self.view addSubview:dropDownV.view];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [dropDownV.view setFrame:[dropDownV dropDownViewFrame]];
        [UIView commitAnimations];
        
        //        _trasparentBlackView.hidden = NO;
        [_menuBtn setImage:[UIImage imageNamed:@"nf_close"] forState:UIControlStateNormal];

        
    }else{
        [_menuBtn setImage:[UIImage imageNamed:@"HamburgerIcon"] forState:UIControlStateNormal];

        [UIView animateWithDuration:0.5
                         animations:^{
                             [dropDownV.view setFrame:CGRectMake(100,55, 220, 0)];
                         }
                         completion:^(BOOL finished){
                             [dropDownV.view removeFromSuperview];
                             dropDownV=nil;
                             //                             _trasparentBlackView.hidden = YES;
                             
                         }
         ];
        
    }
}
#pragma mark
#pragma mark -menuViewDelegare
-(void)didSelectRowInDropdownTableString:(NSString *)myString atIndexPath:(NSIndexPath *)myIndexPath{
    
    [self menuViewShow:NO];
    
    
    if (myIndexPath.row == 1) {
        [self performSegueWithIdentifier:@"goToNewDishView" sender:self];
    }else if(myIndexPath.row == 2){
        [self performSegueWithIdentifier:@"goToOrdersView" sender:self];
    }else if (myIndexPath.row == 3){
        [self performSegueWithIdentifier:@"goToDishesView" sender:self];
    }else if (myIndexPath.row == 4){
        [self performSegueWithIdentifier:@"goToReviewsView" sender:self];
    }else if (myIndexPath.row == 5){
        [self performToReloadViewController];
    }else if (myIndexPath.row == 6) {
        [self performSegueWithIdentifier:@"goTosettingsView" sender:self];
    }else if (myIndexPath.row == 7) {
        [self performSegueWithIdentifier:@"goToNotificationsView" sender:self];
    }else if (myIndexPath.row == 8) {
        [self goToSignInViewLogout];
    }
  
    
}
-(void)performToReloadViewController{
    [self viewDidLoad];
    [self viewWillAppear:YES];
    [self viewDidAppear:YES];

}
-(void)goToSignInViewLogout{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginE_PProfile"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"OwnerProfile"];
    [appDel clearOwnerProfileClass];
    
    [self performSegueWithIdentifier:@"goToSignInV" sender:self];
    
}


#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.view endEditing:YES];
    
    if ([segue.identifier isEqualToString:@"goToNewDishView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToOrdersView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToDishesView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToReviewsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goTosettingsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToSignInV"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"doToDetailReportVC"]){
        NSIndexPath *indexPath = [_reportsTableV indexPathForSelectedRow];
        ReportdetailVC *destV = [segue destinationViewController];
        destV.DetailReportDic = [[tableArray objectAtIndex:indexPath.section] valueForKey:@"dishes"][indexPath.row];
//        destV.DetailReportDic = [tableArray objectAtIndex:indexPath.row];
        if (_reportsSegmentC.selectedSegmentIndex == 0) {
            destV.SelectedDate = [[tableArray objectAtIndex:indexPath.section] valueForKey:@"order_by_date"];

        }else{
            destV.SelectedDate = [[tableArray objectAtIndex:indexPath.section] valueForKey:@"paid_date"];
            
        }
        destV.SelectedSegment = _reportsSegmentC.selectedSegmentIndex ;
        
        
    }
    
}

- (IBAction)pushBackReports:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
