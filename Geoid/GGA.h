//
//  GGA.h
//  Object to represent GGA Global Positioning System Fixed Data
//  Geobugger
//
//  Created by Cody Smith on 10/1/15.
//  Copyright © 2015 Cody Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

enum direction {
    NORTH,
    SOUTH,
    EAST,
    WEST
};

@interface GGA : NSObject

- (id) init;

- (void) readFromData:(NSString *) data;

// UTC Time (hhmmss.sss)
@property (assign) NSString* time;

// Latitude
@property (assign) float latitude;

// North/South indicator
@property (assign) enum direction n_s;

// Longitude
@property (assign) float longitude;

// East/West indicator
@property (assign) enum direction e_w;

// Position fix indicator
@property (assign) int pos_fix_indicator;

// Satellites Used
@property (assign) int satellites_used;

// HDOP (Horizontal Dilution of Precision)
@property (assign) float hdop;

// MSL Altitude
@property (assign) float msl;

// MSL Altitude Units (always M for meters)
@property (assign) NSString* msl_units;

// Geoid Separation
@property (assign) float geoid_separation;

// Geoid Separation Units (always M for meters)
@property (assign) NSString* geoid_separation_units;

// Age of diff correction, if enabled, time in seconds since last DGPS update
@property (assign) float dgps_age;

// DGPS Station ID
@property (assign) int dgps_station_id;

// Message checksum is correct or not
@property (assign) bool checksum;


@end
