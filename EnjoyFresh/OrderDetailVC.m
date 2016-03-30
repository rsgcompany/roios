//
//  OrderDetailVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/7/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "OrderDetailVC.h"
#import "TableViewCellH.h"
#import "GlobalMethods.h"
#import "OrderConformVC.h"
#import "CustomTableViewH.h"
#import "SignInVC.h"

@interface OrderDetailVC ()<CustomTableViewHDelegate>{
    
    NSMutableArray *pendingArray,*confirmArray;
    NSMutableArray *pendingCheckmarkAry,*confirmcheckAry;
    CustomTableViewH *dropDownV;

    NSString *webDataFrom;
    
    UIImage *confrmButtonH;
    
    NSArray *tableArray;

}

@end

@implementation OrderDetailVC


- (IBAction)PushBack:(id)sender {
    
    
    if (![searchLayer isHidden]) {
        [self.view endEditing:YES];
        [self performSelector:@selector(dismissKeyboard:) withObject:nil];
    }else{
        [self.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }

}
-(void)dismissKeyboard:(id)gesture{
    
    if (![search_bar.text length]) {
        [self tableReloadDateAccordingToSegment];
    }
    [search_bar resignFirstResponder];
    
}
-(void)tableReloadDateAccordingToSegment{
    if (Segment.selectedSegmentIndex == 0) {
        tableArray = pendingArray;
    }else{
        tableArray = confirmArray;
    }
    _DetailTable.dataSource=self;
    _DetailTable.delegate=self;
    
    [_DetailTable reloadData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:YES];
    
    searchLayer = [[UIView alloc] initWithFrame:CGRectMake(0, _DetailTable.frame.origin.y+40, _DetailTable.frame.size.width, _DetailTable.frame.size.height)];
    searchLayer.userInteractionEnabled = NO;
    searchLayer.multipleTouchEnabled = NO;
    [self.view addSubview:searchLayer];
    searchLayer.hidden = YES;

    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [searchLayer addGestureRecognizer:tapGesture];
    
    
    pendingArray = [[NSMutableArray alloc]initWithCapacity:0];
    confirmArray = [[NSMutableArray alloc]initWithCapacity:0];
    

    pendingCheckmarkAry = [[NSMutableArray alloc]initWithCapacity:0];
    confirmcheckAry = [[NSMutableArray alloc]initWithCapacity:0];
    
    //    [self showCustomActivityIndicator:YES];
    
    _WebIdsPendingArray = [[NSMutableArray alloc]initWithCapacity:0];
    _WebIdsConfirmArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    search_bar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    search_bar.placeholder=@"Search by name or order";
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Medium" size:12.0f]}];
    
    [self setUpsecondHeaderView:YES];
    
        // openPostSegment.segmentedControlStyle = UISegmentedControlStyleBar;
    
   self.DetailTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
//    if ([self.isFrom isEqualToString:@"OpenOrder"]) {
//        Segment.hidden=YES;
//    }
    
}
-(void)setUpsecondHeaderView:(BOOL)myBool{
    SecondHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    SecondHeaderView.backgroundColor=[UIColor whiteColor];
    
    
    Segment = [[UISegmentedControl alloc] initWithItems:@[ @"PENDING", @"CONFIRMED"]];
    Segment.frame = CGRectMake(10, 10, 300, 25);
    
    
    [Segment addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    Segment.backgroundColor=[UIColor whiteColor];
    Segment.selectedSegmentIndex = 0;
    [GlobalMethods changeSegmentContrilTintColor:Segment];
    [SecondHeaderView addSubview:Segment];

    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [_DetailTable deselectRowAtIndexPath:[_DetailTable indexPathForSelectedRow] animated:YES];
    
    
//    _IndetailDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedOrder"];
    _OrderDishNameLBl.text = [_IndetailDictionary valueForKey:@"dish_title"];
    
    [self showCustomActivityIndicator:YES];

    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"ConfirmedInOrderState"]) {
        if (![NSJSONSerialization isValidJSONObject:[[_IndetailDictionary valueForKey:@"NextViewDic"] valueForKey:@"orders"]]) {
            [self showCustomActivityIndicator:NO];
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"No Orders"];
        }else{
            [self parseTheArray:[[_IndetailDictionary valueForKey:@"NextViewDic"]valueForKey:@"orders"]];
        }

    }else{
        [self performSelector:@selector(reloadDataWithSuccessCode:) withObject:nil afterDelay:1.0f];
    }
    
    

    
    
    
}
-(void)parseTheArray:(NSArray *)myArray{
    
     [pendingArray removeAllObjects];
    [confirmArray removeAllObjects];
    @try {
        for (int i=0; i<myArray.count; i++) {
            NSDictionary *dic=[myArray objectAtIndex:i];
            if (![[dic valueForKey:@"order_status"]  boolValue]) {
                [pendingArray addObject:dic];
            }else{
                [confirmArray addObject:dic];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"ERROR:%@",exception);
    }
    
    
    
    if(Segment.selectedSegmentIndex==0){
        tableArray = pendingArray;
        _tableCheckMarkAry = pendingCheckmarkAry;
        confrmButtonH = [UIImage imageNamed:@"confirmed_green.png"];
        
        
        [_WebIdsPendingArray removeAllObjects];
        [pendingCheckmarkAry removeAllObjects];
//        confrmButtonH = [UIImage imageNamed:@"confirmed_green.png"];
        
        
    }
    else{
        tableArray = confirmArray;
        _tableCheckMarkAry = confirmcheckAry;
        confrmButtonH = [UIImage imageNamed:@"confirmed.png"];
        
        
        [_WebIdsPendingArray removeAllObjects];
        [confirmcheckAry removeAllObjects];
//        confrmButtonH = [UIImage imageNamed:@"confirmed.png"];


    }
    [_markAllButton setTitle:@"Mark All" forState:UIControlStateNormal];

    
    [_DetailTable reloadData];
    [self showCustomActivityIndicator:NO];
    
}

-(void)MySegmentControlAction:(UISegmentedControl *)sender{
    [GlobalMethods changeSegmentContrilTintColor:sender];

    if ([search_bar.text length]) {
        [self searchBarSearchButtonClicked:search_bar];
        return;
    }
    
    
    
    if(sender.selectedSegmentIndex==0){
        
        tableArray = pendingArray;
        _tableCheckMarkAry = pendingCheckmarkAry;
        confrmButtonH = [UIImage imageNamed:@"confirmed_green.png"];
        
        
        [_ConfirmOrdersButton setTitle:@"Confirm Orders" forState:UIControlStateNormal];
    }
    else{
        tableArray = confirmArray;
        _tableCheckMarkAry = confirmcheckAry;
        confrmButtonH = [UIImage imageNamed:@"confirmed.png"];
        
        
        [_ConfirmOrdersButton setTitle:@"Change To Pending" forState:UIControlStateNormal];

    }
    
    if (_tableCheckMarkAry.count >0) {
        [_markAllButton setTitle:@"Unmark All" forState:UIControlStateNormal];
    }else{
        [_markAllButton setTitle:@"Mark All" forState:UIControlStateNormal];
        
    }
    
    [_DetailTable reloadData];

}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0){
        return 40;
    }
    else{
        if ([self.isFrom isEqualToString:@"OpenOrder"]) {
            return 0;
        }
        else{
            return 35;
 
        }

    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0){
        search_bar.delegate=self;
        search_bar.searchBarStyle=UISearchBarStyleMinimal;
        return search_bar;
    }
    else{
        if ([self.isFrom isEqualToString:@"OpenOrder"]) {
            return nil;
        }
        else{
            return SecondHeaderView;
          }
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        return tableArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"ItemDetailCell";    
    TableViewCellH *cell = (TableViewCellH *)[self.DetailTable dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[tableArray objectAtIndex:indexPath.row]];
    
    for (NSString * key in [dict allKeys]){
        if ([[dict objectForKey:key] isKindOfClass:[NSNull class]])
            [dict setObject:@"" forKey:key];
    }
    
    
    
    UIImage *img;
    NSDictionary *dic = dict;
    
    
    //Edited H
    if ([_tableCheckMarkAry containsObject:[dic valueForKey:@"order_id"]]) {
        img = [UIImage imageNamed:@"tick2IMG.png"];
    }else{
        img = [UIImage imageNamed:@"circleCheck.png"];
    }

    

    if ([[dic valueForKey:@"enable_completed_button"] boolValue]) {
//        cell.ConfirmBtn.enabled = YES;
//        cell.orderCheckMArkButton.enabled = YES;
        cell.checkmarkEnable = YES;
    }else{
//        cell.ConfirmBtn.enabled = NO;
//        cell.orderCheckMArkButton.enabled = NO;
        cell.checkmarkEnable = NO;
    }
    
    
    [cell.ConfirmBtn setImage:confrmButtonH forState:UIControlStateNormal];
    cell.checkMarkImg.image = img;
    
    cell.NameLbl.text =[NSString stringWithFormat:@"%@ %@ -#%@",[dic valueForKey:@"first_name"],[dic valueForKey:@"last_name"],[dic valueForKey:@"order_id"]];
    cell.idNumberStg = [dic valueForKey:@"order_id"];
    cell.DateLbl.text = [NSString stringWithFormat:@"Date:%@",[self dateFormetForReviewTableCell:[dic valueForKey:@"order_by_date"]]];
    cell.CostLblDetail.text = [NSString stringWithFormat:@"Total:$%.2f",[[dic valueForKey:@"dish_price"] floatValue] ];
    cell.order_Status = [dic valueForKey:@"order_status"];

    cell.orderVal_amountL.text = [NSString stringWithFormat:@"$%@ ($%@)",[dic valueForKey:@"order_value"],[dic valueForKey:@"amount_paid"]];

    
    return cell;
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

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    _DetailTable.scrollEnabled = NO;
    searchLayer.hidden = NO;
    
    searchLayer.backgroundColor=[UIColor blackColor];
    searchLayer.alpha=0.6;
    
    searchLayer.userInteractionEnabled = YES;
    searchLayer.multipleTouchEnabled = YES;
    
    
    
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    searchLayer.hidden = YES;
    _DetailTable.scrollEnabled = YES;
    searchLayer.userInteractionEnabled = NO;
    searchLayer.multipleTouchEnabled = NO;
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"Search clicked done reload table data");
    
    
    
    NSPredicate *pred1=[NSPredicate predicateWithFormat:@"order_id CONTAINS[c] %@ || first_name CONTAINS[c] %@",searchBar.text,searchBar.text];
    
    NSPredicate *compoundPredicate;
    
    
    NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:pred1, nil];
    compoundPredicate= [NSCompoundPredicate andPredicateWithSubpredicates:arr];
    if (Segment.selectedSegmentIndex ==0) {
        tableArray = [pendingArray filteredArrayUsingPredicate:compoundPredicate];
    }else{
        tableArray = [confirmArray filteredArrayUsingPredicate:compoundPredicate];
    }
    
    arr=nil;
    
    [_DetailTable reloadData];
    search_bar.text=searchBar.text;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CheckMarkButtonAction:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.DetailTable];
    NSIndexPath *indexPath = [self.DetailTable indexPathForRowAtPoint:buttonPosition];
    
    NSLog(@"%ld",(long)indexPath.row);

    if (indexPath != nil){
        
        TableViewCellH *cell = (TableViewCellH *)[_DetailTable cellForRowAtIndexPath:indexPath];
        if (!cell.checkmarkEnable) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Current time is less than Dish Available from time"];
            return;
        }
        
        
