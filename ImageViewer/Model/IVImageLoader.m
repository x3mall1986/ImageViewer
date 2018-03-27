//
//  IVImageLoader.m
//  ImageViewer
//
//  Created by Dmytro Shevchuk on 23.03.2018.
//  Copyright © 2018 PaksHome. All rights reserved.
//

#import "IVImageLoader.h"

@interface IVImageLoader()
@property (strong) NSMutableArray <NSImage *>*images;
@end

@implementation IVImageLoader

#pragma mark - Inits
- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.images = [[self imagesFromAssets] mutableCopy];
    }
    
    return self;
}

#pragma mark - Private Methods
- (NSArray *)imagesFromAssets {
    NSArray *array = @[[NSImage imageNamed:@"Photo_1"],
                       [NSImage imageNamed:@"Photo_2"]];
    return array;
}

#pragma mark - Public Methods
- (NSUInteger)countOfImages {
    return self.images.count;
}

- (NSImage *)imageAtIndex:(NSInteger)index {
    return self.images[index];
}

- (void)addImageByURL:(NSURL *)url {
    NSImage *image = [[NSImage alloc] initWithContentsOfURL:url];
    if (image) {
        [self.images addObject:image];
    }
}

@end
