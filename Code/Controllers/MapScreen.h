//
//  MapScreen.h
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 03.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YandexMapKit.h"
#import "CitiesView.h"
#import "City.h"

@interface MapScreen : UIViewController <YMKMapViewDelegate, CitiesPickerDelegate, UITableViewDataSource, UITableViewDelegate, CityDelegate>
{
    //BOOL _isLoading;
}
@property (unsafe_unretained, nonatomic) IBOutlet YMKMapView *mapView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnCity;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *arrow;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnATMs;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnOffices;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnAll;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblAnnotationsCategory;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *contentScrollView;
- (IBAction)goBack;
- (IBAction)goMain;
- (IBAction)chooseCity:(UIButton *)button;
- (IBAction)changeAnnotationsCategory:(id)sender;
@end
