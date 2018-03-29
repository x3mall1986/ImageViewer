//
//  ViewController.m
//  ImageViewer
//
//  Created by Dmytro Shevchuk on 23.03.2018.
//  Copyright © 2018 PaksHome. All rights reserved.
//

#import "ViewController.h"
#import "IVCollectionViewItem.h"
#import "IVImageLoader.h"
#import "IVCollectionView.h"
#import "IVFullSizeImageViewerController.h"
#import "NSImageThumbnailExtensions.h"
#import "IVImagePropertyContainer.h"

@interface ViewController()<NSCollectionViewDataSource, NSCollectionViewDelegate, DragCollectionViewDelegate, IVFullSizeImageViewerControllerDelegate>
@property (nonatomic, weak) IBOutlet IVCollectionView *collectionView;
@property (nonatomic, weak) IBOutlet NSView *containerView;

@property (nonatomic, strong) IVFullSizeImageViewerController *fullSizeImageViewController;
@property (nonatomic, strong) IVImageLoader *imageLoader;
@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if (self) {
        self.imageLoader = [[IVImageLoader alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.collectionView.dragViewDelegate = self;
    
    [self.containerView setWantsLayer:YES];
    [self.containerView.layer setBackgroundColor:[[NSColor whiteColor] CGColor]];
}

#pragma mark - CollectionViewController Data Source
- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageLoader.countOfImages;
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath {
    IVCollectionViewItem *collectionViewItem = [collectionView makeItemWithIdentifier:@"IVCollectionViewItem" forIndexPath:indexPath];
    IVImagePropertyContainer *imageContainer = [self.imageLoader imageContainerAtIndex:indexPath.item];
    [imageContainer thumbnailImage:^(NSImage *thumbnailImage) {
        collectionViewItem.imageView.image = thumbnailImage;
    }];
    
    return collectionViewItem;
}

#pragma mark - CollectionViewController Delegate
- (void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths {
    [collectionView deselectItemsAtIndexPaths:indexPaths];
    
    NSIndexPath *indexPath = indexPaths.allObjects.firstObject;
    [self.fullSizeImageViewController showImageFromLoader:self.imageLoader byIndex:indexPath.item];
    self.containerView.hidden = NO;
}

#pragma mark - DragCollectionView Delegate
- (void)didDragFileWithURL:(NSURL *)URL {
    [self.collectionView performBatchUpdates:^{
        NSInteger oldSize = self.imageLoader.countOfImages;
        [self.imageLoader addImageByURL:URL];
        NSMutableSet *setWithIndexPaths = [NSMutableSet set];
        for (NSInteger i = oldSize; i < self.imageLoader.countOfImages; i++) {
            [setWithIndexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
        }
        [self.collectionView insertItemsAtIndexPaths:setWithIndexPaths];
    } completionHandler:nil];
}

#pragma mark - FullSizeImageViewerController Delegate
- (void)didESCPressed {
    self.containerView.hidden = YES;
}

#pragma mark - Segue
- (void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"FullImageViewSegue"]) {
        self.fullSizeImageViewController = segue.destinationController;
        self.fullSizeImageViewController.delegate = self;
    }
}

@end
