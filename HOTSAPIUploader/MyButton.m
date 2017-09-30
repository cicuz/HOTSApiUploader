//
//  MyButton.m
//  HOTSAPIUploader
//
//  Created by Michele Ciccozzi on 22/09/2017.
//  Copyright © 2017 developingcico. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

-(IBAction)openFolder:(id)sender {
    NSLog(@"opening stuff");
    NSString* folder = @"~/Library/Application Support/Blizzard/Heroes of the Storm/Accounts/";
    [[NSWorkspace sharedWorkspace] openFile:[folder stringByExpandingTildeInPath] withApplication:@"Finder"];
}

@end
