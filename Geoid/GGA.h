//
//  GGA.h
//  Object to represent GGA Global Positioning System Fixed Data
//  Geobugger
//
//  Created by Cody Smith on 10/1/15.
//  Copyright © 2015 Cody Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    NORTH,
    SOUTH,
    EAST,
    WEST
} direction;

@interface GGA : NSObject

-(void)

// UTC Time (hhmmss.sss)
@property (assign) NSString* time;

// Latitude
@property (assign) float latitude;

// North/South indicator
@property (assign) direction n_s;

// Longitude
@property (assign) float longitude;

// East/West indicator
@property (assign) direction e_w;

// Position fix indicator
@property (assign) int pos_fix_indicator;

// Satellites Used
@property (assign) int satellites_used;

// HDOP (Horizontal Dilution of Precision)
@property (assign) float hdop;

// MSL Altitude
@property (assign) float msl;

// MSL Altitude Units (typically M for meters)
@property (assign) NSString* msl_units;

// Geoid Separation
@property (assign) float geoid_separation;

// Geoid Separation Units (typically M for meters)
@property (assign) NSString* geoid_separation_units;

// Age of diff correction, if enabled. Time in seconds since last DGPS update
@property (assign) float dgps_age;

// DGPS Station ID
@property (assign) int dgps_station_id;

// Message checksum
@property (assign) NSString* checksum;


@end
