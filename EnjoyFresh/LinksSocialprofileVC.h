//
//  LinksSocialprofileVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/23/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinksSocialprofileVC : UIViewController



@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *WebTF;
@property (weak, nonatomic) IBOutlet UITextField *TwitterTF;
@property (weak, nonatomic) IBOutlet UITextField *FbTF;
@property (weak, nonatomic) IBOutlet UITextField *GooglePlusTF;
@property (weak, nonatomic) IBOutlet UITextField *YLTF;
@property (weak, nonatomic) IBOutlet UITextField *ULTF;


- (IBAction)menuButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;

@end
