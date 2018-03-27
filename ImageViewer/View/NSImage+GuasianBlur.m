//
//  NSImage+GuasianBlur.m
//  ImageViewer
//
//  Created by Dmytro Shevchuk on 27.03.2018.
//  Copyright © 2018 PaksHome. All rights reserved.
//

@import QuartzCore;
#import "NSImage+GuasianBlur.h"

@implementation NSImage (GuasianBlur)

- (NSImage *)iv_guasianBlur {
    CIImage* inputImage = [CIImage imageWithData:[self
                                                  TIFFRepresentation]];
    CIFilter* filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setDefaults];
    [filter setValue:inputImage forKey:@"inputImage"];
    CIImage* outputImage = [filter valueForKey:@"outputImage"];
    
    NSRect outputImageRect = NSRectFromCGRect([outputImage extent]);
    NSImage* blurredImage = [[NSImage alloc]
                             initWithSize:outputImageRect.size];
    [blurredImage lockFocus];
    [outputImage drawAtPoint:NSZeroPoint fromRect:outputImageRect
                   operation:NSCompositingOperationCopy fraction:1.0];
    [blurredImage unlockFocus];
    
    return blurredImage;
}

@end
