//
//  DishReviewsVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/20/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "DishReviewsVC.h"
#import "TableViewCellH.h"
#import "UIImageView+WebCache.h"
#import "GlobalMethods.h"
#import "DishCommentsVC.h"
#import "CustomTableViewH.h"


@interface DishReviewsVC ()<CustomTableViewHDelegate>{
    CustomTableViewH *dropDownV;
    NSMutableArray *ReviewsArray;
    
    NSArray *tableReviewArr,*tableReviewArrCopy;
    


}

@end

@implementation DishReviewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationController.navigationBarHidden=YES;
    
    searchLayer = [[UIView alloc] initWithFrame:CGRectMake(0, _reviewDishTable.frame.origin.y+40, _reviewDishTable.frame.size.width, _reviewDishTable.frame.size.height)];
    searchLayer.userInteractionEnabled = NO;
    searchLayer.multipleTouchEnabled = NO;
    [self.view addSubview:searchLayer];
    searchLayer.hidden = YES;

    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardDR:)];
    [searchLayer addGestureRecognizer:tapGesture];
    
    
    search_bar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    search_bar.placeholder = @"Search for a Review";
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Medium" size:12.0f]}];

    

    
    SecondHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    SecondHeaderView.backgroundColor=[UIColor whiteColor];
    
    ReviewsArray = [[NSMutableArray alloc]initWithCapacity:0];

    
    
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    
    
    // 119,157,93
    self.reviewDishTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    if (self.fromNotificationDict!=nil) {
        NSError *e = nil;
        NSData *data=[[self.fromNotificationDict valueForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: &e];
        reviewId=[json valueForKey:@"action"];
        
        NSLog(@"array review id:%@",reviewId);
    }
}
-(void)viewDidAppear:(BOOL)animated{
    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    //    [paramDict setObject:@"{D2FC784F-00C0-1EC3-0417-4E360C04F510}" forKey:@"accessToken"];
    
    [self showCustomActivityIndicatorInReviews:YES];

    [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"restaurantDishlisting"];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [_reviewDishTable deselectRowAtIndexPath:[_reviewDishTable indexPathForSelectedRow] animated:YES];
//    _dishesAvaliableArray = [[NSMutableArray alloc]initWithCapacity:0];
//    _dishesUnAvaliableArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    /*
    [self showCustomActivityIndicatorInReviews:YES];
    
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    
    
    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    //    [paramDict setObject:@"{D6B0E705-78BB-676D-AD2E-21196BC84ECB}" forKey:@"accessToken"];
    
    [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"restaurantDishlisting"];
    
    
    */
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0)
    {
        return 40;
    }
    else{
        return 0;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section==0){
        search_bar.delegate=self;
        search_bar.searchBarStyle=UISearchBarStyleMinimal;
        return search_bar;
    }
    else{
        return 0;
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        return [tableReviewArr count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"DishesReviewCell";
    
    TableViewCellH *cell = (TableViewCellH *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    NSDictionary *dic=[tableReviewArr objectAtIndex:indexPath.row];
    
    
    
    
//    cell.reviewDescLbl.text = [dic valueForKey:@"description"];
    cell.reviewDescLbl.text = [dic valueForKey:@"review"];
    cell.reviewNameLbl.text = [NSString stringWithFormat:@"%@ %@",[dic valueForKey:@"first_name"],[dic valueForKey:@"last_name"]];
    cell.reviewOrderTypeLbl.text = [dic valueForKey:@"title"];
    
    if ([[dic valueForKey:@"review_comments"] count]==1) {
        cell.reviewCommentsLbl.text = [NSString stringWithFormat:@"%lu comment",(unsigned long)[[dic valueForKey:@"review_comments"] count]];
    }else{
        cell.reviewCommentsLbl.text = [NSString stringWithFormat:@"%lu comments",(unsigned long)[[dic valueForKey:@"review_comments"] count]];
    }
    if (reviewId!=nil) {
        if ([reviewId isEqualToString:[NSString stringWithFormat:@"%@",[dic valueForKey:@"review_id"]] ]) {
            cell.hilightLable.backgroundColor=[UIColor colorWithRed:99/255.0 green:157/255.0 blue:88/255.0 alpha:1];
            cell.highlightLable1.backgroundColor=[UIColor colorWithRed:99/255.0 green:157/255.0 blue:88/255.0 alpha:1];
        }
        else{
            cell.hilightLable.backgroundColor=[UIColor clearColor];
            cell.highlightLable1.backgroundColor=[UIColor clearColor];

        }
    }
    
    cell.reviewDateLbl.text = [self dateFormetForReviewTableCell:[dic valueForKey:@"date_added"]];
//    cell.reviewDateLbl.text = [dic valueForKey:@"date_added"];
//    cell.reviewRatingImg.image = [GlobalMethods starImagewithRating:[[dic valueForKey:@"dish_rating"] integerValue]];
    cell.reviewRatingImg.image = [GlobalMethods starImagewithRating:[[dic valueForKey:@"rating"] integerValue]];
    
    cell.reviewProfileImg.image=[UIImage imageNamed:@"Apple.png"];
    NSString *disturlStr=[NSString stringWithFormat:@"%@%@",ReviewImageUrl,[dic valueForKey:@"image"]];
    //         NSLog(@"Dish Image: %@", disturlStr);
    [cell.reviewProfileImg sd_setImageWithURL:[NSURL URLWithString:disturlStr] placeholderImage:[UIImage imageNamed:@"Apple.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        if(image==nil)
            cell.reviewProfileImg.image=[UIImage imageNamed:@"Apple.png"];
        else
            cell.reviewProfileImg.image = [GlobalMethods imageByScalingAndCroppingForSize:CGSizeMake(200,200) source:image];
    }];
    
    
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}


#pragma mark
#pragma mark - WebParsing Delegates
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{
    [self showCustomActivityIndicatorInReviews:NO];
    if (![[result valueForKey:@"error"] boolValue]) {
        [self reloadTheReviewsDataWithArray:[result valueForKey:@"data"]];
    }else{
        if ([[result valueForKey:@"code"] integerValue] == 104) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"There were no Reviews"];
        }else {
            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
        }
    }
}
-(void)reloadTheReviewsDataWithArray:(NSArray *)AARY{
    [ReviewsArray removeAllObjects];

    for (NSDictionary *dic in AARY) {
        if ([[dic valueForKey:@"reviews"] isKindOfClass:[NSArray class]] && [[dic valueForKey:@"reviews"] count]) {
            NSArray *BAry= [dic valueForKey:@"reviews"];
            for (int i=0; i<BAry.count; i++) {
                
                NSMutableDictionary *ddic=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic valueForKey:@"dish_id"],@"dish_id",[dic valueForKey:@"title"],@"title",[dic valueForKey:@"description"],@"description",[dic valueForKey:@"dish_rating"],@"dish_rating",[dic valueForKey:@"avail_by_date"],@"avail_by_date", nil];
                [ddic setValuesForKeysWithDictionary:[BAry objectAtIndex:i]];
                
                [ReviewsArray addObject:ddic];
            }
        }
    }
    if (ReviewsArray.count==0) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"There are no Reviews"];
        return;
    }
    tableReviewArr = ReviewsArray;
    tableReviewArrCopy = ReviewsArray;
    
    [_reviewDishTable reloadData];
    if (reviewId!=nil) {
        for (int i=0;i<tableReviewArr.count;i++){
            NSDictionary *dict=[tableReviewArr objectAtIndex:i];
                    NSString *OID=[NSString stringWithFormat:@"%@",[dict valueForKey:@"review_id"] ];
                    if ([OID isEqualToString:[NSString stringWithFormat:@"%@",reviewId]]) {
                        int rowToHighlight = i;
                        NSIndexPath * ndxPath= [NSIndexPath indexPathForRow:rowToHighlight inSection:1];
                        
                        [self.reviewDishTable scrollToRowAtIndexPath:ndxPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                    }
                }
            }
     
}
-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    [self showCustomActivityIndicatorInReviews:NO];
    NSLog(@"errorF = %@",errorH);
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
}



