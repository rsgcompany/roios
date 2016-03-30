//
//  CollectionViewCellH.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/31/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCellH : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *collectionImageV;

@property (weak, nonatomic) IBOutlet UILabel *DefaultLbl;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *collectActIndcator;


@end