//        NSString *cellText = cell.textLabel.text;
        
        if (Segment.selectedSegmentIndex == 0) {
            if ([_WebIdsPendingArray containsObject:cell.idNumberStg]) {
                [_WebIdsPendingArray removeObject:cell.idNumberStg];
//                [pendingCheckmarkAry removeObject:[NSNumber numberWithInteger:indexPath.row]];
                [pendingCheckmarkAry removeObject:cell.idNumberStg];
                
                
                //Edited H
              

            }else{
                [_WebIdsPendingArray addObject:cell.idNumberStg];
//                [pendingCheckmarkAry addObject:[NSNumber numberWithInteger:indexPath.row]];
                [pendingCheckmarkAry addObject:cell.idNumberStg];

            }
            _tableCheckMarkAry = pendingCheckmarkAry;
            confrmButtonH = [UIImage imageNamed:@"confirmed_green.png"];

            
        }else{
            if ([_WebIdsConfirmArray containsObject:cell.idNumberStg]) {
                [_WebIdsConfirmArray removeObject:cell.idNumberStg];
//                [confirmcheckAry removeObject:[NSNumber numberWithInteger:indexPath.row]];
                [confirmcheckAry removeObject:cell.idNumberStg];
                
            }else{
                [_WebIdsConfirmArray addObject:cell.idNumberStg];
//                [confirmcheckAry addObject:[NSNumber numberWithInteger:indexPath.row]];
                [confirmcheckAry addObject:cell.idNumberStg];
            }
            _tableCheckMarkAry = confirmcheckAry;
            confrmButtonH = [UIImage imageNamed:@"confirmed.png"];

        }
        
        [_DetailTable reloadData];
    }
    
}
- (IBAction)MarkAllButtonAction:(id)sender {
    [self showCustomActivityIndicator:YES];
    
    if (Segment.selectedSegmentIndex == 0) {
        /*! Ckeck & Uncheck Depends upon markAllSelectedInSeg0 */
        if (!_markAllSelectedInSeg0) {
            int i = 0;
            for (NSMutableDictionary *dic in pendingArray) {
                if(![_WebIdsPendingArray containsObject:[dic valueForKey:@"order_id"]] && [[dic valueForKey:@"enable_completed_button"] boolValue] ){
                    [_WebIdsPendingArray addObject:[dic valueForKey:@"order_id"]];
//                    [pendingCheckmarkAry addObject:[NSNumber numberWithInt:i]];
                    [pendingCheckmarkAry addObject:[dic valueForKey:@"order_id"]];

                }
                i++;
            }
            _markAllSelectedInSeg0 = YES;
            
         
        }
        else{
            int i = 0;
            for (NSMutableDictionary *dic in pendingArray) {
                if([_WebIdsPendingArray containsObject:[dic valueForKey:@"order_id"]] && [[dic valueForKey:@"enable_completed_button"] boolValue]){
                    [_WebIdsPendingArray removeObject:[dic valueForKey:@"order_id"]];
//                    [pendingCheckmarkAry removeObject:[NSNumber numberWithInt:i]];
                    [pendingCheckmarkAry removeObject:[dic valueForKey:@"order_id"]];
                }
                i++;
            }
            _markAllSelectedInSeg0 = NO;
            
            
        }
        
        if (pendingCheckmarkAry.count>0) {
            [_markAllButton setTitle:@"Unmark All" forState:UIControlStateNormal];
        }else{
            [_markAllButton setTitle:@"Mark All" forState:UIControlStateNormal];
        }
        
        tableArray = pendingArray;
        _tableCheckMarkAry = pendingCheckmarkAry;
        confrmButtonH = [UIImage imageNamed:@"confirmed_green.png"];

    }
    
    
    else{
        if (!_markAllSelectedInSeg1) {
            int i = 0;
            for (NSMutableDictionary *dic in confirmArray) {
                if(![_WebIdsConfirmArray containsObject:[dic valueForKey:@"order_id"]]){
                    [_WebIdsConfirmArray addObject:[dic valueForKey:@"order_id"]];
//                    [confirmcheckAry addObject:[NSNumber numberWithInt:i]];
                    [confirmcheckAry addObject:[dic valueForKey:@"order_id"]];

                }
                i++;
            }
            _markAllSelectedInSeg1 = YES;

          
        }
        
        
        
        else{
            int i = 0;
            for (NSMutableDictionary *dic in confirmArray) {
                if([_WebIdsConfirmArray containsObject:[dic valueForKey:@"order_id"]]){
                    [_WebIdsConfirmArray removeObject:[dic valueForKey:@"order_id"]];
//                    [confirmcheckAry removeObject:[NSNumber numberWithInt:i]];
                    [confirmcheckAry removeObject:[dic valueForKey:@"order_id"]];
                }
                i++;
            }
            _markAllSelectedInSeg1 = NO;

        }
        
        if (confirmcheckAry.count>0) {
            [_markAllButton setTitle:@"Unmark All" forState:UIControlStateNormal];
        }else{
            [_markAllButton setTitle:@"Mark All" forState:UIControlStateNormal];
        }
        
        
        tableArray = confirmArray;
        _tableCheckMarkAry = confirmcheckAry;
        confrmButtonH = [UIImage imageNamed:@"confirmed.png"];

    }
    
    
    [_DetailTable reloadData];
    [self showCustomActivityIndicator:NO];
}
- (IBAction)ConfirmAllOrdersButtonAction:(id)sender {
//    [self showCustomActivityIndicator:YES];
    
    webDataFrom = @"confirmOrders";

    if (Segment.selectedSegmentIndex == 0) {
        if (_WebIdsPendingArray.count == 0) {
            return;
        }
        [self sentOrderDetaileToConformWithOrderIds:[self ArrayToJson:_WebIdsPendingArray] WithExtendedUrl:@"restaurantOrdersConfirmation"];
//        [_WebIdsPendingArray removeAllObjects];
//        [pendingCheckmarkAry removeAllObjects];
//        confrmButtonH = [UIImage imageNamed:@"confirmed_green.png"];
        

        
    }else{
        if (_WebIdsConfirmArray.count == 0) {
            return;
        }
        [self sentOrderDetaileToConformWithOrderIds:[self ArrayToJson:_WebIdsConfirmArray] WithExtendedUrl:@"restaurantOrdersPending"];
//        [_WebIdsPendingArray removeAllObjects];
//        [pendingCheckmarkAry removeAllObjects];
//        confrmButtonH = [UIImage imageNamed:@"confirmed.png"];

    }
    
    
//    [self.DetailTable reloadData];
    
}

