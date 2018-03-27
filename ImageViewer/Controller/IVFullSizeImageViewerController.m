//
//  IVFullSizeImageViewerController.m
//  ImageViewer
//
//  Created by Dmytro Shevchuk on 27.03.2018.
//  Copyright © 2018 PaksHome. All rights reserved.
//

#import "IVFullSizeImageViewerController.h"
#import "IVImageLoader.h"
#import "NSImage+GuasianBlur.h"

@interface IVFullSizeImageViewerController ()

@property (nonatomic, weak) IBOutlet NSImageView *imageView;

@property (nonatomic, strong) IVImageLoader *imageLoader;
@property (nonatomic, assign) NSInteger currentIndex;

- (IBAction)upButtonClicked:(NSButton *)sender;
- (IBAction)downButtonClicked:(NSButton *)sender;
- (IBAction)blurButtonClicked:(NSButton *)sender;
- (IBAction)closeView:(NSButton *)sender;

@end

@implementation IVFullSizeImageViewerController

#pragma mark - Initializers
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self becomeFirstResponder];
}

#pragma mark - Setters/Getters
- (void)setCurrentIndex:(NSInteger)currentIndex {
    if (currentIndex >= 0 && currentIndex < self.imageLoader.countOfImages) {
        _currentIndex = currentIndex;
    }
}

#pragma mark - Additionals Methods
- (void)showImageFromLoader:(IVImageLoader *)imageLoader byIndex:(NSInteger)index {
    self.imageLoader = imageLoader;
    self.currentIndex = index;
    
    [self showImageByIndex:index];
}

- (void)showImageByIndex:(NSInteger)index {
    if (index >= 0 && index < self.imageLoader.countOfImages) {
        self.imageView.image = [self.imageLoader imageAtIndex:index];
    }
}

#pragma mark - Actions
- (IBAction)upButtonClicked:(NSButton *)sender {
    self.currentIndex++;
    [self showImageByIndex:self.currentIndex];
}

- (IBAction)downButtonClicked:(NSButton *)sender {
    self.currentIndex--;
    [self showImageByIndex:self.currentIndex];
}

- (IBAction)blurButtonClicked:(NSButton *)sender {
    self.imageView.image = [self.imageView.image iv_guasianBlur];
}

- (IBAction)closeView:(NSButton *)sender {
    [self.delegate didESCPressed];
}

@end
