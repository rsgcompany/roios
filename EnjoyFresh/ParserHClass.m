//
//  ParserHClass.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/5/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "ParserHClass.h"
#import "Global.h"

@implementation ParserHClass
@synthesize delegate;


-(void)parserPostMethodWithParameters:(NSMutableDictionary *)param andExtendUrl:(NSString *)myUrlString{
    if ([appDel.connection isNetworkReachable]) {
        //my web-dependent code
        NSString *postUrl=[NSString stringWithFormat:@"%@%@",baseUrl,myUrlString];
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

        [manager POST:postUrl parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict  = (NSDictionary *)responseObject;
            [delegate dataDidFinihLoadingwithResult:dict];

        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
   
            [delegate dataDidFinihLoadingwithError:[NSString stringWithFormat:@"%@",[error localizedDescription]]];
        }];
        
    }else{
        [delegate dataDidFinihLoadingwithError:@"Please check your Network Connection."];
    }
    
   
}




-(void)parserJsonDataFromUrlString:(NSString *)myUrlString{
    if ([appDel.connection isNetworkReachable]) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:myUrlString]];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [delegate dataDidFinihLoadingwithResult:(NSDictionary *)responseObject];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [delegate dataDidFinihLoadingwithError:[error localizedDescription]];
        }];
        [operation start];
    }else{
        [delegate dataDidFinihLoadingwithError:@"Please check your Network Connection."];
    }
    
}



-(void)parserJsonDataFromUrlString:(NSString *)myUrlString withIderntifier:(NSString *)myIdentifier{
    if ([appDel.connection isNetworkReachable]) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:myUrlString]];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [delegate dataDidFinihLoadingwithResult:(NSDictionary *)responseObject withIdentifier:myIdentifier];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [delegate dataDidFinihLoadingwithError:[error localizedDescription]];
        }];
        [operation start];
    }else{
        [delegate dataDidFinihLoadingwithError:@"Please check your Network Connection."];
    }
    
}


@end
