//
//  SerialConnectWindowController.m
//  Geoid
//
//  Created by Cody Smith on 10/6/15.
//  Copyright © 2015 Cody Smith. All rights reserved.
//

#import "SerialConnectWindowController.h"

@interface SerialConnectWindowController ()

@end

@implementation SerialConnectWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    // Load up some serial stuff
}

- (id)initWithNibAndDelegate:(NSString *)nibFile delegate:(NSObject *)delegate {
    self = [self initWithWindowNibName:nibFile];
    _delegate = delegate;
    return self;
}

- (IBAction)cancelWindow:(id)sender {
    [self close];
}

- (NSString*)dialogComplete {
    return @"";
}

@end
