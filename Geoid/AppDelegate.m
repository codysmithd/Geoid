//
//  AppDelegate.m
//  Geoid
//
//  Created by Cody Smith on 10/2/15.
//  Copyright © 2015 Cody Smith. All rights reserved.
//

#import "AppDelegate.h"
#import "GGA.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    GGA *testGGA = [[GGA alloc] init];
    [testGGA readFromData:@"$GPGGA,192035.000,4305.0972,N,07740.6950,W,1,08,0.9,169.8,M,-34.4,M,,0000*6B"];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
