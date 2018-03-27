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

@interface ViewController()<NSCollectionViewDataSource, NSCollectionViewDelegate, DragCollectionViewDelegate>
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

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
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
    collectionViewItem.imageView.image = [self.imageLoader imageAtIndex:indexPath.item];
    
    return collectionViewItem;
}

#pragma mark - CollectionViewController Delegate
- (void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths {
    NSIndexPath *indexPath = indexPaths.allObjects.firstObject;
    [self.fullSizeImageViewController showImageFromLoader:self.imageLoader byIndex:indexPath.item];
    self.containerView.hidden = NO;
}

#pragma mark - DragCollectionView Delegate
- (void)didDragFileWithURL:(NSURL *)URL {
    [self.imageLoader addImageByURL:URL];
    [self.collectionView reloadData];
}

#pragma mark - Segue
- (void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"FullImageViewSegue"]) {
        self.fullSizeImageViewController = segue.destinationController;
    }
}

@end
