//
//  STUser.m
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "STUser.h"

@implementation STUser

static STUser * _currentUser;

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


+ (STUser *)currentUser
{
    
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


+ (void)setCurrentUser:(STUser *)currentUser
{
    _currentUser = currentUser;
    
    // Unwrap user and save serialized (dict) info to defaults
    NSError *e = nil;
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData: _currentUser.userDictionary options: NSJSONReadingMutableContainers error: &e];
    
    if (data)
    {
        [[NSUserDefaults standardUserDefaults]setObject:currentUser forKey:@"currentUserData"];
        NSLog(@"Serialized current user and saving to defaults");

    }
    else{
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"currentUserData"];
        
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}



@end
