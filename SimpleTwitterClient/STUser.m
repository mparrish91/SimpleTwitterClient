//
//  STUser.m
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "STUser.h"

@implementation STUser

- (instancetype)initWithServerRepresentation:(NSDictionary *)dict
{
    
    NSMutableDictionary *valuesForKeys = [NSMutableDictionary dictionary];
    id value = nil;
    
    if ((value = dict[@"name"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"name"] = value;
    
    if ((value = dict[@"screen_name"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"username"] = value;
    
    if ((value = dict[@"description"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"bio"] = value;
    
    if ((value = dict[@"profile_image_url_https"]) && [value isKindOfClass:[NSString class]])
    {
        NSURL *url = [NSURL URLWithString: value];
        valuesForKeys[@"profilePhotoURL"] = url;
    }
    
    [self setValuesForKeysWithDictionary:valuesForKeys];
    
    return self;
}

@end
