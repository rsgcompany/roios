//
//  DishCalendarVC.m
//  EnjoyFresh
//
//  Created by Siva  on 10/07/15.
//  Copyright (c) 2015 VrindaTech. All rights reserved.
//

#import "DishCalendarVC.h"
#import "ParserHClass.h"
#import "Global.h"
#import "GlobalMethods.h"



@interface DishCalendarVC ()<CKCalendarDelegate,parserHDelegate>{
    
    ParserHClass *webParser;

}

@property(nonatomic, strong) NSArray *disabledDates;

@property(nonatomic, strong) NSDateFormatter *dateFormatter;

@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) NSDate *minimumDate;


@end

@implementation DishCalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    
//    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
//    self.calendar = calendar;
//    calendar.delegate = self;
//    
//    
//    calendar.onlyShowCurrentMonth = NO;
//    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
//    self.calendar.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(205/255.0) blue:(100/255.0) alpha:1];
//    self.dateFormatter = [[NSDateFormatter alloc] init];
//    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
//    self.minimumDate = [self.dateFormatter dateFromString:@"20/09/2012"];
//    self.disabledDates = @[
//                           [self.dateFormatter dateFromString:@"05/01/2013"],
//                           [self.dateFormatter dateFromString:@"06/01/2013"],
//                           [self.dateFormatter dateFromString:@"07/01/2013"]
//                           ];
//    calendar.frame = CGRectMake(0,54, 320, 300);
//    [self.view addSubview:calendar];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    
    [self showCustomActivityIndicatorInOrders:YES];
    
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    self.datelabel.font=[UIFont fontWithName:@"Raleway-Bold" size:14.0f];
    
    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    //    [paramDict setObject:@"{D6B0E705-78BB-676D-AD2E-21196BC84ECB}" forKey:@"accessToken"];
    
   [paramDict setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginE_PProfile"] valueForKey:@"accessToken"] forKey:@"accessToken"];
    [paramDict setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginE_PProfile"] valueForKey:@"restaurant_id"] forKey:@"restaurant_id"];
    
    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"dishCalendar"];
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

- (IBAction)backBtn_Calendar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}

- (BOOL)dateIsDisabled:(NSDate *)date {
    for (NSDate *disabledDate in self.disabledDates) {
        if ([disabledDate isEqualToDate:date]) {
            return YES;
        }
    }
    return NO;
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

#pragma mark -
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // TODO: play with the coloring if we want to...
    if ([self dateIsDisabled:date]) {
        dateItem.textColor = [UIColor lightGrayColor];
    }
    
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return ![self dateIsDisabled:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
   
    NSDate *date1=date;
    NSArray * date2=[[self.dateFormatter stringFromDate:date] componentsSeparatedByString:@"/"];
    
    NSCalendar *calendar1 = [NSCalendar currentCalendar];
    NSInteger units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *components = [calendar1 components:units fromDate:date1];

    NSDateFormatter *weekDay = [[NSDateFormatter alloc] init];
    [weekDay setDateFormat:@"EEEE"];
    
    NSDateFormatter *calMonth = [[NSDateFormatter alloc] init];
    [calMonth setDateFormat:@"MMMM"];
    
    self.datelabel.text = [NSString stringWithFormat:@"%@,%@ %@",[weekDay stringFromDate:date1],[calMonth stringFromDate:date1],[date2 objectAtIndex:0]];
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    return YES;
}

- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame {
    NSLog(@"calendar layout: %@", NSStringFromCGRect(frame));
    self.datelabel.frame=CGRectMake(5, frame.size.height+54, 320, 30);
}
#pragma mark
#pragma mark - WebParsing Delegates
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{
    
    [self showCustomActivityIndicatorInOrders:NO];
    
    
    BOOL errMsg = [[result objectForKey:@"error"] boolValue];
    
    if (!errMsg) {
        //[appDel arrangeServiceInOrderWithResultArray:[result objectForKey:@"data"]];
        CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startSunday];
        self.calendar = calendar;
        calendar.delegate = self;
        
        
        calendar.onlyShowCurrentMonth = NO;
        calendar.adaptHeightToNumberOfWeeksInMonth = YES;
        self.calendar.backgroundColor=[UIColor colorWithRed:(154/255.0) green:(205/255.0) blue:(100/255.0) alpha:1];
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
        self.minimumDate = [self.dateFormatter dateFromString:@"20/09/2012"];
        self.disabledDates = @[
                               [self.dateFormatter dateFromString:@"05/01/2013"],
                               [self.dateFormatter dateFromString:@"06/01/2013"],
                               [self.dateFormatter dateFromString:@"07/01/2013"]
                               ];
        calendar.frame = CGRectMake(0,0, 320, 300);
        [self.scrollView addSubview:calendar];
        
    }else{
        [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result objectForKey:@"code"] integerValue]];
    }
    
    
}

-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    NSLog(@"errorF = %@",errorH);
    [self showCustomActivityIndicatorInOrders:NO];
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
}

@end
