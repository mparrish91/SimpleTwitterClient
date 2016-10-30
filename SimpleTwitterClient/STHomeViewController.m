//
//  STHomeViewController.m
//  SimpleTwitterClient
//
//  Created by parry on 10/29/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "STHomeViewController.h"
#import "STTweetTableViewCell.h"
#import "STTweet.h"

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
    [self.tweetsTableView registerClass:[STTweetTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.tweetsTableView.delegate = self;
    self.tweetsTableView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tweetsTableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    
    self.tweetsTableView.estimatedRowHeight = 100;
    self.tweetsTableView.rowHeight = UITableViewAutomaticDimension;
    
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out"  style:UIBarButtonItemStylePlain target:self action:@selector(presentFilterView)];
    
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New"  style:UIBarButtonItemStylePlain target:self action:@selector(presentFilterView)];


    
    [self setConstraints];
    [self fetchTweets];
    
}


- (void)fetchTweets {
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //    Business *yelp = [[Business alloc]init];
    [Business searchWithTermWithTerm:@"thai" completion:^(NSArray *objects, NSError *error)
     {
         
         if (error)
         {
             [self showErrorView:self.errorView];
         }
         else
         {
             [self hideErrorView:self.errorView];
             
         }
         self.businesses = objects;
         self.displayedItems = self.businesses;
         
         
         dispatch_async(dispatch_get_main_queue(), ^{
             self.isMoreDataLoading = false;
             [self.tweetsTableView reloadData];
             
             
             
             if ([[NSThread currentThread] isMainThread]){
                 NSLog(@"In main thread--completion handler");
                 [self.refreshControl endRefreshing];
                 [self.loadingMoreView stopAnimating];
                 //                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 
                 
             }
             else{
                 NSLog(@"Not in main thread--completion handler");
             }
             
         });
         
     }];
    
    
    
    
}


#pragma mark - TableView


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tweets.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    STTweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier   forIndexPath:indexPath] ;
    
    if (cell == nil)
    {
        cell = [[STTweetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    return cell;
}

//This function is where all the magic happens
-(void) tableView:(UITableView *) tableView willDisplayCell:(STTweetTableViewCell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    STTweet *tweet = [self.tweets objectAtIndex:indexPath.row];
    cell.retweetLabel.text = [tweet retweetCount];
    cell.nameLabel.text = [tweet accountName];
    cell.usernameLabel.text = [tweet userName];
    

    cell.tweetTextLabel.text = [tweet text];
    cell.timeLabel.text = [tweet timestamp];;
  
    
    NSURL *photoImageURL = [tweet avatarImagePath];
    
    
    [cell.profilePhotoImageView setImageWithURL:photoImageURL placeholderImage:[UIImage imageNamed:@"placeholder-background"]];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    //    Business *business = [self.displayedItems objectAtIndex:indexPath.row];
    
    //    FLMovieDetailViewController *detailVC = [[FLMovieDetailViewController alloc]initWithMovie:movie];
    //    //    FLMovieDetailViewController *detailVC = [[FLMovieDetailViewController alloc]initWithURL:[movie posterPath]];
    //    [self.navigationController pushViewController:detailVC animated:true];
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



@end
