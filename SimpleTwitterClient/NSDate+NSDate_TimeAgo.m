//
//  NSDate+NSDate_TimeAgo.m
//  SimpleTwitterClient
//
//  Created by parry on 10/30/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "NSDate+NSDate_TimeAgo.h"

@implementation NSDate (NSDate_TimeAgo)


- (NSInteger)daysFrom:(NSDate *)date
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:date toDate:self options:NSCalendarWrapComponents].day;
}

- (NSInteger)hoursFrom:(NSDate *)date;
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:date toDate:self options:NSCalendarWrapComponents].hour;

}

@end
