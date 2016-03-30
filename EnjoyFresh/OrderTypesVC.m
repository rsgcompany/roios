//
//  OrderTypesVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/23/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "OrderTypesVC.h"
#import "ParserHClass.h"
#import "GlobalMethods.h"
#import "MBProgressHUD.h"
#import "CustomTableViewH.h"

@interface OrderTypesVC ()<parserHDelegate,MBProgressHUDDelegate,CustomTableViewHDelegate>{
    
    ParserHClass *webParser;
    MBProgressHUD *hud;
    CustomTableViewH *dropDownV;

    
}



@end

@implementation OrderTypesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden=YES;
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    _DineInSwitch.on = appDel.CurrentOwnerDetails.owner_dine_in;
    _PickupSwitch.on = appDel.CurrentOwnerDetails.owner_pick_up;
    
   
}
- (IBAction)DineInSwitchTapped:(id)sender {
    if (_DineInSwitch.isOn) {
    }
    else{
        
    }
}
- (IBAction)PickupSwitchTapped:(id)sender {
    if (_PickupSwitch.isOn) {
    }
    else{        
    }
    
}

#pragma mark
#pragma mark - CustomActivityIndicator Delegate
-(void)showActivityIndicatorInOrd:(BOOL)myBool{
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
    [self showActivityIndicatorInOrd:YES];
    
    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
    [paramDict setValue:[NSNumber numberWithBool:[_DineInSwitch isOn]] forKey:@"dine_in"];
    [paramDict setValue:[NSNumber numberWithBool:[_PickupSwitch isOn]] forKey:@"pick_up"];
    
    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"editOwnerProfile"];
}


#pragma mark
#pragma mark - WebParser Delegate
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{
    
    [self showActivityIndicatorInOrd:NO];
    
    NSLog(@"%@",result);
    if (![[result valueForKey:@"error"] boolValue]) {
        if ([[result valueForKey:@"code"] integerValue] != 113) {
            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
        }else{
            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
            [self performSelector:@selector(saveLoginDetailsInOrd:) withObject:[result valueForKey:@"data"] afterDelay:0.1f];
        }
    }
    
    
    
    
}

-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    [self showActivityIndicatorInOrd:NO];
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
}

-(void)saveLoginDetailsInOrd:(NSDictionary *)result{
    
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
- (IBAction)menuBittonAction:(id)sender {
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
#pragma mark - CustomTableview Datasource Delegate
-(void)didSelectRowInDropdownTableString:(NSString *)myString atIndexPath:(NSIndexPath *)myIndexPath{
    
    [self menuViewShow:NO];

    
    
    if (myIndexPath.row == 1) {
        [self performSegueWithIdentifier:@"goToAddDishView" sender:self];
    }else if (myIndexPath.row == 2){
        [self performSegueWithIdentifier:@"goToOrdersView" sender:self];
    }else if (myIndexPath.row == 3){
        [self performSegueWithIdentifier:@"goToDishesView" sender:self];
    }else if (myIndexPath.row == 4) {
        [self performSegueWithIdentifier:@"goToReviewsView" sender:self];
    }else if (myIndexPath.row == 5) {
        [self performSegueWithIdentifier:@"goToReportsView" sender:self];
    }else if (myIndexPath.row == 6){
        [self performSegueWithIdentifier:@"goTosettingsView" sender:self];
    }else if (myIndexPath.row == 7) {
        [self performSegueWithIdentifier:@"goToNotificationsView" sender:self];
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


- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
