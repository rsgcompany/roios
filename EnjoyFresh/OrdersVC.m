//
//  OrdersVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/7/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "OrdersVC.h"
#import "TableViewCellH.h"
#import "OrderDetailVC.h"

#import "ParserHClass.h"
#import "GlobalMethods.h"
#import "UIImageView+WebCache.h"
#import "CustomTableViewH.h"



#define BaseImageUrl 


@interface OrdersVC ()<parserHDelegate,CustomTableViewHDelegate>{
    ParserHClass *webParser;
    CustomTableViewH *dropDownV;

    
    NSArray *dishesArr;
    
    
    NSArray *tableArray;

}

@end

@implementation OrdersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden=YES;
    _backButton.hidden = NO;
    if ([_isFrom isEqualToString:@"SignInView"]) {
        _backButton.hidden = YES;
    }
    
    
    searchLayer = [[UIView alloc] initWithFrame:CGRectMake(0, _OrdersTable.frame.origin.y+40, _OrdersTable.frame.size.width, _OrdersTable.frame.size.height)];
    searchLayer.userInteractionEnabled = NO;
    searchLayer.multipleTouchEnabled = NO;
    [self.view addSubview:searchLayer];
    searchLayer.hidden = YES;

    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [searchLayer addGestureRecognizer:tapGesture];
    
    
    search_bar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    search_bar.placeholder=@"Search for an order";
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:Medium size:12.0f]}];
//    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setBackgroundColor:[UIColor redColor]];


    [self setUpsecondHeaderView:YES];
    
       // 119,157,93
    
    
    [appDel.openOrdersAry removeAllObjects];
    [appDel.pastOrdersAry removeAllObjects];
    
    _OrdersTable.dataSource=self;
    _OrdersTable.delegate=self;
    
    
    
    
 

//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"selectedOrder"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [self showCustomActivityIndicatorInOrders:YES];
    
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    
    
    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    
//    [paramDict setObject:@"{D6B0E705-78BB-676D-AD2E-21196BC84ECB}" forKey:@"accessToken"];
//    [paramDict setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"OwnerProfile"] objectForKey:@"accessToken"] forKey:@"accessToken"];
    
  
   
    [paramDict setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginE_PProfile"] valueForKey:@"accessToken"] forKey:@"accessToken"];
//    [paramDict setObject:@"{D6B0E705-78BB-676D-AD2E-21196BC84ECB}" forKey:@"accessToken"];

    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"restaurantOrders"];
    
     self.OrdersTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    if (self.notificationDict!=nil) {
        NSError *e = nil;
        NSData *data=[[self.notificationDict valueForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: &e];
        orderId=[json valueForKey:@"action"];
    
        NSLog(@"array order id:%@",orderId);
    }
    
}
- (void)setUpsecondHeaderView:(BOOL)myBool {
    SecondHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    SecondHeaderView.backgroundColor=[UIColor whiteColor];
    
    
    openPostSegment = [[UISegmentedControl alloc] initWithItems:@[@"OPEN ORDERS", @"PAST ORDERS"]];
    openPostSegment.frame = CGRectMake(10, 10, 300, 25);
    [openPostSegment addTarget:self action:@selector(MySegmentControlAction1:) forControlEvents: UIControlEventValueChanged];
    openPostSegment.backgroundColor=[UIColor whiteColor];
    openPostSegment.selectedSegmentIndex = 0;
    [GlobalMethods changeSegmentContrilTintColor:openPostSegment];
    [SecondHeaderView addSubview:openPostSegment];
    

}


- (void)viewWillAppear:(BOOL)animated {

    [_OrdersTable deselectRowAtIndexPath:[_OrdersTable indexPathForSelectedRow] animated:YES];
    
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ConfirmedInOrderState"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
//    [self showCustomActivityIndicatorInOrders:YES];
//  
//    webParser=[[ParserHClass alloc]init];
//    webParser.delegate=self;
//    
//    
//    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
//    
////    [paramDict setObject:@"{D6B0E705-78BB-676D-AD2E-21196BC84ECB}" forKey:@"accessToken"];
//    [paramDict setObject:@"{35B7584D-A6C4-118D-53E1-3EF29F00BBF0}" forKey:@"accessToken"];
//    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"restaurantOrders"];
//    
    [_OrdersTable reloadData];
}

