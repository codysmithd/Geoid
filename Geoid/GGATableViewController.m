//
//  GGATableViewController.m
//  Geoid
//
//  Created by Cody Smith on 10/3/15.
//  Copyright © 2015 Cody Smith. All rights reserved.
//

#import "GGATableViewController.h"

@implementation GGATableViewController

- (void) setData:(NSMutableArray *)newData {
    _tableContents = newData;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return 2;
    //return [_tableContents count];
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    NSLog(@"Called viewForTableColumn");
    
    // Get an existing cell with the MyView identifier if it exists
    NSTextField *result = [tableView makeViewWithIdentifier:@"MyView" owner:self];
    
    // There is no existing cell to reuse so create a new one
    if (result == nil) {
        
        // Create the new NSTextField with a frame of the {0,0} with the width of the table.
        // Note that the height of the frame is not really relevant, because the row height will modify the height.
        result = [[NSTextField alloc] init];
        
        // The identifier of the NSTextField instance is set to MyView.
        // This allows the cell to be reused.
        result.identifier = @"MyView";
    }
    
    // result is now guaranteed to be valid, either as a reused cell
    // or as a new cell, so set the stringValue of the cell to the
    // nameArray value at row
    result.stringValue = @"Test Cell";
    
    return result;
    
}

@end
