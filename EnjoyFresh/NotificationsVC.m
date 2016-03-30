//
//  NotificationsVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/23/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "NotificationsVC.h"
#import "ParserHClass.h"
#import "GlobalMethods.h"
#import "CustomTableViewH.h"
#import "MBProgressHUD.h"
#import "NotificationCell.h"
#import "DishesVC.h"
#import "OrdersVC.h"
#import "DishReviewsVC.h"
#import "OrderConformVC.h"
//#import "Global.h"

@interface NotificationsVC ()<parserHDelegate,CustomTableViewHDelegate,MBProgressHUDDelegate>{
    
    ParserHClass *webParser;
    CustomTableViewH *dropDownV;
    MBProgressHUD *hud;
    
}

@end

NSString *isFromMenu;
int parseInt;

@implementation NotificationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=YES;
    
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    
}
-(void)viewWillAppear:(BOOL)animated{
    _EmailSwitch.on = appDel.CurrentOwnerDetails.owner_email_ntfn;
    _FaxSwitch.on = appDel.CurrentOwnerDetails.owner_fax_ntfn;
    _TextSwitch.on = appDel.CurrentOwnerDetails.owner_txt_ntfn;
    [self showActivityIndicatorInNotif:YES];

    parseInt=0;
    NSMutableDictionary *params= [NSMutableDictionary dictionaryWithObjectsAndKeys:appDel.CurrentOwnerDetails.owner_user_id,@"userId",appDel.CurrentOwnerDetails.owner_accessToken,@"accessToken",nil];

    [webParser parserPostMethodWithParameters:params andExtendUrl:@"getAllNotifications"];
//   
//    [paramDict setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginE_PProfile"] valueForKey:@"accessToken"] forKey:@"accessToken"];
//    //    [paramDict setObject:@"{D6B0E705-78BB-676D-AD2E-21196BC84ECB}" forKey:@"accessToken"];
//    
//    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"restaurantOrders"];
}


- (IBAction)EmailSwitchTapped:(id)sender {
    if (_EmailSwitch.isOn) {
    }
    else{
    }
    
}
- (IBAction)FaxSwitchTapped:(id)sender {
    if (_FaxSwitch.isOn) {
    }
    else{
    }
}
- (IBAction)TextSwitchTapped:(id)sender {
    
    if (_TextSwitch.isOn) {
    }
    else{        
    }
}

#pragma mark
#pragma mark - CustomActivityIndicator Delegate
-(void)showActivityIndicatorInNotif:(BOOL)myBool{
    if (myBool) {
        if(hud != nil){
            [self.view addSubview:hud];
            hud = nil;
        }
        
        if(hud==nil){
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


- (IBAction)SaveSettings:(id)sender {
    [self showActivityIndicatorInNotif:YES];
    //    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    //    [paramDict setObject:@"{D6B0E705-78BB-676D-AD2E-21196BC84ECB}" forKey:@"accessToken"];
    //    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"editOwnerProfile"];
    //
    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
    [paramDict setValue:[NSNumber numberWithBool:[_EmailSwitch isOn]] forKey:@"email_ntfn"];
    [paramDict setValue:[NSNumber numberWithBool:[_FaxSwitch isOn]] forKey:@"fax_ntfn"];
    [paramDict setValue:[NSNumber numberWithBool:[_TextSwitch isOn]] forKey:@"txt_ntfn"];

    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"editOwnerProfile"];

    
}



#pragma mark
#pragma mark - WebParser Delegate
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{
    
    [self showActivityIndicatorInNotif:NO];
    
    NSLog(@"%@",result);
    if ([[result valueForKey:@"error"] boolValue]) {
        
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:[result valueForKey:@"message"]];
    }
    else if(parseInt==0){
        notificationArr=[[NSArray alloc]init];
        notificationArr=[result valueForKey:@"notifications"];
        _notificationTbl.delegate=(id)self;
        _notificationTbl.dataSource=(id)self;
        
        [_notificationTbl reloadData];
    }
    else{
        NSLog(@"result:%@",result);
        
        orderDetailDict=[result mutableCopy];
        [self performSegueWithIdentifier:@"goToConformOrder" sender:self];

    }
    
    
}

-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    [self showActivityIndicatorInNotif:NO];
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
}

