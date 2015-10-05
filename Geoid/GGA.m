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
        self.utc_time = [[NSString alloc] initWithString: elements[1]];
        self.latitude = [elements[2] floatValue];
        self.latitude = self.latitude/100;
        if ([elements[3] isEqualToString:@"N"]) {
            self.n_s = NORTH;
        } else {
            self.n_s = SOUTH;
        }
        self.longitude = [elements[4] floatValue];
        self.longitude = self.longitude/100;
        if ([elements[5] isEqualToString:@"E"]) {
            self.e_w = EAST;
        } else {
            self.e_w = WEST;
        }
        self.pos_fix_indicator = [elements[6] intValue];
        self.satellites_used = [elements[7] intValue];
        self.hdop = [elements[8] floatValue];
        self.msl = [elements[9] floatValue];
        self.msl_units = elements[10];
        self.geoid_separation = [elements[11] floatValue];
        self.geoid_separation_units = elements[12];
        self.dgps_age = [elements[13] floatValue];
        self.dgps_station_id = [checksumSplit[0] intValue];
    } else {
        [NSException raise: @"GGA_ERROR" format:@"Tried to create GGA object with invalid header"];
    }
}

@end
