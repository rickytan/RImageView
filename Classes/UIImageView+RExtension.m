//
//  UIImageView+RExtension.m
//  RImageView
//
//  Created by ricky on 13-3-30.
//  Copyright (c) 2013年 ricky. All rights reserved.
//

#import "UIImageView+RExtension.h"
#import <ImageIO/ImageIO.h>

@implementation UIImageView (RExtension)

- (void)setGifImage:(NSString *)gifImageName
{
    CGImageSourceRef source = nil;
    
    NSData *data = [NSData dataWithContentsOfFile:gifImageName];
    if (!data) {
        NSString *path = [[NSBundle mainBundle] pathForResource:gifImageName
                                                         ofType:nil];
        data = [NSData dataWithContentsOfFile:path];
    }
    
    if (!data) {
        NSLog(@"Can't load file: %@",gifImageName);
        return;
    }
    
    NSDictionary *options = [NSDictionary dictionaryWithObject:(id)kCGImagePropertyGIFDictionary
                                                        forKey:(id)kCGImageSourceTypeIdentifierHint];
    source = CGImageSourceCreateWithData((CFDataRef)data, (CFDictionaryRef)options);
    if (!source) {
        NSLog(@"Can't open GIF file: %@",gifImageName);
        return;
    }
    
    if (CGImageSourceGetStatus(source) != kCGImageStatusComplete) {
        NSLog(@"File format not supportted: %@",gifImageName);
        return;
    }
    
    CFIndex count = CGImageSourceGetCount(source);
    if (count == 0) {
        NSLog(@"No frames in file: %@",gifImageName);
        return;
    }
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:count];
    for (CFIndex i=0; i < count; ++i) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        if (images)
            [images addObject:[UIImage imageWithCGImage:image]];
        else {
            NSLog(@"Frame %lu load failed!",i);
        }
    }
    self.animationImages = [NSArray arrayWithArray:images];
    
    NSDictionary *properties = (NSDictionary*)CGImageSourceCopyProperties(source, NULL);
    properties = [properties objectForKey:(id)kCGImagePropertyGIFDictionary];
    
    NSTimeInterval delay = [[properties objectForKey:(id)kCGImagePropertyGIFDelayTime] floatValue];
    delay = MAX(delay, 0.1);
    CGFloat loopCount = [[properties objectForKey:(id)kCGImagePropertyGIFLoopCount] floatValue];
    
    self.animationRepeatCount = loopCount;
    self.animationDuration = delay * count;
    
    [self startAnimating];
}

@end
