//
//  AdvertiseDetailVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 2/19/15.
//  Copyright (c) 2015 VrindaTech. All rights reserved.
//

#import "AdvertiseDetailVC.h"
#import "Global.h"
#import "GlobalMethods.h"

@interface AdvertiseDetailVC ()<UIWebViewDelegate>

@end

@implementation AdvertiseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _advertiseWebView.delegate = self;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [_activIndicator startAnimating];
    NSString *urlStg = appDel.CurrentOwnerDetails.owner_pdf_advt;
    NSLog(@"Url = %@",urlStg);
    [_advertiseWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStg]]];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [_activIndicator stopAnimating];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:[error localizedDescription]];
    
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

- (IBAction)pushBackAction:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
