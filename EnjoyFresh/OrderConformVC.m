//
//  OrderConformVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/7/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "OrderConformVC.h"
#import "GlobalMethods.h"
#import "CustomTableViewH.h"
#import "MBProgressHUD.h"


@interface OrderConformVC ()<CustomTableViewHDelegate,MBProgressHUDDelegate>{
    CustomTableViewH *dropDownV;
    MBProgressHUD *hud;
    NSString *isUpDating;

}

@end

@implementation OrderConformVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];

    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"conform =%@",_ConformOrderDic);
    
    
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:_ConformOrderDic];
    for (NSString * key in [dic allKeys])
    {
        if ([[dic objectForKey:key] isKindOfClass:[NSNull class]])
            [dic setObject:@"" forKey:key];
    }
    _ConformOrderDic = dic;
  
    _OrderIdLbl.text = [NSString stringWithFormat:@"Order #%@",[_ConformOrderDic valueForKey:@"order_id"]];

    _NameLbl.text = [NSString stringWithFormat:@"%@ %@",[_ConformOrderDic valueForKey:@"first_name"],[_ConformOrderDic valueForKey:@"last_name"]];
//    _OrderDateLbl.text =[_ConformOrderDic valueForKey:@"order_by_date"];
    
    if ([[_ConformOrderDic valueForKey:@"last_name"] length] > 0) {
        _orderDateLabelAct.hidden = NO;
    }else{
        _orderDateLabelAct.hidden = YES;
    }
    _OrderDateLbl.text =[self Change24hoursTo12Hours:[_ConformOrderDic valueForKey:@"date_added"]];
    
    
    
    _DishOrder.text = _conformOredrName;
    _Quantity.text = [_ConformOrderDic valueForKey:@"qty"];
    self.lblTax.text=[_ConformOrderDic valueForKey:@"sales_tax"];
    _Price.text = [NSString stringWithFormat:@"$ %.2f",[[_ConformOrderDic valueForKey:@"dish_price"] floatValue]];
    _Total.text = [NSString stringWithFormat:@"$ %@",[_ConformOrderDic valueForKey:@"order_value"]];
    _TransactionIdLbl.text = [_ConformOrderDic valueForKey:@"transaction_id"];
    
    
    if ([_isFrom isEqualToString:@"ConfomState"]) {
//        _orderConformButton.enabled = NO;
        [_orderConformButton setTitle:@"Change To Pending" forState:UIControlStateNormal];
    }else if([_isFrom isEqualToString:@"pendingState"]){
//        _orderConformButton.enabled = YES;
        [_orderConformButton setTitle:@"Confirm Order" forState:UIControlStateNormal];

    }else{
        self.orderConformButton.hidden=YES;
        _DishOrder.text=[_ConformOrderDic valueForKey:@"dish_title"];
    }
    
 }