- (void)dismissKeyboard:(id)gesture {
    if (![search_bar.text length]) {
        [self tableReloadDateAccordingToSegmentOD];
    }
    [search_bar resignFirstResponder];
}
- (void)MySegmentControlAction1:(UISegmentedControl *)sender {
    [GlobalMethods changeSegmentContrilTintColor:sender];

    
    if ([search_bar.text length]) {
        [self searchBarSearchButtonClicked:search_bar];
        return;
    }
    
    
    
    if(sender.selectedSegmentIndex==0){
        NSLog(@"Load OPEN ORDERS");
        tableArray = appDel.openOrdersAry;
    }
    else{
        NSLog(@"Load POST ORDERS");
        tableArray = appDel.pastOrdersAry;
    }
    _OrdersTable.dataSource=self;
    _OrdersTable.delegate=self;

    [_OrdersTable reloadData];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 40;
    }
    else {
        return 40;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    if (section==0) {
        search_bar.delegate=self;
        search_bar.searchBarStyle=UISearchBarStyleMinimal;
        return search_bar;
    }
    else {
        return SecondHeaderView;
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==1) {
        return tableArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"OrderCell";
    
    TableViewCellH *cell = (TableViewCellH *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *dict;
    
//    if (openPostSegment.selectedSegmentIndex ==0) {
//        dict = [appDel.openOrdersAry objectAtIndex:indexPath.row];
//    }else{
//        dict = [appDel.pastOrdersAry objectAtIndex:indexPath.row];
//    }
    
   
    dict = [tableArray objectAtIndex:indexPath.row];
    
    if (orderId !=nil ) {
        
        NSArray *orders=[[dict valueForKey:@"NextViewDic"] valueForKey:@"orders"];
        if (![orders  isEqual: @"1"]) {
            for (NSDictionary *dict in orders) {
                NSString *OID=[dict valueForKey:@"order_id"];
                if ([OID isEqualToString:[NSString stringWithFormat:@"%@",orderId]]) {
                    
                    cell.hilightLable.backgroundColor=[UIColor colorWithRed:99/255.0 green:157/255.0 blue:88/255.0 alpha:1];
                    cell.highlightLable1.backgroundColor=[UIColor colorWithRed:99/255.0 green:157/255.0 blue:88/255.0 alpha:1];
              }
                else{
                    cell.hilightLable.backgroundColor=[UIColor clearColor];
                    cell.highlightLable1.backgroundColor=[UIColor clearColor];


                }
            }
        }
        else{
            cell.hilightLable.backgroundColor=[UIColor clearColor];
            cell.highlightLable1.backgroundColor=[UIColor clearColor];

        }
    }
    else{
        cell.hilightLable.backgroundColor=[UIColor clearColor];
        cell.highlightLable1.backgroundColor=[UIColor clearColor];

    }

    cell.ItemNameLbl.text=[dict valueForKey:@"dish_title"];
    cell.CostLbl.text=[NSString stringWithFormat:@"$%@",[dict valueForKey:@"price"]];
    cell.ReceivedDateLbl.text=[NSString stringWithFormat:@"Available on %@",[self dateFormetForReviewTableCell:[dict valueForKey:@"avail_by_date"]]];
    
        
    cell.RemainingLlb.text = [NSString stringWithFormat:@"%@/%@ REMAINING",[dict valueForKey:@"remaining_qty"],[dict valueForKey:@"avail_qty"]];
    /*
    int remQty= (int)[dict valueForKey:@"remaining_qty"];
    int availQty= (int)[dict valueForKey:@"avail_qty"];
    
    if(abs(remQty-availQty)){
        cell.RemainingLlb.backgroundColor = [UIColor darkGrayColor];
        cell.RemainingLlb.text = [NSString stringWithFormat:@"%@/%@ REMAINING",[dict valueForKey:@"remaining_qty"],[dict valueForKey:@"avail_qty"]];

    }else{
        cell.RemainingLlb.backgroundColor = [UIColor redColor];
        cell.RemainingLlb.text = [NSString stringWithFormat:@"%@/%@ REMAINING",[dict valueForKey:@"remaining_qty"],[dict valueForKey:@"avail_qty"]];
    }
    */
        
    
//    [DDic setObject:dish_title forKey:@"dish_title"];
//    [DDic setObject:images forKey:@"images"];
//    [DDic setObject:price forKey:@"price"];
//    [DDic setObject:avail_by_date forKey:@"avail_by_date"];
//    [DDic setObject:ordered_qty forKey:@"ordered_qty"];
//    [DDic setObject:avail_qty forKey:@"avail_qty"];
//    [DDic setObject:order_type forKey:@"order_type"];
//    [DDic setObject:dish_id forKey:@"dish_id"];
//    [DDic setObject:dishDic forKey:@"NextViewDic"];
    
    
    cell.RestaurantImage.image=[UIImage imageNamed:@"Apple.png"];
    id img=[dict valueForKey:@"images"];
    NSDictionary *locDict;
    if ([img isKindOfClass:[NSArray class]]){
        NSArray *art=[dict valueForKey:@"images"];
        if ([art count]) {
                for (NSDictionary *dic in art) {
                    if ([[dic valueForKey:@"default"] integerValue]==1){
                        locDict=dic;
                }
            }
        }
    }
    else{
        locDict=[dict valueForKey:@"images"];
    }
    
    if([ locDict count]!=0){
        NSString *disturlStr=[NSString stringWithFormat:@"%@%@",DishImageUrl,[locDict valueForKey:@"path_lg"]];
        
        NSLog(@"Dish Image: %@", disturlStr);
        
        [cell.RestaurantImage sd_setImageWithURL:[NSURL URLWithString:disturlStr] placeholderImage:[UIImage imageNamed:@"Apple.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             if(image==nil)
                 cell.RestaurantImage.image=[UIImage imageNamed:@"Apple.png"];
             else
                 cell.RestaurantImage.image = [GlobalMethods imageByScalingAndCroppingForSize:CGSizeMake(200,200) source:image];
         }];
    }

    
 
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

-(NSString *)dateFormetForReviewTableCell:(NSString *)myStg{
    NSDateFormatter *Dform = [[NSDateFormatter alloc]init];
    [Dform setDateFormat:@"yyyy-MM-dd"];
    NSDate *mDate = [Dform dateFromString:myStg];
    
    NSDateFormatter *D1form = [[NSDateFormatter alloc]init];
    [D1form setDateFormat:@"MM/dd/yyyy"];
    NSString *stg = [D1form stringFromDate:mDate];
    
   
    return stg;
    
}


#pragma mark
#pragma mark - SearshBar Delegates
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    _OrdersTable.scrollEnabled = NO;
    searchLayer.hidden = NO;
    
    searchLayer.backgroundColor=[UIColor blackColor];
    searchLayer.alpha=0.6;
    
    searchLayer.userInteractionEnabled = YES;
    searchLayer.multipleTouchEnabled = YES;
    
    
    
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    searchLayer.hidden = YES;
    _OrdersTable.scrollEnabled = YES;
    searchLayer.userInteractionEnabled = NO;
    searchLayer.multipleTouchEnabled = NO;
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"Search clicked done reload table data");
    NSPredicate *pred1=[NSPredicate predicateWithFormat:@"dish_id CONTAINS[c] %@ || dish_title CONTAINS[c] %@",searchBar.text,searchBar.text];
   
    NSPredicate *compoundPredicate;
    
    
    NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:pred1, nil];
    compoundPredicate= [NSCompoundPredicate andPredicateWithSubpredicates:arr];
    if (openPostSegment.selectedSegmentIndex ==0) {
        tableArray = [appDel.openOrdersAry filteredArrayUsingPredicate:compoundPredicate];
    }else{
        tableArray = [appDel.pastOrdersAry filteredArrayUsingPredicate:compoundPredicate];
    }
    
    arr=nil;
    
    [_OrdersTable reloadData];
    search_bar.text=searchBar.text;

    
}



