//
//  GGATableViewController.h
//  Geoid
//
//  Created by Cody Smith on 10/3/15.
//  Copyright © 2015 Cody Smith. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GGATableViewController : NSWindowController<NSTableViewDelegate,NSTableViewDataSource>

{
    @private NSMutableArray *_tableContents;
    @private IBOutlet NSTableView *_tableView;
}

- (void) setData:(NSMutableArray *)newData;
    
@end
