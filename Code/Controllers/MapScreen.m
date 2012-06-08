//
//  MapScreen.m
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 03.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapScreen.h"
#import "PointAnnotation.h"
#import "MBProgressHUD.h"
#import "Config.h"
#import "SBJson.h"
#import "ATM.h"
#import "MapObject.h"
#import "Office.h"

#define ZOOM_LEVEL_MEDIUM 9
#define ZOOM_LEVEL_LARGE 16
#define TAG_NAME_LABEL 1
#define TAG_ADDRESS_LABEL 2
#define TAG_HOURS_LABEL 3
#define TAG_USD_BADGE 4
#define TAG_RUB_BADGE 5

typedef enum { CATEGORY_ATMS, CATEGORY_OFFICES, CATEGORY_ALL } ContentCategory;

@interface MapScreen()
@property (nonatomic, strong) NSArray *annotations;
@property (nonatomic, strong) UIPopoverController *citiesPopover;
@property (nonatomic, strong) City *currentCity;
@property (nonatomic) ContentCategory contentCategory;
- (void)configureMapView;
- (void)updateMap;
- (void)loadData;
@end

@implementation MapScreen
@synthesize mapView;
@synthesize btnCity = _btnCity;
@synthesize arrow = _arrow;
@synthesize btnATMs = _btnATMs;
@synthesize btnOffices = _btnOffices;
@synthesize btnAll = _btnAll;
@synthesize lblAnnotationsCategory = _lblAnnotationsCategory;
@synthesize tableView = _tableView;
@synthesize contentScrollView = _contentScrollView;
@synthesize annotations = _annotations;
@synthesize citiesPopover = _citiesPopover;
@synthesize currentCity = _currentCity;
@synthesize contentCategory = _contentCategory;

#pragma mark - Lazy instantiation
- (NSArray *)annotations {
    if (!_annotations) {
        _annotations = [[NSArray alloc] init];
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

- (City *)currentCity {
    if (!_currentCity) {
        City *city = [[City alloc] init];
        city.ID = 32;
        city.name = @"Тюмень";
        self.currentCity = city;
    }
    return _currentCity;
}

- (void)setContentCategory:(ContentCategory)contentCategory {
    if (_contentCategory != contentCategory) {
        _contentCategory = contentCategory;
        [self loadData];
    }
}

- (void)setCurrentCity:(City *)currentCity {
    _currentCity = currentCity;
    
    [self.btnCity setTitle:_currentCity.name forState:UIControlStateNormal];
    [self.btnCity sizeToFit];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *requestString = [[NSString stringWithFormat:@"http://geocode-maps.yandex.ru/1.x/?key=%@&format=json&geocode=%@", YMAPS_KEY, _currentCity.name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:requestString];    
        
        NSError *error;
        NSStringEncoding encoding;
        NSString *responseString = [NSString stringWithContentsOfURL:url usedEncoding:&encoding error:&error];
        NSLog(@"%@, response: %@", NSStringFromSelector(_cmd), responseString);
        
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *responseDict = [parser objectWithString:responseString];
        NSDictionary *response = [responseDict objectForKey:@"response"];
        
        NSArray *featureMembers = [[response objectForKey:@"GeoObjectCollection"] objectForKey:@"featureMember"];
        if (featureMembers.count) {
            NSDictionary *boundedByEnvelope = [[[[featureMembers objectAtIndex:0] objectForKey:@"GeoObject"] objectForKey:@"boundedBy"] objectForKey:@"Envelope"];
            NSArray *lowerCornerCoords = [[boundedByEnvelope objectForKey:@"lowerCorner"] componentsSeparatedByString:@" "];
            NSArray *upperCornerCoords = [[boundedByEnvelope objectForKey:@"upperCorner"] componentsSeparatedByString:@" "];
            double lat1 = [[lowerCornerCoords objectAtIndex:1] doubleValue];
            double lng1 = [[lowerCornerCoords objectAtIndex:0] doubleValue];
            double lat2 = [[upperCornerCoords objectAtIndex:1] doubleValue];
            double lng2 = [[upperCornerCoords objectAtIndex:0] doubleValue];
            YMKMapDegrees latDelta = ABS(lat1 - lat2);
            YMKMapDegrees lngDelta = ABS(lng1 - lng2);    
            
            NSArray *coordinates = [[[[[[[response objectForKey:@"GeoObjectCollection"] objectForKey:@"featureMember"] objectAtIndex:0] objectForKey:@"GeoObject"] objectForKey:@"Point"] objectForKey:@"pos"] componentsSeparatedByString:@" "];
            
            double lat = [[coordinates objectAtIndex:1] doubleValue];
            double lng = [[coordinates objectAtIndex:0] doubleValue];
            
            //[self.mapView setCenterCoordinate:YMKMapCoordinateMake(lat, lng) atZoomLevel:ZOOM_LEVEL animated:YES];            
            
            YMKMapRegion mapRegion = YMKMapRegionMake(YMKMapCoordinateMake(lat, lng), YMKMapRegionSizeMake(latDelta, lngDelta));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mapView setRegion:mapRegion animated:YES];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self loadData];
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        }
    });
}

