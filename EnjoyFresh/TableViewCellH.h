//
//  TableViewCellH.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/6/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCellH : UITableViewCell


//Settings Page TableView Cell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



//Order TableView Cell
@property (weak, nonatomic) IBOutlet UIImageView *RestaurantImage;
@property (weak, nonatomic) IBOutlet UILabel *ItemNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *RemainingLlb;
@property (weak, nonatomic) IBOutlet UILabel *ReceivedDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *CostLbl;
@property (nonatomic,retain) NSDictionary *orderDetailDic;



//Order DetailTableViewCell
@property (strong, nonatomic) IBOutlet UIButton *orderCheckMArkButton;
@property (strong, nonatomic) IBOutlet UIImageView *checkMarkImg;

@property (weak, nonatomic) IBOutlet UILabel *NameLbl;
@property (weak, nonatomic) IBOutlet UILabel *DateLbl;
@property (weak, nonatomic) IBOutlet UILabel *CostLblDetail;
@property (weak, nonatomic) IBOutlet UIButton *ConfirmBtn;
@property (nonatomic) BOOL checkmarkEnable;

@property (nonatomic,retain) NSString *idNumberStg;
@property (nonatomic,retain) NSString *order_Status;
@property (strong, nonatomic) IBOutlet UILabel *orderVal_amountL;




//Dishes TableCell
@property (strong, nonatomic) IBOutlet UILabel *dishnameLbl;
@property (strong, nonatomic) IBOutlet UIImageView *dishImageV;
@property (strong, nonatomic) IBOutlet UILabel *dishReviewLbl;
@property (strong, nonatomic) IBOutlet UILabel *dishPriceLbl;
@property (strong, nonatomic) IBOutlet UIImageView *dishStarImg;

//DishesReviews cell
@property (strong, nonatomic) IBOutlet UIImageView *reviewProfileImg;
@property (strong, nonatomic) IBOutlet UILabel *reviewNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *reviewOrderTypeLbl;
@property (strong, nonatomic) IBOutlet UILabel *reviewDescLbl;
@property (strong, nonatomic) IBOutlet UILabel *reviewCommentsLbl;
@property (strong, nonatomic) IBOutlet UILabel *reviewDateLbl;
@property (strong, nonatomic) IBOutlet UIImageView *reviewRatingImg;


//Dish Order comment Tableview cell
@property (strong, nonatomic) IBOutlet UIImageView *commentReviewProfImg;
@property (strong, nonatomic) IBOutlet UILabel *commentReviewnameLbl;
@property (strong, nonatomic) IBOutlet UILabel *commentReviewDateLbl;
@property (strong, nonatomic) IBOutlet UILabel *commentReviewComment;



// for Types Of cuisine TableViewCell
@property (weak, nonatomic) IBOutlet UILabel *DishName;



// for Reports Tableview section
@property (strong, nonatomic) IBOutlet UILabel *sectionNameC;
@property (strong, nonatomic) IBOutlet UIView *sectionContainerV;
@property (strong, nonatomic) IBOutlet UIView *sectionPaymentContainerV;

// for Reports TableView Cell
@property (strong, nonatomic) IBOutlet UILabel *dishNameC;

@property (strong, nonatomic) IBOutlet UILabel *dishQuantityC;
@property (strong, nonatomic) IBOutlet UILabel *dishTaxC;
@property (strong, nonatomic) IBOutlet UILabel *dishTotalSalesC;
@property (strong, nonatomic) IBOutlet UILabel *dishNetRevenue;
@property (strong, nonatomic) IBOutlet UILabel *dishPaymentAmountL;
@property (strong, nonatomic) IBOutlet UILabel *dishPaymentTypeL;


// For ReportDetail Tableview Section
@property (strong, nonatomic) IBOutlet UILabel *RDSectionNameC;



// For ReportDetail Tableview Cell
@property (strong, nonatomic) IBOutlet UILabel *RDOrderedByL;

@property (strong, nonatomic) IBOutlet UILabel *ROrderIDL;
@property (strong, nonatomic) IBOutlet UILabel *RDOrderQuantityL;
@property (strong, nonatomic) IBOutlet UILabel *RDOrdervalueL;
@property (strong, nonatomic) IBOutlet UILabel *RDOrderFeesL;
@property (strong, nonatomic) IBOutlet UILabel *RDOrdertaxL;



//add EditDish Ingredient Table cell

@property (strong, nonatomic) IBOutlet UITextField *ingredientsTfield;
@property (strong, nonatomic) IBOutlet UIButton *ingredientRemoveBtn;
@property (strong, nonatomic) IBOutlet UIButton *addIngredientsBtn;

@property (strong, nonatomic) IBOutlet UILabel *hilightLable;
@property (strong, nonatomic) IBOutlet UILabel *highlightLable1;



@end
