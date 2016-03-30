//
//  ParserHClass.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/5/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>



//Delegatr Protocol Method
@protocol parserHDelegate <NSObject>
@required
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result;
-(void)dataDidFinihLoadingwithError:(NSString *)errorH;

@optional
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result withIdentifier:(NSString *)myIdentifier;
@end




@interface ParserHClass : NSObject{
}


-(void)parserPostMethodWithParameters:(NSMutableDictionary *)param andExtendUrl:(NSString *)myUrlString;

-(void)parserJsonDataFromUrlString:(NSString *)myUrlString;


-(void)parserJsonDataFromUrlString:(NSString *)myUrlString withIderntifier:(NSString *)myIdentifier;


@property(nonatomic, strong) id <parserHDelegate> delegate;

@end
