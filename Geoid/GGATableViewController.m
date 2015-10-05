//
//  GGATableViewController.m
//  Geoid
//
//  Created by Cody Smith on 10/3/15.
//  Copyright © 2015 Cody Smith. All rights reserved.
//

#import "GGATableViewController.h"
#import "GGA.h"

@implementation GGATableViewController

- (id) initWithData:(NSTableView *)tableView mapView:(MKMapView *)mapView {
    _tableContents = [[NSMutableArray alloc] init];
    _tableView = tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _mapView = mapView;
    return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [_tableContents count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)rowIndex {
    GGA *gga = [_tableContents objectAtIndex:rowIndex];
    NSString *identifier = [tableColumn identifier];
    
    if([identifier isEqualToString:@"time"]){
        return gga.utc_time;
    } else if ([identifier isEqualToString:@"latitude"]){
        if(gga.n_s == NORTH){
            return [NSString stringWithFormat:@"%f N", gga.latitude];
        }
        return [NSString stringWithFormat:@"%f S", gga.latitude];
    } else if ([identifier isEqualToString:@"longitude"]){
        if(gga.e_w == EAST){
            return [NSString stringWithFormat:@"%f E", gga.longitude];
        }
        return [NSString stringWithFormat:@"%f W", gga.longitude];
    } else if ([identifier isEqualToString:@"position_fix_indicator"]){
        return [NSString stringWithFormat:@"%i", gga.pos_fix_indicator];
    } else if ([identifier isEqualToString:@"satellites_used"]){
        return [NSString stringWithFormat:@"%i", gga.satellites_used];
    } else if ([identifier isEqualToString:@"hdop"]){
        return [NSString stringWithFormat:@"%f", gga.hdop];
    } else if ([identifier isEqualToString:@"msl"]){
        return [NSString stringWithFormat:@"%f %@", gga.msl, gga.msl_units];
    } else if ([identifier isEqualToString:@"geoid_separation"]){
        return [NSString stringWithFormat:@"%f %@", gga.geoid_separation, gga.geoid_separation_units];
    } else if ([identifier isEqualToString:@"dgps_age"]){
        return [NSString stringWithFormat:@"%f", gga.dgps_age];
    } else if ([identifier isEqualToString:@"dgps_station_id"]){
        return [NSString stringWithFormat:@"%i", gga.dgps_station_id];
    } else if ([identifier isEqualToString:@"checksum"]){
        if(gga.checksum){
            return @"Valid";
        }
        return @"Invalid";
    }
    return nil;
}

- (void) addLine:(NSString *)line {
    NSArray *contents = [line componentsSeparatedByString:@","];
    if([contents[0] isEqualToString: GGA_HEADER]) {
        GGA* gga = [[GGA alloc] initFromData:line];
        [_tableContents addObject: gga];
        [_tableView reloadData];
        [self addPointToMap:gga];
    }
}

- (void) addPointToMap:(GGA *) gga{
    float latitude = gga.latitude;
    if (gga.n_s == SOUTH) {
        latitude = latitude * -1;
    }
    float longitude = gga.longitude;
    if(gga.e_w == WEST) {
        longitude = longitude * -1;
    }
    NSLog(@"Lat: %f, Long: %f", latitude, longitude);
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latitude, longitude);
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion region = {coord, span};
    [_mapView setRegion:region];
    [annotation setCoordinate:coord];
    [_mapView addAnnotation: annotation];
}

@end
