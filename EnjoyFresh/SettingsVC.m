//
//  SettingsVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/6/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "SettingsVC.h"
#import "TableViewCellH.h"
#import "CustomTableViewH.h"
#import "GlobalMethods.h"

@interface SettingsVC ()<UITableViewDataSource,UITableViewDelegate,CustomTableViewHDelegate>{
    NSArray *titleArray;
    CustomTableViewH *dropDownV;
}

@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];

    titleArray=[[NSArray alloc]initWithObjects:@"Login Settings",@"Basic Info",@"Links & Social Profiles",@"Types of Cuisine",@"Add Photos",@"Processing Payments", nil];
//    titleArray=[[NSArray alloc]initWithObjects:@"Login Settings",@"Basic Info",@"Notifications",@"Links & Social Profiles",@"Types of Cuisine",@"Add Photos",@"Processing Payments",@"Order Types", nil];
    
    self.tableV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}
-(void)viewWillAppear:(BOOL)animated{
    [_tableV deselectRowAtIndexPath:[_tableV indexPathForSelectedRow] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdent=@"cellIdent";
    TableViewCellH *cell=(TableViewCellH *)[tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
//    cell.titleLabel.font=[UIFont fontWithName:@"Raleway-SemiBold" size:13.0f];
    cell.titleLabel.text = [titleArray objectAtIndex:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
    
    // If you are not using ARC:
    // return [[UIView new] autorelease];
}

- (IBAction)BackBtnClicked:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)menuDropDownButtonBlock:(id)sender {
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

        [UIView animateWithDuration:0.2
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

-(void)didSelectRowInDropdownTableString:(NSString *)myString atIndexPath:(NSIndexPath *)myIndexPath{
    [self menuViewShow:NO];

    
    if (myIndexPath.row == 1) {
        [self performSegueWithIdentifier:@"goToAddDishView" sender:self];
    }else if (myIndexPath.row == 2) {
        [self performSegueWithIdentifier:@"goToOrdersView" sender:self];
    }else if (myIndexPath.row == 3) {
        [self performSegueWithIdentifier:@"goToDishesView" sender:self];
    }else if (myIndexPath.row == 4) {
        [self performSegueWithIdentifier:@"goToReviewsView" sender:self];
    }else if (myIndexPath.row == 5) {
        [self performSegueWithIdentifier:@"goToReportsView" sender:self];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"goToLoginSettings" sender:self];
    }else if (indexPath.row == 1){
        [self performSegueWithIdentifier:@"goToBasicInfoView" sender:self];
    }else if (indexPath.row == 2){
        [self performSegueWithIdentifier:@"goTolinksSocialProfileView" sender:self];
    }else if (indexPath.row == 3){
        [self performSegueWithIdentifier:@"goToTypesOfCiusineView" sender:self];
    }else if (indexPath.row == 4){
        [self performSegueWithIdentifier:@"goToAddPhotosView" sender:self];
    }else if (indexPath.row == 5){
        [self performSegueWithIdentifier:@"goToPaymentView" sender:self];
    }else{
        [self performSegueWithIdentifier:@"goToOrderTypeView" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.view endEditing:YES];

    if ([segue.identifier isEqualToString:@"goToLoginSettings"]) {
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToBasicInfoView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToNotificationsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goTolinksSocialProfileView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToAdvertiseView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToTypesOfCiusineView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToAddPhotosView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToPaymentView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToOrderTypeView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToAddDishView"]) {
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToOrdersView"]) {
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToDishesView"]) {
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToReviewsView"]) {
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToReportsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToSignInV"]) {
        [segue destinationViewController];
    }
}
@end