-(void)showCustomActivityIndicatorInReviews:(BOOL)mybool{
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
-(void)dismissKeyboardDR:(id)gesture{
    
    
    if (![search_bar.text length]) {
        tableReviewArr = [tableReviewArrCopy copy];
        [_reviewDishTable reloadData];
    }
    [search_bar resignFirstResponder];
    
    
}
-(NSString *)dateFormetForReviewTableCell:(NSString *)myStg{
    NSLog(@"myStg = %@",myStg);
    NSDateFormatter *Dform = [[NSDateFormatter alloc]init];
    [Dform setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *mDate = [Dform dateFromString:myStg];
    NSLog(@"mDate = %@",mDate);
    
    NSDateFormatter *D1form = [[NSDateFormatter alloc]init];
    [D1form setDateFormat:@"MM/dd/yyyy"];
    NSString *stg = [D1form stringFromDate:mDate];
    
    NSDateFormatter *D2form = [[NSDateFormatter alloc]init];
    [D2form setDateFormat:@"d"];
    int date_day = [[D2form stringFromDate:mDate] intValue];
    NSString *suffix_string = @"|st|nd|rd|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|st|nd|rd|th|th|th|th|th|th|th|st";
    NSArray *suffixes = [suffix_string componentsSeparatedByString: @"|"];
    NSString *suffix = [suffixes objectAtIndex:date_day];
    NSString *stg1;
    stg1 = [stg stringByReplacingOccurrencesOfString:@"." withString:suffix];
    
    
    NSLog(@"returnStg = %@",stg1);
    return stg1;
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    _reviewDishTable.scrollEnabled = NO;
    searchLayer.hidden = NO;
    
    searchLayer.backgroundColor=[UIColor blackColor];
    searchLayer.alpha=0.6;
    
    searchLayer.userInteractionEnabled = YES;
    searchLayer.multipleTouchEnabled = YES;
    
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    searchLayer.hidden = YES;
    _reviewDishTable.scrollEnabled = YES;
    searchLayer.userInteractionEnabled = NO;
    searchLayer.multipleTouchEnabled = NO;
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"Search clicked done reload table data");
    
    NSPredicate *pred1=[NSPredicate predicateWithFormat:@"first_name CONTAINS[c] %@ || title CONTAINS[c] %@",searchBar.text,searchBar.text];

    
    NSPredicate *compoundPredicate;
    
    
    NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:pred1, nil];
    compoundPredicate= [NSCompoundPredicate andPredicateWithSubpredicates:arr];
   
   
    
    tableReviewArr = [tableReviewArrCopy filteredArrayUsingPredicate:compoundPredicate];

    [_reviewDishTable reloadData];
    search_bar.text=searchBar.text;
    
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
        [self performToReloadViewController];
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

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.view endEditing:YES];

    if ([segue.identifier isEqualToString:@"goToDishReviewsComments"]) {
        NSIndexPath *indexPath = [_reviewDishTable indexPathForSelectedRow];
        DishCommentsVC *destinationVC=[segue destinationViewController];
        destinationVC.commentsDic = [ReviewsArray  objectAtIndex:indexPath.row];
    }else if ([segue.identifier isEqualToString:@"goToNewDishView"]){
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
    }
    
}
- (IBAction)pushBackBtn:(id)sender {
    
    if (![searchLayer isHidden]) {
        [self.view endEditing:YES];
        [self performSelector:@selector(dismissKeyboardDR:) withObject:nil];
    }else{
        [self.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
@end
