//
//  STTwitterClient.h
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void(^successCompletion)(NSError *error);



@interface STTwitterClient : NSObject


//- (void)handleOpenURL:(NSURL *)url completion:(void (^)(void))completionBlock ;
- (void)handleOpenURL:(NSURL *)url completion:(void (^)(void))completionBlock errorBlock:(successCompletion)errorBlock;



@end
