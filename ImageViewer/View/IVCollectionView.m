//
//  IVCollectionView.m
//  ImageViewer
//
//  Created by Dmytro Shevchuk on 27.03.2018.
//  Copyright © 2018 PaksHome. All rights reserved.
//

#import "IVCollectionView.h"
#import "NSPasteboard+ImageExtention.h"

@implementation IVCollectionView
bool fileTypeIsOk = NO;

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    
    if (self) {
        [self registerForDraggedTypes:@[NSFilenamesPboardType]];
    }
    
    return self;
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    fileTypeIsOk = [sender.draggingPasteboard iv_isGeneralImageExtention];
    return NSDragOperationNone;
}

- (NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender {
    return fileTypeIsOk ? NSDragOperationCopy : NSDragOperationNone;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    NSURL *fileUrl = [NSURL URLFromPasteboard:sender.draggingPasteboard];
    [self.dragViewDelegate didDragFileWithURL:fileUrl];
    
    return YES;
}

@end
