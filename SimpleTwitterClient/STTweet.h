//
//  STTweet.h
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STTweet : NSObject

- (instancetype)initWithServerRepresentation:(NSDictionary *)dict;

@property(strong,readwrite,nonatomic) NSString *imagePath;
@property(strong,readwrite,nonatomic) NSString *avatarImagePath;

@property(strong,readwrite,nonatomic) NSString *accountName;
@property(strong,readwrite,nonatomic) NSDate *date;


@end
