//
//  STTweet.m
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "STTweet.h"

@implementation STTweet

- (instancetype)initWithServerRepresentation:(NSDictionary *)dict
{
    
    NSMutableDictionary *valuesForKeys = [NSMutableDictionary dictionary];
    id value = nil;
    
    //check if retweet
    if ([dict[@"retweeted_status"] isKindOfClass:[NSDictionary class]])
    {
        self.retweet = true;
        
        if ((value = dict[@"user"][@"name"]) && [value isKindOfClass:[NSString class]])
            valuesForKeys[@"retweetName"] = value;
        
        if ((value = dict[@"retweeted_status"][@"user"][@"screen_name"]) && [value isKindOfClass:[NSString class]])
            valuesForKeys[@"userName"] = value;
        
        if ((value = dict[@"retweeted_status"][@"user"][@"name"]) && [value isKindOfClass:[NSString class]])
            valuesForKeys[@"accountName"] = value;
        
        if ((value = dict[@"retweeted_status"][@"user"][@"profile_image_url_https"]) && [value isKindOfClass:[NSString class]])
            valuesForKeys[@"avatarImagePath"] = value;
        
        if ((value = dict[@"retweeted_status"][@"text"]) && [value isKindOfClass:[NSString class]])
            valuesForKeys[@"text"] = value;
        
        //others?
        if ((value = dict[@"retweeted_status"][@"retweet_count"]) && [value respondsToSelector:@selector(integerValue)])
            valuesForKeys[@"retweetCount"] = value;
        
        if ((value = dict[@"retweeted_status"][@"favorite_count"]) && [value respondsToSelector:@selector(integerValue)])
            valuesForKeys[@"favoritesCount"] = value;
    }
    else
    {
        if ((value = dict[@"user"][@"screen_name"]) && [value isKindOfClass:[NSString class]])
            valuesForKeys[@"userName"] = value;
        
        if ((value = dict[@"user"][@"name"]) && [value isKindOfClass:[NSString class]])
            valuesForKeys[@"accountName"] = value;
        
        
        if ((value = dict[@"text"]) && [value isKindOfClass:[NSString class]])
            valuesForKeys[@"text"] = value;
        
        if ((value = dict[@"retweet_count"]) && [value respondsToSelector:@selector(integerValue)])
            valuesForKeys[@"retweetCount"] = value;
        
        if ((value = dict[@"favorite_count"]) && [value respondsToSelector:@selector(integerValue)])
            valuesForKeys[@"favoritesCount"] = value;
    
        
        if ((value = dict[@"profile_image_url_https"]) && [value isKindOfClass:[NSString class]])
        {
            NSURL *url = [NSURL URLWithString: value];
            valuesForKeys[@"profilePhotoURL"] = url;
        }
    }
    
    if ((value = dict[@"created_at"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"timestamp"] = [self convertStringToDate:value];
    
    if ((value = dict[@"id"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"id"] = [self convertStringToDate:value];

    
    [self setValuesForKeysWithDictionary:valuesForKeys];
    
    return self;
}


+ (NSArray *)tweetsWithArray:(NSDictionary *)dictionary
{
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in dictionary) {

        STTweet *object = [[STTweet alloc] initWithServerRepresentation:dic];
        if (object != nil)
        {
            [objects addObject:object];
        }
    }
    return objects;

}



- (NSDate *)convertStringToDate: (NSString *)str
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE MMM d HH:mm:ss Z y"];
    NSDate *date = [dateFormat dateFromString:str];
    
    return date;
}

@end
