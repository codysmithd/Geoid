//
//  GGA.m
//  Geoid
//
//  Created by Cody Smith on 10/2/15.
//  Copyright © 2015 Cody Smith. All rights reserved.
//

#import "GGA.h"

@implementation GGA

- (id) init {
    self = [super init];
    
    if (self) {
        self.utc_time = @"000000.000";
        self.latitude = 0.0;
        self.n_s = NORTH;
        self.longitude = 0.0;
        self.e_w = EAST;
        self.pos_fix_indicator = 0;
        self.satellites_used = 0;
        self.hdop = 0;
        self.msl = 0;
        self.msl_units = @"M";
        self.geoid_separation = 0.0;
        self.geoid_separation_units = @"M";
        self.dgps_age = 0.0;
        self.dgps_station_id = 0;
        self.checksum = false;
    }
    
    return self;
}

- (id) initFromData:(NSString *)data {
    self = [self init];
    [self readFromData:data];
    return self;
}

- (void) readFromData:(NSString *)data {
    NSArray *elements = [data componentsSeparatedByString: @","];
    if ([elements[0] isEqualToString: GGA_HEADER] && [elements count] == 15) {
        
        // Do checksum
        NSArray *checksumSplit = [elements[14] componentsSeparatedByString:@"*"];
        unsigned int checksum = 0;
        NSScanner *scanner = [NSScanner scannerWithString:checksumSplit[1]];
        [scanner scanHexInt:&checksum];
        NSMutableString *sumString = [NSMutableString string];
        for (int i=0;i<=13;i++){
            [sumString appendString:elements[i]];
            [sumString appendString:@","];
        }
        [sumString deleteCharactersInRange:NSMakeRange(0,1)];
        [sumString appendString:checksumSplit[0]];
        unsigned int sum = 0;
        for (int i=0;i<sumString.length;i++) {
            sum = sum ^ [sumString characterAtIndex:i];
        }
        self.checksum = (sum == checksum);
        
        // Add properties to object from data
        self.utc_time =  [[NSString alloc] initWithFormat:@"%@:%@:%@ UTC", [elements[1] substringWithRange:NSMakeRange(0,2)], [elements[1] substringWithRange:NSMakeRange(2,2)], [elements[1] substringFromIndex:4]];
        self.latitude = [self getDegrees:elements[2]];
        if ([elements[3] isEqualToString:@"N"]) {
            self.n_s = NORTH;
        } else {
            self.n_s = SOUTH;
        }
        self.longitude = [self getDegrees:elements[4]];
        if ([elements[5] isEqualToString:@"E"]) {
            self.e_w = EAST;
        } else {
            self.e_w = WEST;
        }
        self.pos_fix_indicator = [elements[6] intValue];
        self.satellites_used = [elements[7] intValue];
        self.hdop = [elements[8] doubleValue];
        self.msl = [elements[9] doubleValue];
        self.msl_units = elements[10];
        self.geoid_separation = [elements[11] doubleValue];
        self.geoid_separation_units = elements[12];
        self.dgps_age = [elements[13] doubleValue];
        self.dgps_station_id = [checksumSplit[0] intValue];
    } else {
        [NSException raise: @"GGA_ERROR" format:@"Tried to create GGA object with invalid header"];
    }
}


// Get degree value for latitude or longitude from NMEA string
// 4533.35
- (double) getDegrees: (NSString *) latOrLong {
    NSArray *data = [latOrLong componentsSeparatedByString:@"."];
    int index = (int)[data[0] length] - 2;
    NSString* min_string = [NSString stringWithFormat:@"%@.%@",[latOrLong substringWithRange:NSMakeRange(index, 2)], data[1]];
    double min =[min_string doubleValue];
    double deg = [[latOrLong substringToIndex:index] doubleValue];
    return deg + (min/60);
}

// Returns a string for the int position fix value
- (NSString *) getPositionFixString {
    switch (self.pos_fix_indicator) {
        case 0:
            return @"Invalid";
            break;
        case 1:
            return @"GPS Fix (SPS)";
            break;
        case 2:
            return @"DGPS Fix";
            break;
        case 3:
            return @"PPS Fix";
            break;
        case 4:
            return @"Real Time Kinematic";
            break;
        case 5:
            return @"Float RTK";
            break;
        case 6:
            return @"Estimated";
            break;
        case 7:
            return @"Manual Input Mode";
            break;
        case 8:
            return @"Simulation Mode";
            break;
        
    }
    return [NSString stringWithFormat:@"%i", self.pos_fix_indicator];
}

@end
