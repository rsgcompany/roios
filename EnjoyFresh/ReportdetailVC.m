//
//  ReportdetailVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 1/31/15.
//  Copyright (c) 2015 VrindaTech. All rights reserved.
//

#import "ReportdetailVC.h"
#import "TableViewCellH.h"
#import "GlobalMethods.h"
#import "CustomTableViewH.h"
@interface ReportdetailVC ()<UITableViewDataSource,UITableViewDelegate,CustomTableViewHDelegate>{
    CustomTableViewH *dropDownV;
}

@end
@implementation ReportdetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    _navTitleL.text = @"Order details";//[self dateFormetToDateString:_SelectedDate];
    
    
    if (_SelectedSegment == 0) {
        _paymentReportsContainer.hidden = YES;
                
        _DishNameL.text = [NSString stringWithFormat:@"%@",[_DetailReportDic valueForKey:@"dish_title"]];
        _RDishSold.text = [NSString stringWithFormat:@"%@",[[_DetailReportDic valueForKey:@"orders"]valueForKey:@"dishes_sold"] ] ;
        _RTotalSales.text = [GlobalMethods appendDollerToString:[[_DetailReportDic valueForKey:@"orders"] valueForKey:@"total_sales"]];
        _RFees.text = [GlobalMethods appendDollerToString:[NSString stringWithFormat:@"%ld",(long)[[[_DetailReportDic valueForKey:@"orders"]valueForKey:@"total_fees"] integerValue]]];
        _RTax.text = [GlobalMethods appendDollerToString:[[_DetailReportDic valueForKey:@"orders"] valueForKey:@"total_taxes"]] ;
        _RNetRevenue.text = [GlobalMethods appendDollerToString:[[_DetailReportDic valueForKey:@"orders"] valueForKey:@"net_revenue"]];
    }else{
        _salesReportContainer.hidden = YES;
        
        _paymentAmountL.text= [GlobalMethods appendDollerToString:[NSString stringWithFormat:@"%@",[[[_DetailReportDic valueForKey:@"orders"] valueForKey:@"pmt_amt"] lastObject]]];
        _paymentTypeL.text = [NSString stringWithFormat:@"%@",[[[_DetailReportDic valueForKey:@"orders"] valueForKey:@"pmt_type"] lastObject]];
        _amountpaymentL.text = [GlobalMethods appendDollerToString:[_DetailReportDic valueForKey:@"price"]];
        _creditCardFeesL.text =[GlobalMethods appendDollerToString:[[[_DetailReportDic valueForKey:@"orders"] valueForKey:@"total_fees"] lastObject]] ;
        _paymentTaxL.text = [GlobalMethods appendDollerToString:[[[_DetailReportDic valueForKey:@"orders"] valueForKey:@"total_taxes"]lastObject]];
        _netAmountPaidL.text = [GlobalMethods appendDollerToString:[[[_DetailReportDic valueForKey:@"orders"] valueForKey:@"net_paid"]lastObject]];

    }
    
    
    _DetailReportTableV.dataSource = self;
    _DetailReportTableV.delegate = self;
    

}
-(NSString *)dateFormetToDateString:(NSString *)stg{
    NSDateFormatter *form = [[NSDateFormatter alloc]init];
    [form setDateFormat:@"yyyy-MM-dd"];
    NSDate *convDate = [form dateFromString:stg];
    [form setDateFormat:@"MM/dd/yyyy"];
    
    return [form stringFromDate:convDate];    
}

#pragma mark
#pragma mark - TableviewDataSource Delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[_DetailReportDic valueForKey:@"orders"] valueForKey:@"orders"] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdent = @"reviewDetailCellIdentifier";
    TableViewCellH *cell = (TableViewCellH *)[tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
    
    
    NSDictionary *dic1 = [[[_DetailReportDic valueForKey:@"orders"] valueForKey:@"orders"] objectAtIndex:indexPath.row];
 
    
    
    cell.RDOrderedByL.text = [NSString stringWithFormat:@"%@ %@",[dic1 valueForKey:@"first_name"],[dic1 valueForKey:@"last_name"]];
    cell.ROrderIDL.text = [NSString stringWithFormat:@"#%@",[dic1 valueForKey:@"order_id"]];
    cell.RDOrderQuantityL.text = [NSString stringWithFormat:@"%@",[dic1 valueForKey:@"qty"]];
    cell.RDOrdervalueL.text = [GlobalMethods appendDollerToString:[dic1 valueForKey:@"amount_paid"]];
    
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM/dd/yyyy"];
    NSDate *date=[df dateFromString:[dic1 valueForKey:@"avail_by_date"]];
    
    cell.RDOrderFeesL.text =[df stringFromDate:date];
    cell.RDOrdertaxL.text = [GlobalMethods appendDollerToString:[dic1 valueForKey:@"sales_tax"]];

    
    return cell;
}
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *cellIdent = @"reviewDetailSectionIdentifier";
    TableViewCellH *cell = (TableViewCellH *)[tableView dequeueReusableCellWithIdentifier:cellIdent];
   
    cell.RDSectionNameC.text = [GlobalMethods dateFormettForCell:_SelectedDate];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35.0f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)menuButtonAction:(id)sender {
    
    [self.view endEditing:YES];
    
    if(dropDownV==nil){
        [self menuViewShowInR2:YES];
    }
    else{
        [self menuViewShowInR2:NO];
    }
    
}
-(void)menuViewShowInR2:(BOOL)myBool{
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
        
        [_menuBtn setImage:[UIImage imageNamed:@"nf_close"] forState:UIControlStateNormal];

        //        _trasparentBlackView.hidden = NO;
        
    }else{
        [_menuBtn setImage:[UIImage imageNamed:@"HamburgerIcon"] forState:UIControlStateNormal];

        [UIView animateWithDuration:0.5
                         animations:^{
                             [dropDownV.view setFrame:CGRectMake(100, 55, 220, 0)];
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
    
    [self menuViewShowInR2:NO];

    
    
    if (myIndexPath.row == 1) {
        [self performSegueWithIdentifier:@"goToNewDishView" sender:self];
    }else if(myIndexPath.row == 2){
        [self performSegueWithIdentifier:@"goToOrdersView" sender:self];
    }else if (myIndexPath.row == 3){
        [self performSegueWithIdentifier:@"goToDishesView" sender:self];
    }else if (myIndexPath.row == 4){
        [self performSegueWithIdentifier:@"goToReviewsView" sender:self];
    }else if (myIndexPath.row == 5){
        [self performSegueWithIdentifier:@"goToReportsView" sender:self];
    }else if (myIndexPath.row == 6) {
        [self performSegueWithIdentifier:@"goTosettingsView" sender:self];
    }else if (myIndexPath.row == 7) {
        [self performSegueWithIdentifier:@"goToNotificationsView" sender:self];
    }else if (myIndexPath.row == 8) {
        [self goToSignInViewLogout];
    }
    
    
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
    }else if ([segue.identifier isEqualToString:@"goToReportsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goTosettingsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToSignInV"]){
        [segue destinationViewController];
    }
    
}





- (IBAction)pushBackDetailReport:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
