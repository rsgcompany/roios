//
//  EditDishVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 2/7/15.
//  Copyright (c) 2015 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "IBActionSheet.h"



@interface EditDishVC : UIViewController<MBProgressHUDDelegate>{
    NSInteger currentTFTag;
    MBProgressHUD *hud;
    
}
@property IBActionSheet *CustomActionSheet;


@property (strong, nonatomic) IBOutlet UIButton *backButton;

- (IBAction)backButtonAction_dishes:(id)sender;
- (IBAction)addPhotoButtonBlock:(id)sender;
- (IBAction)AddPhoto1ButtonBlock:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *navigationTitleLbl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UITextField *dishNameTF;
@property (strong, nonatomic) IBOutlet UITextField *dishPriceTF;
@property (strong, nonatomic) IBOutlet UITextField *dishQuantityTF;
@property (strong, nonatomic) IBOutlet UITextView *dishDescriptionTView;
@property (strong, nonatomic) IBOutlet UILabel *dishCategoryLBL;
@property (strong, nonatomic) IBOutlet UILabel *dishOrderedByLBL;
@property (strong, nonatomic) IBOutlet UILabel *dishAvaliableByLBL;
@property (strong, nonatomic) IBOutlet UILabel *dishAvaliableUntilTF;
@property (strong, nonatomic) IBOutlet UIButton *addPhotoBtn;
@property (strong, nonatomic) IBOutlet UIButton *gallaryBtn;
@property (strong, nonatomic) IBOutlet UIButton *gallaryBtn1;
@property (strong, nonatomic) IBOutlet UILabel *inStockLbl;


@property (strong, nonatomic) NSDictionary *dishDetailDict;
@property (strong, nonatomic) NSMutableDictionary *ingredientsDict;
@property (nonatomic) BOOL isVegetarian;
@property (nonatomic) BOOL isGlutineFree;
@property (nonatomic) BOOL isVegan;
@property (nonatomic) BOOL isOrganic;
@property (nonatomic) BOOL isLocalIngradients;
@property (nonatomic) BOOL isAvaliable;



@property (strong, nonatomic) IBOutlet UIView *additionalContainerView;



@property (strong, nonatomic) IBOutlet UISwitch *vegetarianButton;
@property (strong, nonatomic) IBOutlet UISwitch *glutenFreeButton;
@property (strong, nonatomic) IBOutlet UISwitch *veganButton;
@property (strong, nonatomic) IBOutlet UISwitch *organicButton;
@property (strong, nonatomic) IBOutlet UISwitch *localIngredientsButton;
@property (strong, nonatomic) IBOutlet UISwitch *avaliableButton;

- (IBAction)VeretarianSwitchActionBlock:(id)sender;
- (IBAction)GlutenFreeSwitchActionBlock:(id)sender;
- (IBAction)VeganGlutenFreeSwitchActionBlock:(id)sender;
- (IBAction)OrganicGlutenFreeSwitchActionBlock:(id)sender;
- (IBAction)LocalIngradientsGlutenFreeSwitchActionBlock:(id)sender;
- (IBAction)AvaliableGlutenFreeSwitchActionBlock:(id)sender;

- (IBAction)categoryButton:(id)sender;
- (IBAction)orderedBuButton:(id)sender;
- (IBAction)avaliableByButton:(id)sender;
- (IBAction)avaliableUntilButton:(id)sender;



@property (strong, nonatomic) IBOutlet UIView *touchableView;
@property (strong, nonatomic) IBOutlet UIView *touchableView1;




- (IBAction)saveDishButtonBlock:(id)sender;
- (IBAction)OrderTimeMainBtnBlock:(id)sender;
- (IBAction)AvaliableByDateMainBtnBlocl:(id)sender;
- (IBAction)AvaliableUntilMainBtnBlock:(id)sender;
- (IBAction)categoryBainBtnBlock:(id)sender;



@property (strong, nonatomic) IBOutlet UIView *actionSheetView;
- (IBAction)ActionSheetHide:(id)sender;
- (IBAction)selectDateTimeBlock:(id)sender;
@property (strong, nonatomic) IBOutlet UIDatePicker *localDatePicker;
- (IBAction)addProfilePicButtonAction:(id)sender;
- (IBAction)menuButtonClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *textActionSheet;
@property (strong, nonatomic) IBOutlet UIPickerView *textPickerH;
- (IBAction)TextPickerDoneAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *trasparentBlackView;






@property (strong, nonatomic) IBOutlet UILabel *cityTaxLbl;
@property (strong, nonatomic) IBOutlet UILabel *stateTaxLbl;






@property (strong, nonatomic) IBOutlet UIView *register2AllFieldsContainer;
@property (strong, nonatomic) IBOutlet UITextField *addressTF;
@property (strong, nonatomic) IBOutlet UITextField *cityTaxTF;
@property (strong, nonatomic) IBOutlet UIView *cityTaxGestureView;
@property (strong, nonatomic) IBOutlet UITextField *stateTaxTF;
@property (strong, nonatomic) IBOutlet UIView *stateTaxGestureView;




@property (strong, nonatomic) IBOutlet UITextField *addCuisineTF;
@property (strong, nonatomic) IBOutlet UIView *AddCuisineGestureView;
- (IBAction)Register2ViewDoneAction:(id)sender;
- (IBAction)Register2ViewCancelAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *ViewWithACSC;

@property (strong, nonatomic) IBOutlet UIView *AddressViewContainer;
@property (strong, nonatomic) IBOutlet UIView *cityTaxViewContainer;
@property (strong, nonatomic) IBOutlet UIView *stateTaxViewContainer;
@property (strong, nonatomic) IBOutlet UIView *cuisineTFViewContainer;
@property (strong, nonatomic) IBOutlet UIView *doneCancelButtonsContainer;




@property (strong, nonatomic) IBOutlet UITableView *ingredientsTable;

- (IBAction)ingredientRemoveButtonAction:(id)sender;
- (IBAction)addIngredientButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *DishPicImgV;


@property (strong, nonatomic) IBOutlet UIButton *menuBtn;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *actIndicator1;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *actIndicator2;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *actIndicator3;




@property (strong, nonatomic) IBOutlet UILabel *imgDefLbl1;
@property (strong, nonatomic) IBOutlet UILabel *imgDefLbl2;
@property (strong, nonatomic) IBOutlet UILabel *imgDefLbl3;

@end
