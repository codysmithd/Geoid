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

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.GGAArray = [[NSMutableArray alloc] init];
    self.GGATableController = [[GGATableViewController alloc] init];
    [self.GGATableController setData:self.GGAArray];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void) addDataFromBundleFile:(NSString *)bundleFileName {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundleFileName ofType:@"txt"];
    [self addDataFromFile:bundlePath];
}

- (void) addDataFromFile:(NSString *)filePath {
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.outputDisplay setString:content];
    NSArray *lines = [content componentsSeparatedByString: @"\n"];
    for (NSString *line in lines) {
        NSArray *contents = [line componentsSeparatedByString:@","];
        if([contents[0] isEqualToString: GGA_HEADER]) {
            [self.GGAArray addObject:[[GGA alloc] initFromData:line]];
        }
    }
}

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
@end
