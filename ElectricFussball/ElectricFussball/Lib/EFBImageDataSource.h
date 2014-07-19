//
//  EFBImageDataSource.h
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^imageComplitonBlock)(NSData *);

@interface EFBImageDataSource : NSObject

+ (void)imageAtURL:(NSURL *)url completionBlock:(imageComplitonBlock)completionBlock;

@end


@interface EFBImageOperation : NSOperation

- (void)addCompletionBlock:(imageComplitonBlock)block;
- (void)dispatchData:(NSData *)data;

@end
