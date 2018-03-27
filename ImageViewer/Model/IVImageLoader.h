//
//  IVImageLoader.h
//  ImageViewer
//
//  Created by Dmytro Shevchuk on 23.03.2018.
//  Copyright © 2018 PaksHome. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Cocoa;

@interface IVImageLoader : NSObject

- (NSImage *)imageAtIndex:(NSInteger)index;
- (NSUInteger)countOfImages;
- (void)addImageByURL:(NSURL *)url;
@end
