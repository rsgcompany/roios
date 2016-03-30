//
//  DishCommentsVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/20/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "DishCommentsVC.h"
#import "TableViewCellH.h"
#import "GlobalMethods.h"
#import "CustomTableViewH.h"
#import "UIImageView+WebCache.h"
#import "ParserHClass.h"
#import "MBProgressHUD.h"

@interface DishCommentsVC ()<UITableViewDataSource,UITableViewDelegate,CustomTableViewHDelegate,parserHDelegate,MBProgressHUDDelegate,UITextFieldDelegate,UITextViewDelegate>{
    CustomTableViewH *dropDownV;
    ParserHClass *webParser;
    MBProgressHUD *hud;
    BOOL keyBoardHidden;
    NSMutableArray *tableArray;

}

@end

@implementation DishCommentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];

    
    _commentsReviewDateLbl.text = [self dateFormetForReviewTableCellC:[_commentsDic valueForKey:@"date_added"]];
    _commentReviewName.text = [_commentsDic valueForKey:@"first_name"];
    _commentReviewDecsLbl.text = [_commentsDic valueForKey:@"review"];
    _commentReviewNumberLbl.text = [NSString stringWithFormat:@"Comments [%lu]",(unsigned long)[[_commentsDic valueForKey:@"review_comments"] count]];
    _commentReviewRatingImg.image = [GlobalMethods starImagewithRating:[[_commentsDic valueForKey:@"rating"] integerValue]];
    
    NSString *reviewUrl=[NSString stringWithFormat:@"%@%@",ReviewImageUrl,[_commentsDic valueForKey:@"image"]];
    [_commentsProfilePic sd_setImageWithURL:[NSURL URLWithString:reviewUrl] placeholderImage:[UIImage imageNamed:@"Apple.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        if(image==nil)
            _commentsProfilePic.image=[UIImage imageNamed:@"Apple.png"];
        else
            _commentsProfilePic.image = [GlobalMethods imageByScalingAndCroppingForSize:CGSizeMake(200,200) source:image];
    }];

    
    tableArray = [[NSMutableArray alloc]initWithArray:[_commentsDic valueForKey:@"review_comments"]];
    
    _commentReviewNumberLbl.text = [NSString stringWithFormat:@"Comments [%lu]",(unsigned long)[tableArray count]];

    
    
    self.commentReviewTableV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;

    
    [self commentViewSetUp:YES];
    [self setUpKeyBoardNotification:YES];
    [self setUpTextFieldPaging:YES];
    
    [self.view bringSubviewToFront:_WriteACommentBtn];


}
-(void)setUpTextFieldPaging:(BOOL)mBool{    
    _commentTV.layer.cornerRadius = 1.5f;
    _commentTV.layer.borderWidth = 0.5f;
    _commentTV.layer.borderColor = [UIColor colorWithRed:150.0/255.0f green:150.0/255.0f blue:150.0/255.0f alpha:0.7].CGColor;
    
}
-(void)setUpKeyBoardNotification:(BOOL)mBool{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    keyBoardHidden = YES;
    [center addObserver:self selector:@selector(didShow) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(didHide) name:UIKeyboardWillHideNotification object:nil];
    

}


