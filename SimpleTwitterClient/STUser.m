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


@synthesize currentUser = _currentUser;

- (void)setCurrentUser:(STUser *)currentUser
{
    [[NSUserDefaults standardUserDefaults]setObject:currentUser forKey:@"currentUserData"];

 
}

- (STUser *)currentUser
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"someProperty"];
    
    if (!_currentUser)
    {
        NSData *userData = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentUserData"];
        
        if (userData)
        {
            NSError *e = nil;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData: userData options: NSJSONReadingMutableContainers error: &e];
            _currentUser = [[STUser alloc]initWithServerRepresentation:dictionary];
            
        }
    }
    return _currentUser;
    
}

@end
