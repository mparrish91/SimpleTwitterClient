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
@property(strong,readonly,nonatomic) NSURL *profilePhotoURL;
@property(strong,readonly,nonatomic) NSString *bio;
@property(strong,readonly,nonatomic) STUser *currentUser;

//+ (STUser *)currentUser;

@property(strong,readonly,nonatomic) NSData *userDictionary;
@property (class) STUser *currentUser;



@end
