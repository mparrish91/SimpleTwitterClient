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
    
    if ((value = dict[@"photos"][0][@"original_size"][@"url"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"imagePath"] = value;
    
    if ((value = dict[@"trail"][0][@"blog"][@"name"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"accountName"] = value;
    
    if ((value = dict[@"date"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"date"] = [self convertStringToDate:value];
    
    self.avatarImagePath = @"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/avatar";
    
    [self setValuesForKeysWithDictionary:valuesForKeys];
    
    return self;
}



- (NSDate *)convertStringToDate: (NSString *)str
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    NSDate *date = [dateFormat dateFromString:str];
    
    return date;
}

@end
