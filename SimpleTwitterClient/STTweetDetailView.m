//
//  STTweetDetailView.m
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "STTweetDetailView.h"
#import "STTweet.h"

@implementation STTweetDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithTweet:(STTweet *)tweet
{
    if (!(self = [super init]))
        return nil;
    
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                          owner:self
                                        options:nil] objectAtIndex:0];
    self.retweetLabel.text = [tweet retweetName];
    self.nameLabel.text = [tweet accountName];
    self.usernameLabel.text = [NSString stringWithFormat:@"@%@",[tweet userName]];
    self.timeLabel.text = [self convertDate:[tweet timestamp]];
    self.tweetTextLabel.text = [tweet text];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"@%@",[tweet retweetCount]];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"@%@",[tweet favoritesCount]];

    
        
    return self;
}


- (NSString *)convertDate:(NSDate *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/mm/yy,HH:mm Z y"];
    NSString *resultString = [dateFormat stringFromDate:[NSDate date]];

    
    return resultString;
}



@end