- (IBAction)PushBack:(id)sender {
    
    
    
    if (![searchLayer isHidden]) {
        [self.view endEditing:YES];
        [self performSelector:@selector(dismissKeyboard:) withObject:nil];
    }else{
        [self.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark
#pragma mark - WebParsing Delegates
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{

    [self showCustomActivityIndicatorInOrders:NO];
    
    BOOL errMsg = [[result objectForKey:@"error"] boolValue];
    
    if (!errMsg) {
        [appDel arrangeServiceInOrderWithResultArray:[result objectForKey:@"data"]];
//        NSString *status=[self getstausOfDish:[result objectForKey:@"data"]];
//        if ([status isEqualToString:@"Past"]) {
//            openPostSegment.selectedSegmentIndex=1;
//        }
        [self tableReloadDateAccordingToSegmentOD];
    }else{
        [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result objectForKey:@"code"] integerValue]];
    }
    
    if (appDel.pushFlag==YES) {
        [self performSegueWithIdentifier:@"goToNotificationsView" sender:self];
        appDel.pushFlag=NO;
    }
}
-(NSString *)getstausOfDish:(NSArray *)arr{
    for (int f=0; f<arr.count; f++) {
        NSDictionary *fDic=[arr objectAtIndex:f];
        NSArray *Aarray=[fDic valueForKey:@"orders"];
        for (int a=0; a<Aarray.count; a++) {
            NSDictionary *dica=[Aarray objectAtIndex:a];
            NSString *OID=[dica valueForKey:@"order_id"];
            if ([OID isEqualToString:[NSString stringWithFormat:@"%@",orderId]]){
                if ([[dica valueForKey:@"order_type"] isEqualToString:@"Open"]) {
                    return @"Open";
                }
                else{
                    return @"Past";
                }
            }
        }
    }
    
return @"";
}

-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    NSLog(@"errorF = %@",errorH);
    [self showCustomActivityIndicatorInOrders:NO];
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
}

