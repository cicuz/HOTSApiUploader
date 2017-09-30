//
//  MyViewClass.m
//  HOTSAPIUploader
//
//  Created by Michele Ciccozzi on 05/09/2017.
//  Copyright © 2017 developingcico. All rights reserved.
//

#import "MyViewClass.h"
#import "Uploader.h"

@interface MyViewClass()

@property NSArray *filesArray;

@end


@implementation MyViewClass

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    NSLog(@"nrows called");
    self.leTable = tableView;
    return [self.filesArray count];
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    NSLog(@"viewfortablecol called");
    
    // Get an existing cell with the MyView identifier if it exists
    NSTextField *result = [tableView makeViewWithIdentifier:@"MyView" owner:self];
    
    // There is no existing cell to reuse so create a new one
    if (result == nil) {
        
        // Create the new NSTextField with a frame of the {0,0} with the width of the table.
        // Note that the height of the frame is not really relevant, because the row height will modify the height.
        result = [[NSTextField alloc] initWithFrame:CGRectMake(0, 0, 400, 30)];
        
        // The identifier of the NSTextField instance is set to MyView.
        // This allows the cell to be reused.
        result.identifier = @"MyView";
    }
    
    // result is now guaranteed to be valid, either as a reused cell
    // or as a new cell, so set the stringValue of the cell to the
    // nameArray value at row
    NSLog(@"%lu", row);
    NSLog(@"%@", [self.filesArray objectAtIndex:row]);
    result.stringValue = [self.filesArray objectAtIndex:row];
    
    // Return the result
    return result;
    
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    printf("Enter\n");
    return NSDragOperationEvery;
}

- (void)draggingExited:(id<NSDraggingInfo>)sender {
    printf("Exit\n");
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
    printf("Prepare\n");
    return YES;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    printf("Perform\n");
    
    NSPasteboard *pboard = [sender draggingPasteboard];
    
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        NSArray *files = [pboard propertyListForType:NSFilenamesPboardType];
        unsigned long numberOfFiles = [files count];
        printf("%lu\n", numberOfFiles);
        self.filesArray = files;
        [self.leTable reloadData];
        for (NSString *file in files) {
            [Uploader uploadFile:file completion:^(NSData *data) {
                NSDictionary *res_dict = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:NSJSONReadingMutableContainers
                                                                           error:nil];
                NSLog(@"result = %@", res_dict);
            }];
        }
    }
    return YES;
}

- (void)concludeDragOperation:(id<NSDraggingInfo>)sender {
    printf("Conclude\n");
}

@end
