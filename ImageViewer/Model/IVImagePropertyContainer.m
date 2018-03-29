//
//  IVImagePropertyContainer.m
//  ImageViewer
//
//  Created by Dmytro Shevchuk on 29.03.2018.
//  Copyright © 2018 PaksHome. All rights reserved.
//

#import "IVImagePropertyContainer.h"
#import "NSImageThumbnailExtensions.h"

#define IV_THUMBNAIL_WIDTH 1080.0f
#define IV_THUMBNAIL_HEIGHT 1080.0f

@interface IVImagePropertyContainer()
@property (nonatomic, readwrite, strong) NSImage *thumbnailImage;
@end

@implementation IVImagePropertyContainer

- (instancetype)init {
    return [self initWithImageName:nil andImageURL:nil];
}

- (instancetype)initWithImageName:(NSString *)imageName {
    return [self initWithImageName:imageName andImageURL:nil];
}

- (instancetype)initWithImageURL:(NSURL *)imageURL {
    return [self initWithImageName:nil andImageURL:imageURL];
}

- (instancetype)initWithImageName:(NSString *)imageName andImageURL:(NSURL *)imageURL {
    self = [super init];
    
    if (self) {
        if (imageName) {
            _image = [NSImage imageNamed:imageName];
            _thumbnailImage = _image;
        } else if (imageURL) {
            _image = [[NSImage alloc] initWithContentsOfURL:imageURL];
            _URL = imageURL;
        }
    }
    
    return self;
}

- (void)thumbnailImage:(void (^)(NSImage *))thumbnailImage {
    if (_thumbnailImage) {
        thumbnailImage(_thumbnailImage);
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSImage *thumbnailImageLocal = [NSImage iteThumbnailImageWithContentsOfURL:_URL
                                                                              size:NSMakeSize(IV_THUMBNAIL_WIDTH, IV_THUMBNAIL_HEIGHT)];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            _thumbnailImage = thumbnailImageLocal;
            thumbnailImage(_thumbnailImage);
        });
    });
}

@end