- (IBAction)ConfirmCellButtonAction:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.DetailTable];
    NSIndexPath *indexPath = [self.DetailTable indexPathForRowAtPoint:buttonPosition];
    
    NSLog(@"%ld",(long)indexPath.row);
    
    if (indexPath != nil){
        
        TableViewCellH *cell = (TableViewCellH *)[_DetailTable cellForRowAtIndexPath:indexPath];
        //        NSString *cellText = cell.textLabel.text;
        if (!cell.checkmarkEnable) {
            return;
        }
        
        
        
        if (Segment.selectedSegmentIndex == 0) {
            if ([_WebIdsPendingArray containsObject:cell.idNumberStg]) {
                webDataFrom = @"confirmOrders";
                [self sentOrderDetaileToConformWithOrderIds:[self StringToJson:cell.idNumberStg] WithExtendedUrl:@"restaurantOrdersConfirmation"];
                [_WebIdsPendingArray removeObject:cell.idNumberStg];
//                [pendingCheckmarkAry removeObject:[NSNumber numberWithInteger:indexPath.row]];
                [pendingCheckmarkAry removeObject:cell.idNumberStg];
          }
            confrmButtonH = [UIImage imageNamed:@"confirmed_green.png"];

        }else{
            if ([_WebIdsConfirmArray containsObject:cell.idNumberStg]) {
                webDataFrom = @"confirmOrders";
                [self sentOrderDetaileToConformWithOrderIds:[self StringToJson:cell.idNumberStg] WithExtendedUrl:@"restaurantOrdersPending"];
                [_WebIdsConfirmArray removeObject:cell.idNumberStg];
//                [confirmcheckAry removeObject:[NSNumber numberWithInteger:indexPath.row]];
                [confirmcheckAry removeObject:cell.idNumberStg];
                
            }
            confrmButtonH = [UIImage imageNamed:@"confirmed.png"];

        }
        
        
        [self.DetailTable reloadData];

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
#pragma mark - WebParsing Sending Methods
-(NSString *)StringToJson:(NSString *)myOrderId{
    NSMutableDictionary *orderIdsDic = [NSMutableDictionary dictionaryWithObject:myOrderId forKey:@"0"];
    NSData *OrderIdjsonData = [NSJSONSerialization dataWithJSONObject:orderIdsDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *OrderIdjsonString = [[NSString alloc] initWithData:OrderIdjsonData encoding:NSUTF8StringEncoding];
    
    
    
    return OrderIdjsonString;
}
-(NSString *)ArrayToJson:(NSMutableArray *)myOrderIdsArray{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
    for (int i=0; i<myOrderIdsArray.count; i++) {
        NSString *key=[NSString stringWithFormat:@"%i",i];
        [dic setObject:[myOrderIdsArray objectAtIndex:i] forKey:key];
    }
    NSData *OrderIdjsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *OrderIdjsonString = [[NSString alloc] initWithData:OrderIdjsonData encoding:NSUTF8StringEncoding];
    
    
    return OrderIdjsonString;

}

-(void)sentOrderDetaileToConformWithOrderIds:(NSString *)myOrderIds WithExtendedUrl:(NSString *)myExtendedUrl{
    
    
    [self showCustomActivityIndicator:YES];
    
    
    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
//    [paramDict setObject:@"{D6B0E705-78BB-676D-AD2E-21196BC84ECB}" forKey:@"accessToken"];
//    [paramDict setObject:@"{35B7584D-A6C4-118D-53E1-3EF29F00BBF0}" forKey:@"accessToken"];
//    [paramDict setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"OwnerProfile"] objectForKey:@"accessToken"] forKey:@"accessToken"];
    
//    [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
    [paramDict setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginE_PProfile"] valueForKey:@"accessToken"] forKey:@"accessToken"];
//    [paramDict setObject:@"{D6B0E705-78BB-676D-AD2E-21196BC84ECB}" forKey:@"accessToken"];

    [paramDict setObject:myOrderIds forKey:@"orderIds"];
    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:myExtendedUrl];

    
//    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"restaurantOrdersConfirmation"];
}

-(void)showCustomActivityIndicator:(BOOL)mybool{
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
- (void)dataDidFinihLoadingwithResult:(NSDictionary *)result {
    NSLog(@"Error %@",result);
//    [self showCustomActivityIndicator:NO];
    
    
    if (![[result objectForKey:@"error"] boolValue]) {
        if ([webDataFrom isEqualToString:@"confirmOrders"]) {
            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result objectForKey:@"code"]integerValue]];
            
            [self performSelector:@selector(reloadDataWithSuccessCode:) withObject:result afterDelay:1.0f];
            
           
        }
        else if ([webDataFrom isEqualToString:@"ConfirmAllOrders"]){
            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result objectForKey:@"code"]integerValue]];
    
            [self performSelector:@selector(reloadWholeOrders:) withObject:result  afterDelay:1.0f];
            
            
        }
    }else{
        [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result objectForKey:@"code"]integerValue]];
