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
@property (unsafe_unretained) IBOutlet NSTextView *outputDisplay;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.GGAArray = [[NSMutableArray alloc] init];
    [self addDataFromFile:@"test_data"];
    NSLog(@"Number of GGA messages: %lu", [self.GGAArray count]);
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void) addDataFromFile:(NSString *)filePath {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:filePath ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:bundlePath encoding:NSUTF8StringEncoding error:nil];
    [self.outputDisplay setString:content];
    NSArray *lines = [content componentsSeparatedByString: @"\n"];
    for (NSString *line in lines) {
        NSArray *contents = [line componentsSeparatedByString:@","];
        if([contents[0] isEqualToString: GGA_HEADER]) {
            [self.GGAArray addObject:[[GGA alloc] initFromData:line]];
        }
    }

}

@end
