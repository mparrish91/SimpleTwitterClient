//
//  STUser.h
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STUser : NSObject

- (instancetype)initWithServerRepresentation:(NSDictionary *)dict;

@property(strong,readonly,nonatomic) NSString *name;
@property(strong,readonly,nonatomic) NSString *username;
@property(strong,readonly,nonatomic) NSString *profilePhotoURL;
@property(strong,readonly,nonatomic) NSString *bio;

@end