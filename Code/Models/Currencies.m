//
//  Currencies.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 13.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Currencies.h"
#import "MBProgressHUD.h"

@interface Currencies()
@property (nonatomic, strong) Currency *currency;
@end

@implementation Currencies
@synthesize tableView = _tableView;
@synthesize currency = _currency;

- (Currency *)currency {
    if (!_currency) {
        [self loadCurrency];
    }
    return _currency;
}

- (void)loadCurrency {
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [Currency getWithDelegate:self];
}

#pragma mark - UITableViewDataSource
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currency ? 3 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"CurrencyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:reuseIdentifier owner:self options:nil] objectAtIndex:0];
    }
    UILabel *lblCurrency = (UILabel *)[cell viewWithTag:1];
    UILabel *lblPurchase = (UILabel *)[cell viewWithTag:2];
    UILabel *lblSale = (UILabel *)[cell viewWithTag:3];
    UILabel *lblCbr = (UILabel *)[cell viewWithTag:4];
    
    NSDictionary *course = [self.currency.course objectAtIndex:indexPath.row];
    lblCurrency.text = [course objectForKey:@"currency"];
    lblPurchase.text = [course objectForKey:@"purchase"];
    lblSale.text = [course objectForKey:@"sale"];
    lblCbr.text = [course objectForKey:@"cb"];
    
    return cell;
}

#pragma mark - CurrencyDelegate
- (void)currencyDidFail {
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
}

- (void)currencyDidLoad:(Currency *)currency {
    self.currency = currency;
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
}

@end
