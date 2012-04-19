//
//  CitiesView.m
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 03.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CitiesView.h"
#import "MBProgressHUD.h"

@interface CitiesView()
@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, strong, readonly) NSArray *dataSource;
@end

@implementation CitiesView
@synthesize cities = _cities;
@synthesize delegate = _delegate;
@synthesize tableView = _tableView;
@synthesize searchBar = _searchBar;

- (NSArray *)dataSource {
    if (self.searchBar.text.length) {
        NSIndexSet *indexes = [self.cities indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            City *city = (City *)obj;
            if ([city.name rangeOfString:self.searchBar.text options:NSCaseInsensitiveSearch].location != NSNotFound) {
                return YES;
            }
            else return NO;
        }];
        return [self.cities objectsAtIndexes:indexes];
    }
    else {
        return self.cities;
    }
}

- (NSArray *)cities {
    if (!_cities) {
        _cities = [NSArray array];
    }
    return _cities;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     
    [City getWithDelegate:self];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

#pragma mark - UITableViewDataSource
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = @"CitiesCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    City *city = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = city.name;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate citiesPickerDidPickCity:[self.dataSource objectAtIndex:indexPath.row]];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - CityDelegate
- (void)citiesDidLoad:(NSArray *)cities {
    self.cities = cities;
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)citiesDidFailWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:error.localizedDescription message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
