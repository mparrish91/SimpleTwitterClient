//
//  NSDate+NSDate_TimeAgo.h
//  SimpleTwitterClient
//
//  Created by parry on 10/30/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NSDate_TimeAgo)

- (NSInteger)daysFrom:(NSDate *)date;
- (NSInteger)hoursFrom:(NSDate *)date;

@end
