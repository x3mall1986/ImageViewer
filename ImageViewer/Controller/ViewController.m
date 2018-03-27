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

@interface ViewController()<NSCollectionViewDataSource, NSCollectionViewDelegate, DragCollectionViewDelegate>
@property (weak) IBOutlet IVCollectionView *collectionView;

@property (strong) IVImageLoader *imageLoader;
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
- (NSDragOperation)collectionView:(NSCollectionView *)collectionView validateDrop:(id <NSDraggingInfo>)draggingInfo proposedIndexPath:(NSIndexPath * __nonnull * __nonnull)proposedDropIndexPath dropOperation:(NSCollectionViewDropOperation *)proposedDropOperation {
    
    NSLog(@"Validate drop: %@", draggingInfo);
    
    return NSDragOperationMove;
}

- (BOOL)collectionView:(NSCollectionView *)collectionView acceptDrop:(id <NSDraggingInfo>)draggingInfo indexPath:(NSIndexPath *)indexPath dropOperation:(NSCollectionViewDropOperation)dropOperation {
    
    NSLog(@"Accept drop: %@", draggingInfo);
    
    return YES;
}

#pragma mark - DragCollectionView Delegate
- (void)didDragFileWithURL:(NSURL *)URL {
    [self.imageLoader addImageByURL:URL];
    [self.collectionView reloadData];
}

@end