//        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Responce Wrong"];
        [_DetailTable reloadData];
    }
    
    
    
    
}
- (void)reloadWholeOrders:(NSDictionary *)mydic {
    [appDel arrangeServiceInOrderWithResultArray:[mydic objectForKey:@"data"]];

    NSDictionary *MDic;
    if ([[_IndetailDictionary valueForKey:@"order_type"] isEqualToString:@"Past"]) {
        NSArray *arr=appDel.pastOrdersAry;
        for (NSDictionary *dic in appDel.pastOrdersAry) {
            if ([[dic valueForKey:@"dish_id"] isEqualToString:[_IndetailDictionary valueForKey:@"dish_id"]] && [[dic valueForKey:@"avail_by_date"] isEqualToString:[_IndetailDictionary valueForKey:@"avail_by_date"]]) {
                MDic = dic;
            }
        }
    }else{
        NSArray *arr=appDel.openOrdersAry;

        for (NSDictionary *dic in appDel.openOrdersAry) {
            if ([[dic valueForKey:@"dish_id"] isEqualToString:[_IndetailDictionary valueForKey:@"dish_id"]] && [[dic valueForKey:@"avail_by_date"] isEqualToString:[_IndetailDictionary valueForKey:@"avail_by_date"]]) {
                MDic = dic;
            }
        }
    }
    
    
    _IndetailDictionary = MDic;
    
    [self parseTheArray:[[_IndetailDictionary valueForKey:@"NextViewDic"] valueForKey:@"orders"]];

    
    
}
-(void)reloadDataWithSuccessCode:(NSDictionary *)myDictionary{
    
    
    
    
//    if ([[myDictionary objectForKey:@"code"]integerValue] == 106) {
//        [self showCustomActivityIndicator:YES];
    
    webDataFrom = @"ConfirmAllOrders";
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc]initWithCapacity:0];
    [paramDict setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginE_PProfile"] valueForKey:@"accessToken"] forKey:@"accessToken"];
    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"restaurantOrders"];
        
