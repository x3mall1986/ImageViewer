//
//  NSPasteboard+ImageExtention.m
//  ImageViewer
//
//  Created by Dmytro Shevchuk on 27.03.2018.
//  Copyright © 2018 PaksHome. All rights reserved.
//

#import "NSPasteboard+ImageExtention.h"

@implementation NSPasteboard (ImageExtention)

- (BOOL)iv_isGeneralImageExtention {
    NSDictionary *filteredObjects = @{NSPasteboardURLReadingContentsConformToTypesKey: [NSImage imageTypes]};
    return [self canReadObjectForClasses:@[[NSURL self]] options:filteredObjects];
}

@end
