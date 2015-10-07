//
//  AppDelegate.h
//  Geoid
//
//  Created by Cody Smith on 10/2/15.
//  Copyright © 2015 Cody Smith. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GGATableViewController.h"
#import "SerialConnectWindowController.h"
#import <MapKit/MapKit.h>
#import <ORSSerial/ORSSerial.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property GGATableViewController* ggaTableViewController;

// Clear data button
- (IBAction)clearData:(NSButton *)sender;

// Open Text Data File menu item
- (IBAction)openTextDataFile:(id)sender;

// Open serial connection dialog
- (IBAction)openSerialConnectionWindow:(id)sender;

@end

