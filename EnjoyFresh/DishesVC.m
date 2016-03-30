//
//  DishesVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/19/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "DishesVC.h"
#import "TableViewCellH.h"
#import "ParserHClass.h"
#import "GlobalMethods.h"
#import "DishReviewsVC.h"
#import "Global.h"
#import "AddDishVC.h"
#import "UIImageView+WebCache.h"
#import "CustomTableViewH.h"

@interface DishesVC ()<parserHDelegate,CustomTableViewHDelegate>{
    ParserHClass *webParser;
    NSArray *dishesArr;
    
    CustomTableViewH *dropDownV;

    NSArray *tableArray;

}

@end

@implementation DishesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationController.navigationBarHidden=YES;
    
    searchLayer = [[UIView alloc] initWithFrame:CGRectMake(0, _DishesTable.frame.origin.y+40, _DishesTable.frame.size.width, _DishesTable.frame.size.height)];
    searchLayer.userInteractionEnabled = NO;
    searchLayer.multipleTouchEnabled = NO;
    [self.view addSubview:searchLayer];
    searchLayer.hidden = YES;
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardD:)];
    [searchLayer addGestureRecognizer:tapGesture];
    
    
    search_bar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    search_bar.placeholder = @"Search for a dish";
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Medium" size:12.0f]}];

    
    [self setUpSecondHeaderView:YES];
    
    
    // 119,157,93
    
    //openPostSegment.selectedSegmentIndex=1;
    
    self.DishesTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    
    _DishesTable.dataSource=self;
    _DishesTable.delegate=self;

}

-(void)viewWillAppear:(BOOL)animated{



    [_DishesTable deselectRowAtIndexPath:[_DishesTable indexPathForSelectedRow] animated:YES];
    _dishesAvaliableArray = [[NSMutableArray alloc]initWithCapacity:0];
    _dishesUnAvaliableArray = [[NSMutableArray alloc]initWithCapacity:0];

    
    [self showCustomActivityIndicatorInOrders:YES];
    
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    
    
    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    //    [paramDict setObject:@"{D6B0E705-78BB-676D-AD2E-21196BC84ECB}" forKey:@"accessToken"];
    
    [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"restaurantDishlisting"];
    
    

    

}
-(void)setUpSecondHeaderView:(BOOL)myBool{
    SecondHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    SecondHeaderView.backgroundColor=[UIColor whiteColor];
    
    
    openPostSegment = [[UISegmentedControl alloc] initWithItems:@[@"AVAILABLE  DISHES", @"UNAVAILABLE  DISHES"]];
    openPostSegment.frame = CGRectMake(10, 10, 300, 25);
    
    [openPostSegment addTarget:self action:@selector(MySegmentControlActionD:) forControlEvents: UIControlEventValueChanged];
    openPostSegment.backgroundColor=[UIColor whiteColor];
    if (self.fromNotifications) {
        openPostSegment.selectedSegmentIndex = 1;
        self.fromNotifications=NO;
    }
    else{
        openPostSegment.selectedSegmentIndex = 0;
    }
    [GlobalMethods changeSegmentContrilTintColor:openPostSegment];
    [SecondHeaderView addSubview:openPostSegment];

}

-(void)dismissKeyboardD:(id)gesture{
    if (![search_bar.text length]) {
        [self tableReloadDateAccordingToSegmentD];
    }
    [search_bar resignFirstResponder];
}

-(void)MySegmentControlActionD:(UISegmentedControl *)sender{
    [GlobalMethods changeSegmentContrilTintColor:sender];

    if ([search_bar.text length]) {
        [self searchBarSearchButtonClicked:search_bar];
        return;
    }
    
    
    
    if(sender.selectedSegmentIndex==0){
        
        NSLog(@"Load OPEN ORDERS");
        tableArray = _dishesAvaliableArray;
        
    }
    else{
        NSLog(@"Load POST ORDERS");
        tableArray = _dishesUnAvaliableArray;
        
        
        
    }
    _DishesTable.dataSource=self;
    _DishesTable.delegate=self;
    
    [_DishesTable reloadData];
    
}

