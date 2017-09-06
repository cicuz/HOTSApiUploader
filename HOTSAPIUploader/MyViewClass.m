//
//  MyViewClass.m
//  HOTSAPIUploader
//
//  Created by Michele Ciccozzi on 05/09/2017.
//  Copyright © 2017 developingcico. All rights reserved.
//

#import "MyViewClass.h"
#import "Uploader.h"

@implementation MyViewClass

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
        for (NSString *file in files) {
            [Uploader uploadFile:file];
        }
    }
    return YES;
}

- (void)concludeDragOperation:(id<NSDraggingInfo>)sender {
    printf("Conclude\n");
}

@end
