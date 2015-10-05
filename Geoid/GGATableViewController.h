//
//  GGATableViewController.h
//  Geoid
//
//  Created by Cody Smith on 10/3/15.
//  Copyright © 2015 Cody Smith. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <MapKit/MapKit.h>
#import "GGA.h"

@interface GGATableViewController : NSObject <NSTableViewDataSource, NSTableViewDelegate> {
@private
    NSMutableArray *_tableContents;
    NSTableView *_tableView;
    MKMapView *_mapView;
}

- (id) initWithData:(NSTableView *)tableView mapView:(MKMapView *) mapView;
- (void) addPointToMap:(double)latitude longitude:(double)longitude;
- (void) addLine:(NSString *)line;

@end
