//
//  DishCommentsVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/20/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DishCommentsVC : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *commentsProfilePic;
@property (strong, nonatomic) IBOutlet UILabel *commentReviewName;
@property (strong, nonatomic) IBOutlet UILabel *commentReviewDishName;
@property (strong, nonatomic) IBOutlet UILabel *commentsReviewDateLbl;
@property (strong, nonatomic) IBOutlet UILabel *commentReviewDecsLbl;
@property (strong, nonatomic) IBOutlet UILabel *commentReviewNumberLbl;

@property (strong, nonatomic) IBOutlet UITableView *commentReviewTableV;
@property (strong, nonatomic) IBOutlet UIImageView *commentReviewRatingImg;


@property (nonatomic,retain) NSDictionary *commentsDic;
- (IBAction)pushBackButtonAction:(id)sender;
- (IBAction)writeACommentButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *WriteACommentBtn;


- (IBAction)menuButtonAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *transparentBlackView;

@property (strong, nonatomic) IBOutlet UIView *commentContainerView;
@property (strong, nonatomic) IBOutlet UITextView *commentTV;
- (IBAction)postCommentActionBlock:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;



@end