#pragma mark - Helpers 
- (void)loadData {
    switch (self.contentCategory) {
        case CATEGORY_ALL:
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.currentCity.delegate = self;
            [self.currentCity getATMs];
            [self.currentCity getOffices];
            break;
        case CATEGORY_ATMS:
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.currentCity.delegate = self;
            [self.currentCity getATMs];
            break;
        case CATEGORY_OFFICES:
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.currentCity.delegate = self;
            [self.currentCity getOffices];
        default: break;
    }
}

- (void)configureMapView {
    self.mapView.apiKey = YMAPKIT_KEY;
    self.mapView.showsUserLocation = YES;
    self.mapView.showTraffic = NO;
    [self.mapView setCenterCoordinate:YMKMapCoordinateMake(57, 65)
                          atZoomLevel:ZOOM_LEVEL_MEDIUM
                             animated:NO];
}

#pragma mark - YMKMapViewDelegate
- (YMKAnnotationView *)mapView:(YMKMapView *)aMapView viewForAnnotation:(id<YMKAnnotation>)anAnnotation {
    static NSString * identifier = @"MapPointAnnotation";
    YMKPinAnnotationView *view = (YMKPinAnnotationView *)[aMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (1) {
        view = [[YMKPinAnnotationView alloc] initWithAnnotation:anAnnotation reuseIdentifier:identifier];
    }
    
    if ([view.annotation isKindOfClass:[PointAnnotation class]]) {
        view.image = [UIImage imageNamed:@"map_pin.png"];
        view.canShowCallout = YES;
    }
    return view;
}
#pragma mark -

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
    //[self configureAndInstallAnnotations];
    
    [self changeAnnotationsCategory:self.btnATMs];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.currentCity.delegate = nil;
    [super viewWillDisappear:animated];
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
    [self setTableView:nil];
    [self setContentScrollView:nil];
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
            self.contentCategory = CATEGORY_ATMS;
            break;
        case 1: category = @"Адреса отделений:";
            self.contentCategory = CATEGORY_OFFICES;
            break;
        case 2: category = @"Все вместе:";
            self.contentCategory = CATEGORY_ALL;
            break;
    }
    self.lblAnnotationsCategory.text = category;
    [self.lblAnnotationsCategory sizeToFit];
    CGRect frame = self.btnCity.frame;
    frame.origin.x = self.lblAnnotationsCategory.frame.origin.x + self.lblAnnotationsCategory.frame.size.width + 8;
    self.btnCity.frame = frame;
}

#pragma mark - CitiesPickerDelegate
- (void)citiesPickerDidPickCity:(City *)city {
    [self.citiesPopover dismissPopoverAnimated:YES];
    self.currentCity = city;
}

#pragma mark - UITableViewDataSource
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.contentCategory) {
        case CATEGORY_ATMS:
            if (!self.currentCity.atms) {
                return 0;
            }
            else return self.currentCity.atms.count;
            break;
        case CATEGORY_OFFICES:
            if (!self.currentCity.offices) {
                return 0;
            }
            else return self.currentCity.offices.count;
            break;
        case CATEGORY_ALL:
            if (!self.currentCity.offices && self.currentCity.atms) {
                return 0;
            }
            else return self.currentCity.offices.count + self.currentCity.atms.count;
            break;
        default: return 0;
    }
}
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
    
    lblName.text = @"";
    lblAddress.text = @"";
    lblHours.text = @"";
    usd.hidden = YES;
    rub.hidden = YES;

    if (self.contentCategory == CATEGORY_ATMS) {
        ATM *atm = [self.currentCity.atms objectAtIndex:indexPath.row];
        lblName.text = atm.name;
        lblAddress.text = atm.address;
        lblHours.text = atm.hours;
        usd.hidden = [atm.currency rangeOfString:@"usd" options:NSCaseInsensitiveSearch].location == NSNotFound;
        rub.hidden = [atm.currency rangeOfString:@"rub" options:NSCaseInsensitiveSearch].location == NSNotFound;
    }
    
    if (self.contentCategory == CATEGORY_OFFICES) {
        Office *office = [self.currentCity.offices objectAtIndex:indexPath.row];
        lblName.text = office.name;
        lblAddress.text = office.address;
        //lblHours.text = atm.hours;
        //usd.hidden = [atm.currency rangeOfString:@"usd" options:NSCaseInsensitiveSearch].location == NSNotFound;
        //rub.hidden = [atm.currency rangeOfString:@"rub" options:NSCaseInsensitiveSearch].location == NSNotFound;
    }
    if (self.contentCategory == CATEGORY_ALL) {
        NSObject *object = [self.currentCity.objects objectAtIndex:indexPath.row];
        if ([object isKindOfClass:[ATM class]]) {
            ATM *atm = (ATM *)object;
            lblName.text = atm.name;
            lblAddress.text = atm.address;
            lblHours.text = atm.hours;
            usd.hidden = [atm.currency rangeOfString:@"usd" options:NSCaseInsensitiveSearch].location == NSNotFound;
            rub.hidden = [atm.currency rangeOfString:@"rub" options:NSCaseInsensitiveSearch].location == NSNotFound;
            
        } else if ([object isKindOfClass:[Office class]]) {
            Office *office = (Office *)object;
            lblName.text = office.name;
            lblAddress.text = office.address;
        }
     }
    
    return cell;
}

