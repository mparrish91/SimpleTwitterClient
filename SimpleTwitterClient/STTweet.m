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
    
    if ((value = dict[@"text"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"text"] = value;
    
    if ((value = dict[@"retweet_count"]) && [value respondsToSelector:@selector(integerValue)])
        valuesForKeys[@"retweetCount"] = value;
    
    if ((value = dict[@"favorite_count"]) && [value respondsToSelector:@selector(integerValue)])
        valuesForKeys[@"favoritesCount"] = value;
    
    if ((value = dict[@"created_at"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"timestamp"] = [self convertStringToDate:value];
    
    if ((value = dict[@"profile_image_url_https"]) && [value isKindOfClass:[NSString class]])
    {
        NSURL *url = [NSURL URLWithString: value];
        valuesForKeys[@"profilePhotoURL"] = url;
    }
    
    
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
