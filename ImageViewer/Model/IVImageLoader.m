//
//  IVImageLoader.m
//  ImageViewer
//
//  Created by Dmytro Shevchuk on 23.03.2018.
//  Copyright © 2018 PaksHome. All rights reserved.
//

#import "IVImageLoader.h"
#import "IVImagePropertyContainer.h"

@interface IVImageLoader()
@property (strong) NSMutableArray <IVImagePropertyContainer *>*imagePropertyContainers;
@end

@implementation IVImageLoader

#pragma mark - Inits
- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.imagePropertyContainers = [[self imagesFromAssets] mutableCopy];
    }
    
    return self;
}

#pragma mark - Private Methods
- (NSArray *)imagesFromAssets {
    NSArray *array = @[[[IVImagePropertyContainer alloc] initWithImageName:@"Photo_1"],
                       [[IVImagePropertyContainer alloc] initWithImageName:@"Photo_2"]];
    return array;
}

#pragma mark - Public Methods
- (NSUInteger)countOfImages {
    return self.imagePropertyContainers.count;
}

- (IVImagePropertyContainer *)imageContainerAtIndex:(NSInteger)index {
    return self.imagePropertyContainers[index];
}

- (void)addImageByURL:(NSURL *)url {
    IVImagePropertyContainer *imageContainer = [[IVImagePropertyContainer alloc] initWithImageURL:url];
    if (imageContainer.image) {
        [self.imagePropertyContainers addObject:imageContainer];
    }
}

@end
