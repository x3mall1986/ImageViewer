//
//  IVCollectionView.h
//  ImageViewer
//
//  Created by Dmytro Shevchuk on 27.03.2018.
//  Copyright © 2018 PaksHome. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol DragCollectionViewDelegate
- (void)didDragFileWithURL:(NSURL *)URL;
@end

@interface IVCollectionView : NSCollectionView

@property (weak) id<DragCollectionViewDelegate> dragViewDelegate;

@end