-(void)tableReloadDateAccordingToSegmentD{
    if (openPostSegment.selectedSegmentIndex == 0) {
        tableArray = _dishesAvaliableArray;
    }else{
        tableArray = _dishesUnAvaliableArray;
    }
    _DishesTable.dataSource=self;
    _DishesTable.delegate=self;
    
    [_DishesTable reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0)
    {
        return 40;
    }
    else{
        return 40;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section==0){
        search_bar.delegate=self;
        search_bar.searchBarStyle=UISearchBarStyleMinimal;
        return search_bar;
    }
    else{
        return SecondHeaderView;
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
    
    static NSString *CellIdentifier = @"DishesCell";
    TableViewCellH *cell = (TableViewCellH *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    
    
    NSDictionary *dic = [tableArray objectAtIndex:indexPath.row];
    
    
    cell.dishnameLbl.text = [dic valueForKey:@"title"];
    cell.dishPriceLbl.text = [NSString stringWithFormat:@"$ %@",[dic valueForKey:@"price"]];
    cell.dishReviewLbl.text = [NSString stringWithFormat:@"%i reviews",(int)[[dic valueForKey:@"reviews"] count]];
    
    if ([[dic valueForKey:@"reviews"] count] == 0) {
        cell.dishReviewLbl.text = @"Not rated yet.";
    }
    
    cell.dishStarImg.image = [GlobalMethods starImagewithRating:[[dic valueForKey:@"dish_rating"] integerValue]];
    
    
    cell.dishImageV.image=[UIImage imageNamed:@"Apple.png"];
    
    
    
    
    if ([[dic valueForKey:@"images"] count] > 0 &&
        [[[dic valueForKey:@"images"] valueForKey:@"default"] containsObject:@"1"]) {
            for (NSDictionary *dDic in [dic valueForKey:@"images"]) {
                if ([[dDic valueForKey:@"default"] boolValue]) {
                    
                    NSString *disturlStr=[NSString stringWithFormat:@"%@%@",DishImageUrl,[dDic valueForKey:@"path_lg"]];
                    NSURL *urls = [NSURL URLWithString:disturlStr];
                    [cell.dishImageV sd_setImageWithURL:urls placeholderImage:[UIImage imageNamed:@"Apple.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
                     {
                         if(image==nil)
                             cell.dishImageV.image=[UIImage imageNamed:@"Apple.png"];
                         else
                             cell.dishImageV.image = [GlobalMethods imageByScalingAndCroppingForSize:CGSizeMake(200,200) source:image];
                     }];
                }
            }
    }
    else if ([[dic valueForKey:@"images"] count] > 0 &&
             ![[[dic valueForKey:@"images"] valueForKey:@"default"] containsObject:@"1"]){
        NSString *disturlStr=[NSString stringWithFormat:@"%@%@",DishImageUrl,[[[dic valueForKey:@"images"] valueForKey:@"path_lg"] lastObject]];
        NSURL *urls = [NSURL URLWithString:disturlStr];
        [cell.dishImageV sd_setImageWithURL:urls placeholderImage:[UIImage imageNamed:@"Apple.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             if(image==nil)
                 cell.dishImageV.image=[UIImage imageNamed:@"Apple.png"];
             else
                 cell.dishImageV.image = [GlobalMethods imageByScalingAndCroppingForSize:CGSizeMake(200,200) source:image];
         }];

    }else{
        cell.dishImageV.image=[UIImage imageNamed:@"Apple.png"];
    }
    

    

//    id img=[dic valueForKey:@"images"];
//    NSDictionary *locDict;
//    if ([img isKindOfClass:[NSArray class]]){
//        NSArray *art=[dic valueForKey:@"images"];
//        if ([art count]) {
//            locDict=[art objectAtIndex:0];
//        }
//    }
//    else{
//        locDict=[dic valueForKey:@"images"];
//    }
//    
//    if([ locDict count]!=0)
//    {
//        
//        NSString *disturlStr=[NSString stringWithFormat:@"%@%@",DishImageUrl,[locDict valueForKey:@"path_lg"]];
//        
//         NSLog(@"Dish Image: %@", disturlStr);
//        
//        [cell.dishImageV sd_setImageWithURL:[NSURL URLWithString:disturlStr] placeholderImage:[UIImage imageNamed:@"Apple.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
//         {
//             if(image==nil)
//                 cell.dishImageV.image=[UIImage imageNamed:@"Apple.png"];
//             else
//                 cell.dishImageV.image = [GlobalMethods imageByScalingAndCroppingForSize:CGSizeMake(200,200) source:image];
//         }];
//        
//      
//    }

    
    
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



- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    _DishesTable.scrollEnabled = NO;
    searchLayer.hidden = NO;
    
    searchLayer.backgroundColor=[UIColor blackColor];
    searchLayer.alpha=0.6;
    
    searchLayer.userInteractionEnabled = YES;
    searchLayer.multipleTouchEnabled = YES;
    
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    searchLayer.hidden = YES;
    _DishesTable.scrollEnabled = YES;
    searchLayer.userInteractionEnabled = NO;
    searchLayer.multipleTouchEnabled = NO;
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
        
    NSLog(@"Search clicked done reload table data");
    NSPredicate *pred1=[NSPredicate predicateWithFormat:@"dish_id CONTAINS[c] %@ || title CONTAINS[c] %@",searchBar.text,searchBar.text];
    
    NSPredicate *compoundPredicate;
    
    
    NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:pred1, nil];
    compoundPredicate= [NSCompoundPredicate andPredicateWithSubpredicates:arr];
    if (openPostSegment.selectedSegmentIndex ==0) {
        tableArray = [_dishesAvaliableArray filteredArrayUsingPredicate:compoundPredicate];
    }else{
        tableArray = [_dishesUnAvaliableArray filteredArrayUsingPredicate:compoundPredicate];
    }
    
    arr=nil;
    
    [_DishesTable reloadData];
    search_bar.text=searchBar.text;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark
#pragma mark - ActivityIndicator
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

#pragma mark
#pragma mark - WebParsing Delegates
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{
    [self showCustomActivityIndicatorInOrders:NO];
    
    if (![[result valueForKey:@"error"] boolValue]) {
        dishesArr =[result valueForKey:@"data"];
        [self parsingdataWithArray:[result valueForKey:@"data"]];
    }else{
        [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
    }
}
-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    [self showCustomActivityIndicatorInOrders:NO];
    NSLog(@"errorF = %@",errorH);
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
}

-(void)parsingdataWithArray:(NSArray *)myarray{
    for (NSDictionary *dic in myarray) {
//        if ([[dic valueForKey:@"available"] isEqualToString:@"0"]) {
        if (![[dic valueForKey:@"dish_status"] boolValue]) {
            [_dishesUnAvaliableArray addObject:dic];
        }else{
            [_dishesAvaliableArray addObject:dic];
        }
    }
    
    
    if (openPostSegment.selectedSegmentIndex == 0) {
        tableArray = _dishesAvaliableArray;
    }else{
        tableArray = _dishesUnAvaliableArray;
    }
    
    [_DishesTable reloadData];

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
        [self performSegueWithIdentifier:@"goToNewDishView" sender:self];
    }else if(myIndexPath.row == 2){
        [self performSegueWithIdentifier:@"goToOrdersView" sender:self];
    }else if (myIndexPath.row == 3){
        [self performToReloadViewController];
    }else if (myIndexPath.row == 4){
        [self performSegueWithIdentifier:@"goToReviewsView" sender:self];
    }else if (myIndexPath.row == 5) {
        [self performSegueWithIdentifier:@"goToReportsView" sender:self];
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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.view endEditing:YES];

    if ([segue.identifier isEqualToString:@"goToEditDish"]) {
        NSIndexPath *indexPath = [_DishesTable indexPathForSelectedRow];
        
        
        AddDishVC *dest = [segue destinationViewController];
//        if (openPostSegment.selectedSegmentIndex == 0) {
//            dest.dishDetailDict = [_dishesAvaliableArray objectAtIndex:indexPath.row];
//            
//        }else{
//            dest.dishDetailDict = [_dishesUnAvaliableArray objectAtIndex:indexPath.row];
//        }
        
        
        dest.dishDetailDict = [tableArray objectAtIndex:indexPath.row];
        
        
//        dest.isFromView = @"DishesView";
        
        
        
        
        
//        DishReviewsVC *destinationVC=[segue destinationViewController];
//        if (openPostSegment.selectedSegmentIndex == 0) {
//            destinationVC.destDec = [_dishesAvaliableArray objectAtIndex:indexPath.row];
//        }else{
//            destinationVC.destDec = [_dishesUnAvaliableArray objectAtIndex:indexPath.row];
//        }
    }else if ([segue.identifier isEqualToString:@"goToNewDishView"]){
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



- (IBAction)pushBackBtnAction:(id)sender {
    
    
    
    if (![searchLayer isHidden]) {
        [self.view endEditing:YES];
        [self performSelector:@selector(dismissKeyboardD:) withObject:nil];
    }else{
        [self.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }

}
@end
