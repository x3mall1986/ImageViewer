//
//  IVImagePropertyContainer.h
//  ImageViewer
//
//  Created by Dmytro Shevchuk on 29.03.2018.
//  Copyright © 2018 PaksHome. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Cocoa;

@interface IVImagePropertyContainer : NSObject
@property (nonatomic, readonly, strong) NSImage *image;
@property (nonatomic, readonly, strong) NSURL *URL;

- (instancetype)initWithImageName:(NSString *)imageName;
- (instancetype)initWithImageURL:(NSURL *)imageURL;
- (instancetype)initWithImageName:(NSString *)image andImageURL:(NSURL *)URL NS_DESIGNATED_INITIALIZER;

- (void)thumbnailImage:(void (^)(NSImage *))thumbnailImage;
@end