//        [self parseAndReloadData];
    
    
    
//    }else{
//        [self showCustomActivityIndicator:NO];
//        [_DetailTable reloadData];
//    }
    
    
    
    
    
   
//    [self showCustomActivityIndicator:NO];
}
-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    NSLog(@"errorF = %@",errorH);
    [self showCustomActivityIndicator:NO];

    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
    
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
        [self goToSignInViewLogout];
    }
    
    
    
}
-(void)goToSignInViewLogout{
    //    [self performSegueWithIdentifier:@"goToSignInView" sender:self];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginE_PProfile"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"OwnerProfile"];
    [appDel clearOwnerProfileClass];
//    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    SignInVC *SignInVC = [sb instantiateViewControllerWithIdentifier:@"SignInViewC"];
//    [self.navigationController popToViewController:SignInVC animated:YES];
    
    [self performSegueWithIdentifier:@"goToSignInV" sender:self];
    
}



#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.view endEditing:YES];
    if ([segue.identifier isEqualToString:@"goToConformOrder"]) {
        NSIndexPath *indexPath = [_DetailTable indexPathForSelectedRow];
        OrderConformVC *destViewController = segue.destinationViewController;
        
        
        NSLog(@"indexPath = %lii",(long)indexPath.row);
        
        if (Segment.selectedSegmentIndex == 0) {
            destViewController.ConformOrderDic = [tableArray objectAtIndex:indexPath.row];
            destViewController.conformOredrName = [_IndetailDictionary valueForKey:@"dish_title"];
            destViewController.isFrom = @"pendingState";
        }else{
            destViewController.ConformOrderDic = [tableArray objectAtIndex:indexPath.row];
            destViewController.conformOredrName = [_IndetailDictionary valueForKey:@"dish_title"];
            destViewController.isFrom = @"ConfomState";
        }
    
    
    }else if ([segue.identifier isEqualToString:@"goToAddDishView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToOrdersView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToDishesView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToReportsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goTosettingsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToSignInV"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToReviewsIndicator"]){
        [segue destinationViewController];
    }

}



@end
