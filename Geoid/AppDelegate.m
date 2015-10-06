//
//  AppDelegate.m
//  Geoid
//
//  Created by Cody Smith on 10/2/15.
//  Copyright © 2015 Cody Smith. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (unsafe_unretained) IBOutlet NSTextView *outputDisplay;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet MKMapView *mapView;

@end

@implementation AppDelegate

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.ggaTableViewController = [[GGATableViewController alloc] initWithData:_tableView mapView:_mapView];
    //[self addDataFromBundleFile:@"test_data"]; // for Debugging
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {}

// Add data from test file in bundle. Useful for debugging.
- (void) addDataFromBundleFile:(NSString *)bundleFileName {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundleFileName ofType:@"txt"];
    [self addDataFromFile:bundlePath];
}

// Add data from text file.
- (void) addDataFromFile:(NSString *)filePath {
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.outputDisplay setString:content];
    NSArray *lines = [content componentsSeparatedByString: @"\n"];
    for (NSString *line in lines) {
        [self.ggaTableViewController addLine: line];
    }
}

// Action called when menu option for open text data file.
- (IBAction)openTextDataFile:(id)sender {
    NSOpenPanel* openPanel = [NSOpenPanel openPanel];
    openPanel.title = @"Choose a .TXT file";
    openPanel.showsResizeIndicator = YES;
    openPanel.showsHiddenFiles = NO;
    openPanel.canChooseDirectories = NO;
    openPanel.canCreateDirectories = YES;
    openPanel.allowsMultipleSelection = NO;
    openPanel.allowedFileTypes = @[@"txt"];
    [openPanel beginWithCompletionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            NSURL* selectedDoc = [[openPanel URLs] objectAtIndex:0];
            [self addDataFromFile: [selectedDoc path]];
        }
        
    }];
    
}

- (IBAction)clearData:(NSButton *)sender {
    [_outputDisplay setString:@""];
    [_ggaTableViewController clearData];
}

@end
