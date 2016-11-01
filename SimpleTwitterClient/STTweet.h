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

+ (NSArray *)tweetsWithArray:(NSDictionary *)dictionary;


@property(strong,readwrite,nonatomic) NSString *retweetName;
@property(strong,readwrite,nonatomic) NSString *text;

@property(strong,readwrite,nonatomic) NSString *accountName;
@property(strong,readwrite,nonatomic) NSString *userName;

@property(strong,readwrite,nonatomic) NSString *avatarImagePath;

@property(readwrite,nonatomic) NSNumber *retweetCount;
@property(readwrite,nonatomic) NSNumber *favoritesCount;
@property(strong,readwrite,nonatomic) NSDate *timestamp;


@property (nonatomic, assign) BOOL retweet;

@property(strong,readwrite,nonatomic) NSString *id;


@end
