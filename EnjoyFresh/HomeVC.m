//
//  HomeVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/5/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "HomeVC.h"
#import "AppDelegate.h"
#import "Global.h"
#import "ParserHClass.h"
#import "MBProgressHUD.h"
#import "GlobalMethods.h"
#import "OrdersVC.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface HomeVC ()<parserHDelegate,MBProgressHUDDelegate>{
    
    ParserHClass *webParser;
    MBProgressHUD *hud;

    int _contentWidth;
}
@property(nonatomic,retain) NSArray *imgsArr;
@property(nonatomic,retain) NSMutableArray *textBoxArr;



@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:YES];
    
    NSLog(@"Height = %f",[[UIScreen mainScreen] bounds].size.height);
    NSLog(@"Width = %f",[[UIScreen mainScreen] bounds].size.width);
    
    if(!IS_IPHONE5){
        
//        _scrollV.frame=CGRectMake(0, 0, 320, 480);
        _imgsArr=@[@"scrollBack14.png",@"scrollBack24.png",@"scrollBack34.png",@"scrollBack44.png"];
    }else{
        _imgsArr=@[@"scrollBack15.png",@"scrollBack25.png",@"scrollBack35.png",@"scrollBack45.png"];
    }

    
//    _imgsArr=@[@"scrollBack15.png",@"scrollBack25.png",@"scrollBack35.png",@"scrollBack45.png"];
    for (int i=0; i<[_imgsArr count]; i++){
        
        UIImageView *v = [[UIImageView alloc] init];
        v.image=[UIImage imageNamed:[_imgsArr objectAtIndex:i]];
        
        CGRect rect=v.frame;
        rect.origin.x=MainWidth*i;
        rect.origin.y=-20;
        
        rect.size.width = MainWidth;
        rect.size.height = self.view.bounds.size.height;
//        rect.size.height = 568;
        
        v.frame=rect;
        v.tag=i;
        _contentWidth = v.frame.size.height;
        
        [_scrollV addSubview:v];
        [_scrollV sendSubviewToBack:v];
    }
    _scrollV.contentSize = CGSizeMake(_imgsArr.count*MainWidth, 0);
    _pageControler.numberOfPages=[_imgsArr count];
    
    
    _textBoxArr=[[NSMutableArray alloc]init];
    ///// *** Set Multiple Colors and FOnts for Single UILable *** //////
    //////////string 1
    NSDictionary *font1 = [NSDictionary dictionaryWithObject:[UIFont fontWithName:Bold size:14.0f] forKey:NSFontAttributeName];
    
    
    NSMutableAttributedString *AattrString = [[NSMutableAttributedString alloc] initWithString:[homeStr1 uppercaseString] attributes: font1];
    [AattrString addAttribute:NSForegroundColorAttributeName value:red_Color range:NSMakeRange(11,4)];
    [AattrString addAttribute:NSForegroundColorAttributeName value:green_Color range:NSMakeRange(16,6)];
    [AattrString addAttribute:NSForegroundColorAttributeName value:red_Color range:NSMakeRange(26,8)];
    [AattrString addAttribute:NSForegroundColorAttributeName value:green_Color range:NSMakeRange(34,6)];
    
    
    NSDictionary *font2 = [NSDictionary dictionaryWithObject:[UIFont fontWithName:Light size:13.0f] forKey:NSFontAttributeName];
    
    NSMutableAttributedString *VattrString = [[NSMutableAttributedString alloc]initWithString: @"Become an EnjoyFresh member to get access to exclusive off-menu items and one of a kind culinary experiences.\n EnjoyFresh - The secret to dining out." attributes:font2];
    [VattrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:(NSMakeRange(0, [VattrString length]))];
    [AattrString appendAttributedString:VattrString];
    [_textBoxArr addObject:AattrString];
    _botomTxtLbl.attributedText = AattrString;
    
    //////////string 2
    AattrString = [[NSMutableAttributedString alloc] initWithString:[homeStr2 uppercaseString] attributes: font1];
    [AattrString addAttribute:NSForegroundColorAttributeName value:red_Color range:NSMakeRange(8,3)];
    [AattrString addAttribute:NSForegroundColorAttributeName value:green_Color range:NSMakeRange(12,4)];
    VattrString = [[NSMutableAttributedString alloc]initWithString: @"From Dive Bars to Michelin Stars, a swipe of your thumb will have you discovering unique dishes around you " attributes:font2];
    [VattrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:(NSMakeRange(0, [VattrString length]))];
    [AattrString appendAttributedString:VattrString];
    [_textBoxArr addObject:AattrString];
    
    
    //////////string 3
    AattrString = [[NSMutableAttributedString alloc] initWithString:[homeStr3 uppercaseString] attributes: font1];
    [AattrString addAttribute:NSForegroundColorAttributeName value:red_Color range:NSMakeRange(8,6)];
    [AattrString addAttribute:NSForegroundColorAttributeName value:green_Color range:NSMakeRange(15,3)];
    VattrString = [[NSMutableAttributedString alloc]initWithString: @"Order through your mobile phone and EnjoyFresh at the restaurant\n\n" attributes:font2];
    [VattrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:(NSMakeRange(0, [VattrString length]))];
    [AattrString appendAttributedString:VattrString];
    [_textBoxArr addObject:AattrString];
    
    
    //////////string 4
    AattrString = [[NSMutableAttributedString alloc] initWithString:[homeStr4 uppercaseString] attributes: font1];
    [AattrString addAttribute:NSForegroundColorAttributeName value:red_Color range:NSMakeRange(10,5)];
    [AattrString addAttribute:NSForegroundColorAttributeName value:green_Color range:NSMakeRange(16,6)];
    VattrString = [[NSMutableAttributedString alloc]initWithString: @"Start discovering inspired chefs\n\n" attributes:font2];
    [VattrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:(NSMakeRange(0, [VattrString length]))];
    [AattrString appendAttributedString:VattrString];
    [_textBoxArr addObject:AattrString];
    
    _ContincueAsGuestBtn.titleLabel.font=[UIFont fontWithName:Regular size:14];
    
    _botomTxtLbl.numberOfLines = 5;
    [_botomTxtLbl sizeToFit];
    
    
    ///////
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @" asdn asdf nsidias";
    
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    // User authenticated successfully, take appropriate action
                                } else {
                                    // User did not authenticate successfully, look at error and take appropriate action
                                }
                            }];
    } else {
        // Could not evaluate policy; look at authError and present an appropriate message to user
    }
   
}
-(void)viewDidAppear:(BOOL)animated{
    
    [self showCustomActivityIndicatorInHome:YES];
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    [webParser parserJsonDataFromUrlString:RestaurentCategoriesUrl];

    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"LoginE_PProfile"]) {
        [self performSegueWithIdentifier:@"goToOrdersView" sender:self];
    }

}
-(void)showCustomActivityIndicatorInHome:(BOOL)mybool{
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
//    [appDel.cuisineAry removeAllObjects];
//    [appDel.cuisineAry addObjectsFromArray:[[result objectForKey:@"message"] valueForKey:@"title"]];

    
    [self showCustomActivityIndicatorInHome:NO];
    if (![[result valueForKey:@"error"] boolValue]) {
//        [appDel.cuisineAry removeAllObjects];
        
        NSArray *SortAry = [GlobalMethods sortArrayDictionaryInAscendingOrderWithArray:[result valueForKey:@"message"] WithKey:@"title"];        
        appDel.cuisineAry = [NSMutableArray arrayWithArray:SortAry];
        
        
        
        [appDel removeCusinesFromCusineArray:appDel.cuisineAry WithComparingArray:appDel.CurrentOwnerDetails.owner_cuisineArray];
    }
    
}
-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    NSLog(@"Error Occuresd  = %@",errorH);
    [self showCustomActivityIndicatorInHome:NO];
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
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



- (IBAction)registerButtonAction:(id)sender {
}

- (IBAction)Continue_Guest_Clicked:(id)sender {
}




#pragma mark -
#pragma mark - ScrollView Delegate Methods
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _scrollV.frame.size.width; // you need to have a **iVar** with getter for scrollView
    float fractionalPage = _scrollV.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    _pageControler.currentPage = page; // you need to have a **iVar** with getter for pageControl
    
    switch (page) {
        case 0:
            _botomTxtLbl.numberOfLines = 5;
            break;
            
        default:
            _botomTxtLbl.numberOfLines = 5;
            break;
    }
    
    _botomTxtLbl.attributedText = [_textBoxArr objectAtIndex:page];
    
    //[botomTxtLbl sizeToFit];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.view endEditing:YES];

    if ([segue.identifier isEqualToString:@"goToOrdersView"]) {
        OrdersVC *VC = [segue destinationViewController];
        VC.isFrom = @"SignInView";
    }
}


@end
