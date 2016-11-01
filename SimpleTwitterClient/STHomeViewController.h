//
//  STHomeViewController.h
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STTweetTableViewCell.h"

@interface STHomeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, STTweetTableViewCellDelegate>


@end