-(void)tableReloadDateAccordingToSegmentOD{
    
    if (openPostSegment.selectedSegmentIndex == 0) {
        tableArray = appDel.openOrdersAry;
    }else{
        tableArray = appDel.pastOrdersAry;
    }
    _OrdersTable.dataSource=self;
    _OrdersTable.delegate=self;
    
    [_OrdersTable reloadData];
   
    if (orderId !=nil ) {
        for (int i=0;i<tableArray.count;i++){
            NSDictionary *dict=[tableArray objectAtIndex:i];
            NSArray *orders=[[dict valueForKey:@"NextViewDic"] valueForKey:@"orders"];
            if (![orders  isEqual: @"1"]) {
                for (NSDictionary *dict in orders) {
                    NSString *OID=[dict valueForKey:@"order_id"];
                    if ([OID isEqualToString:[NSString stringWithFormat:@"%@",orderId]]) {
                        int rowToHighlight = i;
                        NSIndexPath * ndxPath= [NSIndexPath indexPathForRow:rowToHighlight inSection:1];
                       
                    [self.OrdersTable scrollToRowAtIndexPath:ndxPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                    }
                }
            }
        }
        
    }

   
}

-(void)showCustomActivityIndicatorInOrders:(BOOL)mybool{
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


-(void)didSelectRowInDropdownTableString:(NSString *)myString atIndexPath:(NSIndexPath *)myIndexPath{
    [self menuViewShow:NO];

    if (myIndexPath.row == 1) {
        [self performSegueWithIdentifier:@"goToAddDishView" sender:self];
    }else if (myIndexPath.row == 2){
        [self performToReloadViewController];
    }else if (myIndexPath.row == 3){
        [self performSegueWithIdentifier:@"goToDishesView" sender:self];
    }else if (myIndexPath.row == 4){
        [self performSegueWithIdentifier:@"goToReviewsView" sender:self];
    }else if (myIndexPath.row == 5){
        [self performSegueWithIdentifier:@"goToReportsView" sender:self];
    }else if (myIndexPath.row == 6){
        [self performSegueWithIdentifier:@"goTosettingsView" sender:self];
    }else if (myIndexPath.row == 7) {
        [self performSegueWithIdentifier:@"goToNotificationsView" sender:self];
    }else if (myIndexPath.row == 8){
        [self goToSignInViewLogout];
    }
    
}
-(void)performToReloadViewController{
    [self viewDidLoad];
    [self viewWillAppear:YES];
    [self viewDidAppear:YES];
    
}
-(void)goToSignInViewLogout{
    //    [self performSegueWithIdentifier:@"goToSignInView" sender:self];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginE_PProfile"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"OwnerProfile"];
    [appDel clearOwnerProfileClass];
//    [self.navigationController popViewControllerAnimated:YES];
    [self performSegueWithIdentifier:@"goToSignInV" sender:self];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.view endEditing:YES];
    if ([segue.identifier isEqualToString:@"goToOrderDetail"]) {
        NSIndexPath *indexPath = [_OrdersTable indexPathForSelectedRow];
//       [segue destinationViewController];
        OrderDetailVC *destViewController = segue.destinationViewController;
//
//        if (openPostSegment.selectedSegmentIndex ==0) {
//            destViewController.IndetailDictionary = [appDel.openOrdersAry objectAtIndex:indexPath.row];
//        }else{
//            destViewController.IndetailDictionary = [appDel.pastOrdersAry objectAtIndex:indexPath.row];
//        }
        destViewController.IndetailDictionary = [tableArray objectAtIndex:indexPath.row];
        if (openPostSegment.selectedSegmentIndex == 1) {
            destViewController.isFrom=@"PastOrder";

        }
        else{
            destViewController.isFrom=@"OpenOrder";
 
        }
//        NSDictionary *dict = [tableArray objectAtIndex:indexPath.row];
//        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"selectedOrder"];
//        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ConfirmedInOrderState"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
        
        

    }else if ([segue.identifier isEqualToString:@"goToAddDishView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToDishesView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToReviewsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToReportsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goTosettingsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToSignInV"]) {
        [segue destinationViewController];
    }
}



@end
