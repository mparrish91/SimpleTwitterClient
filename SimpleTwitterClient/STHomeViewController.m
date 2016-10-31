//
//  STHomeViewController.m
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "STHomeViewController.h"
#import "STTweet.h"
#import "UIImageView+AFNetworking.h"
#import "STTweetTableViewCell.h"
#import "STTwitterClient.h"
#import "NSDate+NSDate_TimeAgo.h"
#import "STTweetDetailViewController.h"
#import "STNewTweetViewController.h"

@interface STHomeViewController ()

@property(strong,readwrite,nonatomic) NSArray *tweets;

@property(nonatomic,strong) UITableView *tweetsTableView;
@property(nonatomic,strong) UIRefreshControl *refreshControl;

@end


@implementation STHomeViewController


#pragma mark - Initialize

- (instancetype)init
{
    self.tweetsTableView = [[UITableView alloc]init];
    self.tweets = [[NSMutableArray alloc] init];
    
    
    if (!(self = [super init]))
        return nil;
    
    
    return self;
}




#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    
    //tableview
    NSString *cellIdentifier = @"cell";
//    [self.tweetsTableView registerClass:[STTweetTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.tweetsTableView.delegate = self;
    self.tweetsTableView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tweetsTableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    
    self.tweetsTableView.estimatedRowHeight = 200;
    self.tweetsTableView.rowHeight = UITableViewAutomaticDimension;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out"  style:UIBarButtonItemStylePlain target:self action:@selector(signOut)];
    
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New"  style:UIBarButtonItemStylePlain target:self action:@selector(newTweet)];

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"twitter_logo"]];
    
    [self setConstraints];
    [self fetchTweets];
    
}


- (void)fetchTweets {
    
    STTwitterClient *client = [STTwitterClient sharedInstance];
    [client homeTimeline:^(id responseObject) {
        
        if ([responseObject isKindOfClass:[NSArray class]])
        {
            self.tweets = responseObject;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tweetsTableView reloadData];
                [self.refreshControl endRefreshing];
            });
        }
        
    } failure:^(NSError *error) {
        NSLog(@"error fetching tweets");

    }];

  
    
    
    
}


#pragma mark - TableView


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tweets.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 100;
}


- (STTweetTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    STTweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil)
    {
        [tableView registerNib:[UINib nibWithNibName:@"STTweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    }
    
    return cell;
}

//This function is where all the magic happens
-(void) tableView:(UITableView *) tableView willDisplayCell:(STTweetTableViewCell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    STTweet *tweet = [self.tweets objectAtIndex:indexPath.row];
    cell.retweetLabel.text = [tweet retweetName];
    cell.nameLabel.text = [tweet accountName];
    cell.usernameLabel.text = [NSString stringWithFormat:@"@%@",[tweet userName]];
    cell.timeLabel.text = [self setTimeAgo:[tweet timestamp]];
    cell.tweetTextLabel.text = [tweet text];

    
    if (!tweet.retweet)
    {
        cell.retweetLabel.hidden = true;
        cell.retweetImageView.hidden = true;
    }

    cell.tweetTextLabel.text = [tweet text];
  

    NSURL *photoImageURL = [NSURL URLWithString:[tweet avatarImagePath]];
    
    [cell.profilePhotoImageView setImageWithURL:photoImageURL placeholderImage:[UIImage imageNamed:@"placeholder-background"]];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
        STTweet *tweet = [self.tweets objectAtIndex:indexPath.row];
        STTweetDetailViewController *detailVC = [[STTweetDetailViewController alloc]initWithTweet:tweet];
        [self.navigationController pushViewController:detailVC animated:true];
}





- (void)refreshTable {
    [self fetchTweets];
}




- (void)loadView
{
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
    [view addSubview:self.tweetsTableView];
    
}


-(void)setConstraints
{
    
    UIView *view= self.view;
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    
    
    self.tweetsTableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.tweetsTableView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
    [self.tweetsTableView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
    [self.tweetsTableView.topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
    [self.tweetsTableView.bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
}


-(void)newTweet
{
    STNewTweetViewController *newTweetVC = [[STNewTweetViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:newTweetVC];
    [self.navigationController presentViewController:nav animated:true completion:nil];

}

-(void)signOut
{
    STTwitterClient *client = [STTwitterClient sharedInstance];
    [client deauthorize];
    [self dismissViewControllerAnimated:YES completion:nil];

}


-(NSString *)setTimeAgo: (NSDate *)date
{
    
    NSDate *currentDate = [[NSDate alloc]init];
    
    NSInteger minFrom = [currentDate minutesFrom:date];
    NSInteger hoursFrom = [currentDate hoursFrom:date];

    //if more than 24 hours have passed
    if ((int)minFrom < 60)
    {
        NSString *timeAgo = [NSString stringWithFormat:@"%ldm", (long)minFrom];
        return timeAgo;
    }
    else{
        NSString *timeAgo = [NSString stringWithFormat:@"%ldh", (long)hoursFrom];
        return timeAgo;
    }


}




@end
