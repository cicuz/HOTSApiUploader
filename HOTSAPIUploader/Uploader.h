//
//  Uploader.h
//  HOTSAPIUploader
//
//  Created by Michele Ciccozzi on 2017-09-05.
//  Copyright © 2017 developingcico. All rights reserved.
//

#ifndef Uploader_h
#define Uploader_h

@interface Uploader : NSObject

+ (void)uploadFile:(NSString *)aFile completion:(void(^)(NSData *))callback;

@end

#endif /* Uploader_h */
