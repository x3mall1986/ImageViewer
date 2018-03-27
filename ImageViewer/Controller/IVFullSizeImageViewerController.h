//
//  IVFullSizeImageViewerController.h
//  ImageViewer
//
//  Created by Dmytro Shevchuk on 27.03.2018.
//  Copyright © 2018 PaksHome. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class IVImageLoader;

@interface IVFullSizeImageViewerController : NSViewController

- (void)showImageFromLoader:(IVImageLoader *)imageLoader byIndex:(NSInteger)index;

@end
