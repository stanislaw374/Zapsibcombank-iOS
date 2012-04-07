//
//  MapScreen.m
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 03.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapScreen.h"
#import "PointAnnotation.h"
#import "Objects.h"

#define ZOOM_LEVEL 10
#define TAG_NAME_LABEL 1
#define TAG_ADDRESS_LABEL 2
#define TAG_HOURS_LABEL 3
#define TAG_USD_BADGE 4
#define TAG_RUB_BADGE 5

@interface MapScreen()
@property (nonatomic, strong) NSMutableArray *annotations;
@property (nonatomic, strong) UIPopoverController *citiesPopover;
@property (nonatomic, strong) NSDictionary *currentCity;
@property (nonatomic, strong) Objects *objects;
- (void)configureMapView;
- (void)configureAndInstallAnnotations;
- (void)configureAnnotationView:(YMKPinAnnotationView *)view forAnnotation:(id<YMKAnnotation>)annotation;
- (void)centerMap;
@end

@implementation MapScreen
@synthesize mapView;
@synthesize btnCity = _btnCity;
@synthesize arrow = _arrow;
@synthesize btnATMs = _btnATMs;
@synthesize btnOffices = _btnOffices;
@synthesize btnAll = _btnAll;
@synthesize lblAnnotationsCategory = _lblAnnotationsCategory;
@synthesize annotations = _annotations;
@synthesize citiesPopover = _citiesPopover;
@synthesize currentCity = _currentCity;
@synthesize objects = _objects;

#pragma mark - Lazy instantiation
- (NSMutableArray *)annotations {
    if (!_annotations) {
        _annotations = [[NSMutableArray alloc] init];
    }
    return _annotations;
}

- (UIPopoverController *)citiesPopover {
    if (!_citiesPopover) {
        CitiesView *citiesView = [[CitiesView alloc] init];
        citiesView.delegate = self;
        _citiesPopover = [[UIPopoverController alloc] initWithContentViewController:citiesView];
    }
    return _citiesPopover;
}

- (void)setCurrentCity:(NSDictionary *)currentCity {
    _currentCity = currentCity;
    [self.btnCity setTitle:[_currentCity objectForKey:@"name"] forState:UIControlStateNormal];
    [self.btnCity sizeToFit];
    double lat = [[_currentCity objectForKey:@"lat"] doubleValue];
    double lng = [[_currentCity objectForKey:@"lng"] doubleValue];
    [self.mapView setCenterCoordinate:YMKMapCoordinateMake(lat, lng) atZoomLevel:ZOOM_LEVEL animated:YES];
}

#pragma mark - Helpers 
- (void)configureMapView {
    self.mapView.apiKey = @"SkJckErzSIu5lPxAMtjpUhKfSWAU7dPt0sNpSAgkp8dzvQp0UnHnXK7xuJh8kTjW83Dg8CdYkm5hm31q59HeDLQxEwCef0gKAwXD2vyDrms=";
    self.mapView.showsUserLocation = NO;
    self.mapView.showTraffic = NO;
    [self.mapView setCenterCoordinate:YMKMapCoordinateMake(57, 65)
                          atZoomLevel:ZOOM_LEVEL
                             animated:NO];
}

- (void)configureAndInstallAnnotations {
    
    const int n = 15;
    for (int i = 0; i < n; i++) {
        PointAnnotation *annotation = [PointAnnotation pointAnnotation];
        annotation.coordinate = YMKMapCoordinateMake(57 + arc4random() % 1, 65);
        
        [self.mapView addAnnotation:annotation];
    }
}

- (void)configureAnnotationView:(YMKPinAnnotationView *)view forAnnotation:(id<YMKAnnotation>)annotation {
    view.image = [UIImage imageNamed:@"map_pin.png"];
}

#pragma mark - YMKMapViewDelegate

- (YMKAnnotationView *)mapView:(YMKMapView *)aMapView viewForAnnotation:(id<YMKAnnotation>)anAnnotation {
    static NSString * identifier = @"pointAnnotation";
    YMKPinAnnotationView * view = (YMKPinAnnotationView *)[aMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (view == nil) {
        view = [[YMKPinAnnotationView alloc] initWithAnnotation:anAnnotation
                                                 reuseIdentifier:identifier];
    }
    
    [self configureAnnotationView:view forAnnotation:anAnnotation];
    return view;
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
    [self configureMapView];
    [self configureAndInstallAnnotations];
    
    [self changeAnnotationsCategory:self.btnATMs];
    
}

- (void)viewDidUnload
{
    self.mapView = nil;
    [self setMapView:nil];
    [self setBtnCity:nil];
    [self setArrow:nil];
    [self setBtnATMs:nil];
    [self setBtnOffices:nil];
    [self setBtnAll:nil];
    [self setLblAnnotationsCategory:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

- (IBAction)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goMain {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)chooseCity:(UIButton *)button {
    [self.citiesPopover presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (IBAction)changeAnnotationsCategory:(id)sender {
    self.btnATMs.selected = NO;
    self.btnOffices.selected = NO;
    self.btnAll.selected = NO;
    
    UIButton *btn = (UIButton *)sender;
    btn.selected = YES;
    self.arrow.center = CGPointMake(btn.center.x, self.arrow.center.y);
    
    NSString *category;
    switch (btn.tag) {
        case 0: category = @"Адреса банкоматов:";
            break;
        case 1: category = @"Адреса отделений:";
            break;
        case 2: category = @"Все вместе:";
            break;
    }
    self.lblAnnotationsCategory.text = category;
    [self.lblAnnotationsCategory sizeToFit];
    CGRect frame = self.btnCity.frame;
    frame.origin.x = self.lblAnnotationsCategory.frame.origin.x + self.lblAnnotationsCategory.frame.size.width + 8;
    self.btnCity.frame = frame;
}

#pragma mark - CitiesPickerDelegate
- (void)citiesPickerDidPickCity:(NSDictionary *)city {
    [self.citiesPopover dismissPopoverAnimated:YES];
    self.currentCity = city;
}

#pragma mark - UITableViewDataSource
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Objects all].count;
}

#pragma mark - UITableViewDelegate 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"MapCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:reuseIdentifier owner:self options:nil] objectAtIndex:0];
    }
    UILabel *lblName = (UILabel *)[cell viewWithTag:TAG_NAME_LABEL];
    UILabel *lblAddress = (UILabel *)[cell viewWithTag:TAG_ADDRESS_LABEL];
    UILabel *lblHours = (UILabel *)[cell viewWithTag:TAG_HOURS_LABEL];
    UIImageView *usd = (UIImageView *)[cell viewWithTag:TAG_USD_BADGE];
    UIImageView *rub = (UIImageView *)[cell viewWithTag:TAG_RUB_BADGE];
    
    NSDictionary *obj = [[Objects all] objectAtIndex:indexPath.row];
    
    lblName.text = [obj objectForKey:@"name"];
    lblAddress.text = [obj objectForKey:@"address"];
    lblHours.text = [obj objectForKey:@"hours"];
    usd.hidden = ![[obj objectForKey:@"usd"] boolValue];
    rub.hidden = ![[obj objectForKey:@"rub"] boolValue];
    
    return cell;
}

@end
