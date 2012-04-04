//
//  News.m
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "News.h"
#define TAG_DATE_LABEL 1
#define TAG_TITLE_LABEL 2
#define CELL_WIDTH 236

@interface News()
@property (nonatomic, strong) NSMutableArray *news;

@end

@implementation News
@synthesize news = _news;

- (NSMutableArray *)news {
    if (!_news) {
        _news = [[NSMutableArray alloc] init];
    }
    return _news;
}

- (void)update {
    [self.news removeAllObjects];
    for (int i = 0; i < 10; i++) {
        NSDictionary *new = [NSDictionary dictionaryWithObjectsAndKeys:[NSDate date], @"date", @"Поездка в Лондон на открытие Забсибкомбанка", @"title", nil];
        [self.news addObject:new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *new = [self.news objectAtIndex:indexPath.row];
    CGFloat height = 2 * 10 + 21 + 8;
    NSString *title = [new objectForKey:@"title"];
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(CELL_WIDTH, 9999) lineBreakMode:UILineBreakModeWordWrap];
    height += size.height;
    return height;
}

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
    
    NSDictionary *new = [self.news objectAtIndex:indexPath.row];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"dd MMMM YYYY";
    lblDate.text = [df stringFromDate:[new objectForKey:@"date"]];
    lblTitle.text = [new objectForKey:@"title"];
    [lblTitle sizeToFit];
    return cell;
}

@end