-(NSString *)Change24hoursTo12Hours:(NSString *)myStg{
    NSDateFormatter *Dform = [[NSDateFormatter alloc]init];
    [Dform setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *mDate = [Dform dateFromString:myStg];
    
    NSDateFormatter *D1form = [[NSDateFormatter alloc]init];
    [D1form setDateFormat:@"MM/dd/yyyy hh:mm a"];
    NSString *stg = [D1form stringFromDate:mDate];
        
    return stg;
    
}

- (IBAction)ConformOrderAction:(id)sender {
    
    /**
     * Restaurant Order Confirmation
     * url - /restaurantOrderconfirmation
     * method - post
     * params - accessToken,orderIds
     */
    
    if (![[_ConformOrderDic valueForKey:@"enable_completed_button"] boolValue]) {
         [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Current time is less than Dish Available from time"];
        return;
    }
    
    
    [self showActivityIndicatorInConfirmOrders:YES];
    
    
    NSMutableDictionary *orderIdsDic = [NSMutableDictionary dictionaryWithObject:[_ConformOrderDic valueForKey:@"order_id"] forKey:@"0"];
    NSData *OrderIdjsonData = [NSJSONSerialization dataWithJSONObject:orderIdsDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *OrderIdjsonString = [[NSString alloc] initWithData:OrderIdjsonData encoding:NSUTF8StringEncoding];

    
    
    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    
    [paramDict setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginE_PProfile"] valueForKey:@"accessToken"] forKey:@"accessToken"];

    [paramDict setObject:OrderIdjsonString forKey:@"orderIds"];
    
    
    isUpDating = @"ConfirmOrder";
    if ([_isFrom isEqualToString:@"ConfomState"]) {
        [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"restaurantOrdersPending"];
    }else if([_isFrom isEqualToString:@"pendingState"]){
        [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"restaurantOrdersConfirmation"];
    }
    else{
        self.orderConformButton.hidden=YES;
    }
    
    
    
}
-(void)showActivityIndicatorInConfirmOrders:(BOOL)myBool{
    if (myBool) {
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
    }
    else{
        [hud hide:YES];
    }
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
#pragma mark - WebParsing Delegates
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{
    NSLog(@"Error %@",result);
    [self showActivityIndicatorInConfirmOrders:NO];
    if (![[result objectForKey:@"error"] boolValue]) {
        if (([[result valueForKey:@"code"] integerValue] == 106 || [[result valueForKey:@"code"] integerValue] == 114) && [isUpDating isEqualToString:@"ConfirmOrder"]) {
            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result objectForKey:@"code"]integerValue]];
            [self performSelector:@selector(reloadDataWithSuccessCodeC:) withObject:result afterDelay:1.0f];
        }
    
    }else{
        [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result objectForKey:@"code"]integerValue]];
    }
    
    

    
}
-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    NSLog(@"errorF = %@",errorH);
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
}

-(void)reloadDataWithSuccessCodeC:(NSDictionary *)myDictionary{
    
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ConfirmedInOrderState"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
//-(void)reloadWholeOrdersC:(NSDictionary *)mydic{
//    
//    
//    
//    [appDel arrangeServiceInOrderWithResultArray:[mydic objectForKey:@"data"]];
//    
//    NSDictionary *MDic;
//    if ([[_IndetailDictionary valueForKey:@"order_type"] isEqualToString:@"Past"]) {
//        
//        for (NSDictionary *dic in appDel.pastOrdersAry) {
//            if ([[dic valueForKey:@"dish_id"] isEqualToString:[_IndetailDictionary valueForKey:@"dish_id"]]) {
//                MDic = dic;
//            }
//            
//        }
//        
//    }else{
//        for (NSDictionary *dic in appDel.openOrdersAry) {
//            if ([[dic valueForKey:@"dish_id"] isEqualToString:[_IndetailDictionary valueForKey:@"dish_id"]]) {
//                MDic = dic;
//            }
//            
//        }
//    }
//    
//    
//    _IndetailDictionary = MDic;
//    
//    [self parseTheArray:[[_IndetailDictionary valueForKey:@"NextViewDic"] valueForKey:@"orders"]];
//    
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didSelectRowInDropdownTableString:(NSString *)myString atIndexPath:(NSIndexPath *)myIndexPath{
    
    [self menuViewShow:NO];

    if (myIndexPath.row == 1) {
        [self performSegueWithIdentifier:@"goToAddDishView" sender:self];
    }else if (myIndexPath.row == 2){
        [self performSegueWithIdentifier:@"goToOrdersView" sender:self];
    }else if (myIndexPath.row == 3){
        [self performSegueWithIdentifier:@"goToDishesView" sender:self];
    }else if (myIndexPath.row == 4){
        [self performSegueWithIdentifier:@"goToReviewsIndicator" sender:self];
    }else if (myIndexPath.row == 5) {
        [self performSegueWithIdentifier:@"goToReportsView" sender:self];
    }else if (myIndexPath.row == 6) {
        [self performSegueWithIdentifier:@"goTosettingsView" sender:self];
    }else if (myIndexPath.row == 7) {
        [self performSegueWithIdentifier:@"goToNotificationsView" sender:self];
    }else if (myIndexPath.row == 8){
        [self performSegueWithIdentifier:@"goToSignInView" sender:self];
    }
    
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.view endEditing:YES];

    if ([segue.identifier isEqualToString:@"goToAddDishView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToOrdersView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToDishesView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToReviewsIndicator"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToReportsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goTosettingsView"]) {
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToSignInView"]) {
        [segue destinationViewController];
    }
}
- (IBAction)PushBack:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
