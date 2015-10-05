//
//  AppDelegate.h
//  Geoid
//
//  Created by Cody Smith on 10/2/15.
//  Copyright © 2015 Cody Smith. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GGATableViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property GGATableViewController* ggaTableViewController;

// Open Text Data File menu item
- (IBAction)openTextDataFile:(id)sender;

@end