#pragma mark - UITableViewDelegate 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.contentScrollView scrollRectToVisible:self.mapView.frame animated:YES];
    UITableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
    UILabel *lblAddress = (UILabel *)[selectedCell viewWithTag:TAG_ADDRESS_LABEL];
    int mapObjectIndex = [self.annotations indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        PointAnnotation *annotation = (PointAnnotation *)obj;
        if ([annotation.mapObject.address isEqualToString:lblAddress.text]) {
            *stop = YES;
            return YES;
        }
        else return NO;
    }];
    
    PointAnnotation *selectedAnnotation = (PointAnnotation *)[self.annotations objectAtIndex:mapObjectIndex];
    [self.mapView setSelectedAnnotation:selectedAnnotation];
    [self.mapView setCenterCoordinate:selectedAnnotation.coordinate atZoomLevel:ZOOM_LEVEL_LARGE animated:YES];
}

#pragma mark - CityDelegate
- (void)cityObjectsDidFailWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    //[MBProgressHUD hideHUDForView:self.tableView animated:YES];
}

- (void)cityObjectsDidLoad {
    [self.tableView reloadData];
    CGRect frame = self.tableView.frame;
    frame.size.height = self.tableView.rowHeight * [self.tableView numberOfRowsInSection:0];
    self.tableView.frame = frame;
    
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.frame.size.width, self.mapView.frame.size.height + 8 + self.tableView.frame.size.height + 20);
    
    NSMutableArray *annotations = [NSMutableArray array];
    switch (self.contentCategory) {
        case CATEGORY_ALL:
            for (ATM *atm in self.currentCity.atms) {
                if (CLLocationCoordinate2DIsValid(atm.coordinate)) {
                    PointAnnotation *annotation = [PointAnnotation pointAnnotation];
                    annotation.title = atm.name;
                    annotation.subtitle = atm.address;
                    annotation.coordinate = atm.coordinate;
                    annotation.mapObject = atm;
                    [annotations addObject:annotation];
                }
            }
            for (Office *office in self.currentCity.offices) {
                if (CLLocationCoordinate2DIsValid(office.coordinate)) {
                    PointAnnotation *annotation = [PointAnnotation pointAnnotation];
                    annotation.title = office.name;
                    annotation.subtitle = office.address;
                    annotation.coordinate = office.coordinate;
                    annotation.mapObject = office;
                    [annotations addObject:annotation];
                }
            }
            break;
        case CATEGORY_ATMS:
            for (ATM *atm in self.currentCity.atms) {
                if (CLLocationCoordinate2DIsValid(atm.coordinate)) {
                    PointAnnotation *annotation = [PointAnnotation pointAnnotation];
                    annotation.title = atm.name;
                    annotation.subtitle = atm.address;
                    annotation.coordinate = atm.coordinate;
                    annotation.mapObject = atm;
                    [annotations addObject:annotation];
                }
            }
            break;
        case CATEGORY_OFFICES:
            for (Office *office in self.currentCity.offices) {
                if (CLLocationCoordinate2DIsValid(office.coordinate)) {
                    PointAnnotation *annotation = [PointAnnotation pointAnnotation];
                    annotation.title = office.name;
                    annotation.subtitle = office.address;
                    annotation.coordinate = office.coordinate;
                    annotation.mapObject = office;
                    [annotations addObject:annotation];
                }
            }
            break;
        default: break;
    }
    
    self.annotations = annotations;
    [self updateMap];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    //[MBProgressHUD hideHUDForView:self.tableView animated:YES];
}

#pragma mark -
- (void)updateMap {
    if (self.mapView.annotations) {
        [self.mapView removeAnnotations:self.mapView.annotations];
    }
    if (self.annotations) {
        [self.mapView addAnnotations:self.annotations];
    }
}

@end
