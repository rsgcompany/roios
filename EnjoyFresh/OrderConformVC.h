//
//  OrderConformVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/7/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParserHClass.h"

@interface OrderConformVC : UIViewController<parserHDelegate>{
    ParserHClass *webParser;

}
- (IBAction)PushBack:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *orderDateLabelAct;


@property (nonatomic,retain) NSDictionary *ConformOrderDic;
@property (nonatomic,retain) NSString *conformOredrName;
@property (nonatomic,retain) NSString *isFrom;
@property (strong, nonatomic) IBOutlet UILabel *lblTax;

@property (strong, nonatomic) IBOutlet UILabel *OrderIdLbl;

@property (strong, nonatomic) IBOutlet UILabel *NameLbl;
@property (strong, nonatomic) IBOutlet UILabel *OrderDateLbl;


@property (strong, nonatomic) IBOutlet UILabel *DishOrder;
@property (strong, nonatomic) IBOutlet UILabel *Quantity;
@property (strong, nonatomic) IBOutlet UILabel *Price;
@property (strong, nonatomic) IBOutlet UILabel *Total;
@property (strong, nonatomic) IBOutlet UILabel *TransactionIdLbl;
- (IBAction)ConformOrderAction:(id)sender;

- (IBAction)menuButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;

@property (strong, nonatomic) IBOutlet UIButton *orderConformButton;



@end