-(void)commentViewSetUp:(BOOL)myBool{
    
    _transparentBlackView.hidden = YES;
    UITapGestureRecognizer *tapG1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disMissTransparentV:)];
    [_transparentBlackView addGestureRecognizer:tapG1];
    
    _commentContainerView.frame = CGRectMake(15, self.view.bounds.size.height, _commentContainerView.bounds.size.width, _commentContainerView.bounds.size.height);
    [self.view addSubview:_commentContainerView];
    
    UITapGestureRecognizer *tapG2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disMissTransparentV:)];
    [_commentContainerView addGestureRecognizer:tapG2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableArray.count;
    //    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"DishesReviewCommentsCell";
    
    TableViewCellH *cell = (TableViewCellH *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    _commentReviewTableV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
   
    NSDictionary *dic = [tableArray objectAtIndex:indexPath.row] ;
    cell.commentReviewnameLbl.text = [NSString stringWithFormat:@"%@ %@",[dic valueForKey:@"first_name"],[dic valueForKey:@"last_name"]];
    cell.commentReviewDateLbl.text = [self dateFormetForReviewTableCellC:[dic valueForKey:@"date_added"]];
    cell.commentReviewComment.text = [dic valueForKey:@"comment"];
    
  
    cell.commentReviewProfImg.image = [UIImage imageNamed:@"addphoto.png"];
    if (appDel.CurrentOwnerDetails.owner_ProfilimageDic.count > 0){
    NSString *imgUrl = [appDel.CurrentOwnerDetails.owner_ProfilimageDic valueForKey:@"path_lg"];
    NSString *disturlStr=[NSString stringWithFormat:@"%@%@",RestaurentImageUrl,imgUrl];
    NSLog(@"url = %@",disturlStr);
        
        
        
    [cell.commentReviewProfImg sd_setImageWithURL:[NSURL URLWithString:disturlStr] placeholderImage:[UIImage imageNamed:@"addphoto.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
             if(image==nil)
                 cell.commentReviewProfImg.image=[UIImage imageNamed:@"addphoto.png"];
             else
                 cell.commentReviewProfImg.image = [GlobalMethods imageByScalingAndCroppingForSize:CGSizeMake(200,200) source:image];
         }];
    }else {
        cell.commentReviewProfImg.image = [UIImage imageNamed:@"addphoto.png"];
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
-(NSString *)dateFormetForReviewTableCellC:(NSString *)myStg{
    
    NSDateFormatter *Dform = [[NSDateFormatter alloc]init];
    [Dform setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *mDate = [Dform dateFromString:myStg];
   // [Dform setDateFormat:@"MMM d., YYYY, hh:mm a"];
    [Dform setDateFormat:@"MM/dd/YYYY"];

    NSString *stg = [Dform stringFromDate:mDate];
    [Dform setDateFormat:@"d"];
    int date_day = [[Dform stringFromDate:mDate] intValue];
    NSString *suffix_string = @"|st|nd|rd|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|st|nd|rd|th|th|th|th|th|th|th|st";
    NSArray *suffixes = [suffix_string componentsSeparatedByString: @"|"];
    NSString *suffix = [suffixes objectAtIndex:date_day];
    
    stg = [stg stringByReplacingOccurrencesOfString:@"." withString:suffix];
    
    
    
    return stg;
    
}

- (IBAction)pushBackButtonAction:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)writeACommentButtonAction:(id)sender {
    [self.view endEditing:YES];
    [self commentViewShow:YES];
}
-(void)commentViewShow:(BOOL)myBool{
    if (!myBool) {
        _transparentBlackView.hidden = YES;
        [UIView animateWithDuration:0.3f animations:^{
            _commentContainerView.frame = CGRectMake(15, self.view.bounds.size.height, _commentContainerView.bounds.size.width, _commentContainerView.bounds.size.height);
        } completion:nil];
    }else{
        _transparentBlackView.hidden = NO;
        [UIView animateWithDuration:0.3f animations:^{
            _commentContainerView.frame = CGRectMake(15, 150, _commentContainerView.bounds.size.width, _commentContainerView.bounds.size.height);
        } completion:nil];
    }
    
}
-(void)commentViewFrameBounce:(BOOL)myBool{
    if (!myBool) {
        [UIView animateWithDuration:0.3f animations:^{
            _commentContainerView.frame = CGRectMake(15, 150, _commentContainerView.bounds.size.width, _commentContainerView.bounds.size.height);
        } completion:nil];
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            _commentContainerView.frame = CGRectMake(15, 60, _commentContainerView.bounds.size.width, _commentContainerView.bounds.size.height);
        } completion:nil];
    }
}
-(void)disMissTransparentV:(id)sender{
    if (keyBoardHidden) {
        [self commentViewShow:NO];
    }else{
        [self commentViewFrameBounce:NO];
    }
    [self.view endEditing:YES];

}
- (IBAction)postCommentActionBlock:(id)sender {
    [self showCustomActivityIndicatorInComments:YES];
    [self.view endEditing:YES];
    
    
    
    NSCharacterSet *whitespaceE = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedE = [_commentTV.text stringByTrimmingCharactersInSet:whitespaceE];
    if ([trimmedE length] == 0) {
        // Text was empty or only whitespace.
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Comments cannot be blank"];
        [self showCustomActivityIndicatorInComments:NO];
        [_commentTV becomeFirstResponder];
        return;
    }
    
    
    if (_commentTV.text.length > 1 ) {
        NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
        [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
        [paramDict setObject:[_commentsDic valueForKey:@"review_id"] forKey:@"reviewId"];
        [paramDict setObject:_commentTV.text forKey:@"comment"];
        [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"submitComment"];
        
    }
    

}

//Resize your views in the below methods
- (void)didShow{
    keyBoardHidden = NO;
}

- (void)didHide{
    keyBoardHidden = YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self commentViewFrameBounce:YES];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // Prevent crashing undo bug – see note below.
    if (textView == _commentTV) {
        if(range.length + range.location > textView.text.length){
            return NO;
        }
        
        NSUInteger newLength = [textView.text length] + [text length] - range.length;
        
        return (newLength > 400) ? NO : YES;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    [textField resignFirstResponder];
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    [self commentViewFrameBounce:YES];
}
-(void)showCustomActivityIndicatorInComments:(BOOL)mybool{
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

#pragma mark
#pragma mark - WebParsing Delegates
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{
    [self showCustomActivityIndicatorInComments:NO];
    [self commentViewShow:NO];
    
    if (![[result valueForKey:@"error"] boolValue] ) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Saved successfully"];
        [self addCommentToTableView:YES];
        
    } else{
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:[result valueForKey:@"code"]];
    }
    
    
}
-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    [self showCustomActivityIndicatorInComments:NO];
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
}
-(void)addCommentToTableView:(BOOL)myBool{
    NSDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setValue:_commentTV.text forKey:@"comment"];
    [dic setValue:appDel.CurrentOwnerDetails.owner_first_name forKey:@"first_name"];
    [dic setValue:appDel.CurrentOwnerDetails.owner_last_name forKey:@"last_name"];
    
    NSDateFormatter *dateForm = [[NSDateFormatter alloc]init];
    [dateForm setDateFormat:@"YYYY-MMMM-dd HH:mm:ss"];
    NSString *dateStg = [dateForm stringFromDate:[NSDate date]];
    [dic setValue:dateStg forKey:@"date_added"];
        
    [tableArray addObject:dic];
    
    
    _commentTV.text = @"";
    _commentReviewNumberLbl.text = [NSString stringWithFormat:@"Comments [%lu]",(unsigned long)[tableArray count]];

    
    [_commentReviewTableV reloadData];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.view endEditing:YES];

    if ([segue.identifier isEqualToString:@"goToNewDishView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToOrdersView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToDishesView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToReportsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goTosettingsView"]){
        [segue destinationViewController];
    }
    else if ([segue.identifier isEqualToString:@"goToSignInV"]){
        [segue destinationViewController];
    }
}

@end
