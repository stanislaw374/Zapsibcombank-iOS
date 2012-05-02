//
//  News.m
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "News.h"
#import "New.h"
#import "MBProgressHUD.h"
#import "NewTextView.h"

#define TAG_DATE_LABEL 1
#define TAG_TITLE_LABEL 2
#define CELL_WIDTH 236

@interface News()
@property (nonatomic, strong) NSMutableArray *news;
@property (nonatomic) int page;
@property (nonatomic, strong) NewTextView *newTextView;
@property (nonatomic, strong) UIPopoverController *popoverWithNewText;
@end

@implementation News
@synthesize news = _news;
@synthesize page = _page;
@synthesize tableView = _tableView;
@synthesize popoverWithNewText = _popoverWithNewText;
@synthesize view = _view;
@synthesize newTextView = _newTextView;

#pragma mark - Lazy instantiation

- (UIPopoverController *)popoverWithNewText {
    if (!_popoverWithNewText) {
        _popoverWithNewText = [[UIPopoverController alloc] initWithContentViewController:self.newTextView];
    }
    return _popoverWithNewText;
}

- (NewTextView *)newTextView {
    if (!_newTextView) {
        _newTextView = [[NewTextView alloc] init];
    }
    return _newTextView;
}

- (NSMutableArray *)news {
    if (!_news) {
        _news = [[NSMutableArray alloc] init];
        [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
        [self loadNews];
    }
    return _news;
}

- (void)loadNews {
    [New get:self.page++ withDelegate:self];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    New *new = [self.news objectAtIndex:indexPath.row];
    CGFloat height = 2 * 10 + 21 + 8;
    NSString *title = new.title;
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(CELL_WIDTH, 9999) lineBreakMode:UILineBreakModeWordWrap];
    height += size.height;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    CGRect rect = CGRectMake(self.tableView.frame.origin.x, self.tableView.center.y, 1, 1);
    //NSLog(@"%@ rect: %@", NSStringFromSelector(_cmd), NSStringFromCGRect(rect));
    New *new = [self.news objectAtIndex:indexPath.row];
    self.newTextView.text = new.text;
    [self.popoverWithNewText presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
}

#pragma mark - UITableViewDataSource
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"NewsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:reuseIdentifier owner:self options:nil] objectAtIndex:0];
    }
    UILabel *lblDate = (UILabel *)[cell viewWithTag:TAG_DATE_LABEL];
    UILabel *lblTitle = (UILabel *)[cell viewWithTag:TAG_TITLE_LABEL];
    
    New *new = [self.news objectAtIndex:indexPath.row];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"dd MMMM YYYY";
    lblDate.text = [df stringFromDate:new.date];
    lblTitle.text = new.title;
    CGSize size = [new.title sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(CELL_WIDTH, 9999) lineBreakMode:UILineBreakModeWordWrap];
    CGRect frame = lblTitle.frame;
    frame.size.height = size.height;
    lblTitle.frame = frame;
    return cell;
}

#pragma mark - NewDelegate
- (void)newsDidLoad:(NSArray *)news {
    [self.news addObjectsFromArray:news];
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
}

- (void)newsDidFailWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
}

@end
