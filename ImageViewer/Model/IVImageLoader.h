//
//  IVImageLoader.h
//  ImageViewer
//
//  Created by Dmytro Shevchuk on 23.03.2018.
//  Copyright © 2018 PaksHome. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Cocoa;
@class IVImagePropertyContainer;

@interface IVImageLoader : NSObject
- (IVImagePropertyContainer *)imageContainerAtIndex:(NSInteger)index;
- (NSUInteger)countOfImages;
- (void)addImageByURL:(NSURL *)url;
@end