-(void)saveLoginDetailsInNotif:(NSDictionary *)result{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithDictionary:[result valueForKey:@"profile"]];
    [dict setObject:[result valueForKey:@"accessToken"] forKey:@"accessToken"];
    
    
    for (NSString * key in [dict allKeys]){
        if ([[dict objectForKey:key] isKindOfClass:[NSNull class]])
            [dict setObject:@"" forKey:key];
    }
    
    [appDel ownerProfileUpDateWithResult:dict];
    
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"OwnerProfile"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [self performSelector:@selector(backButtonAction:) withObject:nil];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
#pragma mark - TableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [notificationArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"NotificationCell";
    
    NotificationCell *cell =[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        cell = [[NotificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.lblText.numberOfLines=0;
    cell.lblTitle.font=[UIFont fontWithName:SemiBold size:15];
    cell.lblText.font=[UIFont fontWithName:Regular size:12];
    cell.lblDate.font=[UIFont fontWithName:SemiBold size:10];
    if ([[[notificationArr objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"Order"]) {
        cell.imgNotification.image=[UIImage imageNamed:@"order"];
    }
    else if([[[notificationArr objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"Favorite"]){
        cell.imgNotification.image=[UIImage imageNamed:@"favorite"];
        
    }
    else if([[[notificationArr objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"Non Schedule"]){
        cell.imgNotification.image=[UIImage imageNamed:@"not_scheduled"];
        
    }
    else if([[[notificationArr objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"Order Summary"]){
        cell.imgNotification.image=[UIImage imageNamed:@"orders"];

    }
    else{
        cell.imgNotification.image=[UIImage imageNamed:@"food_lover"];
    }
    
    cell.lblTitle.text=[[notificationArr objectAtIndex:indexPath.row] valueForKey:@"title"];
    cell.lblText.text=[[notificationArr objectAtIndex:indexPath.row] valueForKey:@"text"];
    NSString *date=[[notificationArr objectAtIndex:indexPath.row] valueForKey:@"created"];
    NSArray *arr=[date componentsSeparatedByString:@" "];
    
    NSString *dateString = @"";
    dateString = [NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dt = [formatter dateFromString:dateString];
    
    [formatter setDateFormat:@"MM/dd/yy"];
    dateString = [formatter stringFromDate:dt];
    
    cell.lblDate.text=dateString;
    return cell;
}
#pragma mark
#pragma mark - TableView Delegates
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([[[notificationArr objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"Non Schedule"]) {
        [self performSegueWithIdentifier:@"goToDishesView" sender:self];
    }
    else if([[[notificationArr objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"Review"]){
        [self performSegueWithIdentifier:@"goToReviewsView" sender:indexPath];
    }
    else if ([[[notificationArr objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"Order"] ){
        NSError *e = nil;
        NSData *data=[[[notificationArr objectAtIndex:indexPath.row ] valueForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: &e];
        orderId=[json valueForKey:@"action"];
        
//        NSArray *arr=[appDel.openOrdersAry arrayByAddingObjectsFromArray:appDel.pastOrdersAry];
//        for (NSDictionary *dict in arr) {
//            NSArray *orders=[[dict valueForKey:@"NextViewDic"] valueForKey:@"orders"];
//            
//           if (![orders  isEqual: @"1"]) {
//               for (NSDictionary *orderDic in orders) {
//                   NSString *OID=[orderDic valueForKey:@"order_id"];
//                   if ([OID isEqualToString:[NSString stringWithFormat:@"%@",orderId]]) {
//                       orderDetailDict=[orderDic mutableCopy];
//                       [orderDetailDict setObject:[dict valueForKey:@"dish_title"] forKey:@"dish_title"];
//                   }
//               }
//            }
//        }
//        NSLog(@"Order id:%@",orderDetailDict);
        parseInt=1;
        
        [self showActivityIndicatorInNotif:YES];
       
        NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
        [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
        [paramDict setObject:orderId forKey:@"orderId"];

        [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"orderplacednotification"];
        
        //[self performSegueWithIdentifier:@"goToConformOrder" sender:indexPath];

    }
    else if([[[notificationArr objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"Order Summary"]){
        [self performSegueWithIdentifier:@"goToOrdersView" sender:indexPath];
    }
}

#pragma mark
#pragma mark - CustomTableview Datasource Delegate
-(void)didSelectRowInDropdownTableString:(NSString *)myString atIndexPath:(NSIndexPath *)myIndexPath{
    
    [self menuViewShow:NO];
    
    if (myIndexPath.row == 1) {
        [self performSegueWithIdentifier:@"goToAddDishView" sender:self];
    }else if (myIndexPath.row == 2){
        isFromMenu=@"yes";
        [self performSegueWithIdentifier:@"goToOrdersView" sender:self];
    }else if (myIndexPath.row == 3){
        [self performSegueWithIdentifier:@"goToDishesView" sender:self];
    }else if (myIndexPath.row == 4) {
        [self performSegueWithIdentifier:@"goToReviewsView" sender:self];
    }else if (myIndexPath.row == 5) {
        [self performSegueWithIdentifier:@"goToReportsView" sender:self];
    }else if (myIndexPath.row == 6){
        [self performSegueWithIdentifier:@"goTosettingsView" sender:self];
    }else if (myIndexPath.row == 8){
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.view endEditing:YES];
    if ([segue.identifier isEqualToString:@"goToAddDishView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToOrdersView"]){
        [segue destinationViewController];
        NSIndexPath *indexPath = (NSIndexPath *)sender;

        OrdersVC *vc=[segue destinationViewController];
        if ([isFromMenu isEqualToString:@"yes"]) {
            
        }
        else{
            vc.notificationDict=[notificationArr objectAtIndex:indexPath.row];
            
        }
        
    }else if ([segue.identifier isEqualToString:@"goToDishesView"]){
       // [segue destinationViewController];
        DishesVC *dest = [segue destinationViewController];
        dest.fromNotifications=YES;
    }else if ([segue.identifier isEqualToString:@"goToReviewsView"]){
        [segue destinationViewController];
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        DishReviewsVC *vc=[segue destinationViewController];
         vc.fromNotificationDict=[notificationArr objectAtIndex:indexPath.row];
    }else if ([segue.identifier isEqualToString:@"goToReportsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goTosettingsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToSignInV"]){
        [segue destinationViewController];
    }
    else if ([segue.identifier isEqualToString:@"goToConformOrder"]) {
        OrderConformVC *destViewController = segue.destinationViewController;
        destViewController.ConformOrderDic=orderDetailDict;
        destViewController.isFrom=@"Notification";
    }

    
}


- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
