//
//  SerialConnectWindowController.h
//  Geoid
//
//  Created by Cody Smith on 10/6/15.
//  Copyright © 2015 Cody Smith. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SerialConnectWindowController : NSWindowController

@property (strong) NSWindow* serialConnectWindow;
@property (strong) NSObject* delegate;

- (id)initWithNibAndDelegate:(NSString *)nibFile delegate:(NSObject *)delegate;

- (IBAction)cancelWindow:(id)sender;

- (NSString *)dialogComplete;

@end
