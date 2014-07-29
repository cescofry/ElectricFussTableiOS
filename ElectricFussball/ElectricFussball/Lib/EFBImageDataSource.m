//
//  EFBImageDataSource.m
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBImageDataSource.h"


@implementation NSURLRequest (Untrusted)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}

@end

@interface EFBImageDataSource () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSCache *imageChache;
@property (nonatomic, strong) NSMutableDictionary *operations;

@end

@implementation EFBImageDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageChache = [[NSCache alloc] init];
        [self.imageChache setCountLimit:100];
        
        self.operations = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)imageAtURL:(NSURL *)url completionBlock:(imageComplitonBlock)completionBlock
{
    if (!url) {
        return;
    }
    
    NSData *data = nil;
    NSString *key = url.absoluteString;
    data = [self.imageChache objectForKey:key];
    if (data) {
        completionBlock(data);
        return;
    }
    
    EFBImageOperation *op = [self.operations objectForKey:key];
    if (op) {
        [op addCompletionBlock:completionBlock];
        [self.operations setObject:op forKey:key];
    }
    else {
        op = [[EFBImageOperation alloc] init];
        [op addCompletionBlock:completionBlock];
        [self.operations setObject:op forKey:key];
        
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            NSString *key = response.URL.absoluteString;
            
            if (!key || connectionError) {
                NSLog(@"%@", connectionError);
                return;
            }
            
            EFBImageOperation *op = [self.operations objectForKey:key];
            [op dispatchData:data];
            
            [self.imageChache setObject:data forKey:key];
            [self.operations removeObjectForKey:key];
        }];
        
    }
    
}

+ (void)imageAtURL:(NSURL *)url completionBlock:(imageComplitonBlock)completionBlock
{
    [[self sharedObject] imageAtURL:url completionBlock:completionBlock];
}

#pragma mark --
#pragma mark Singleton related Methods

static EFBImageDataSource *sharedObject = nil;


+ (instancetype)sharedObject {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[EFBImageDataSource alloc] init];
    });
    
    return sharedObject;
}

@end

@interface EFBImageOperation ()

@property (nonatomic, strong, readonly) NSMutableArray *completionBlocks;

@end


@implementation EFBImageOperation

- (instancetype)init
{
    self = [super init];
    if (self) {
        _completionBlocks = [NSMutableArray array];
    }
    return self;
}

- (void)addCompletionBlock:(imageComplitonBlock)block
{
    [self.completionBlocks addObject:[block copy]];
}

- (void)dispatchData:(NSData *)data
{
    [self.completionBlocks enumerateObjectsUsingBlock:^(imageComplitonBlock block, NSUInteger idx, BOOL *stop) {
        block([data copy]);
    }];
}

@end
