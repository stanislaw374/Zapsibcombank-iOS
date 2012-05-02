//
//  CitiesView.h
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 03.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@protocol CitiesPickerDelegate
- (void)citiesPickerDidPickCity:(City *)city;
@end

@interface CitiesView : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, CityDelegate>
@property (nonatomic, unsafe_unretained) id<CitiesPickerDelegate> delegate;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;
@property (unsafe_unretained, nonatomic) IBOutlet UISearchBar *searchBar;
@end

