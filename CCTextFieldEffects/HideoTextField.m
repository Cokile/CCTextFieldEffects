//
//  HideoTextField.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/27/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "HideoTextField.h"

@interface HideoTextField ()

@property (strong, nonatomic) UIView *imageContainerView;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation HideoTextField

#pragma mark - Constants
static CGPoint const textFieldInsets = {6 ,0};

#pragma mark - Custom accessorys
- (void)setImageContainerColor:(UIColor *)imageContainerColor {
    _imageContainerColor = imageContainerColor;
    
    self.imageContainerView.backgroundColor = imageContainerColor;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = image;
}

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.imageContainerView = [[UIView alloc] init];
        self.imageView = [[UIImageView alloc] init];
        
        self.imageContainerColor = [UIColor colorWithRed:0.5373 green:0.6157 blue:0.8549 alpha:1.0];
        self.imageView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor whiteColor];
        self.cursorColor = [UIColor colorWithRed:0.6667 green:0.6667 blue:0.6667 alpha:1.0];
        self.textColor = self.cursorColor;
        
        self.imageScale = 0.7;
    }
    
    return self;
}

#pragma mark - Overridden methods
- (void)drawRect:(CGRect)rect {
    self.imageContainerView.frame = CGRectMake(0, 0, CGRectGetHeight(rect), CGRectGetHeight(rect));
    [self addSubview:self.imageContainerView];
    
    self.imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.imageContainerView.frame)/3, CGRectGetHeight(self.imageContainerView.frame)/3);
    self.imageView.center = self.imageContainerView.center;
    [self.imageContainerView addSubview:self.imageView];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect frame = CGRectMake(CGRectGetWidth(self.imageContainerView.frame), 0, CGRectGetWidth(bounds)-CGRectGetWidth(self.imageContainerView.frame), CGRectGetHeight(bounds));
    
    return CGRectInset(frame, textFieldInsets.x, textFieldInsets.y);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect frame = CGRectMake(CGRectGetWidth(self.imageContainerView.frame), 0, CGRectGetWidth(bounds)-CGRectGetWidth(self.imageContainerView.frame), CGRectGetHeight(bounds));
    
    return CGRectInset(frame, textFieldInsets.x, textFieldInsets.y);
}

- (void)animateViewsForTextEntry {
    if ([self isFirstResponder] && self.text.length == 0) {
        // Prevent cursor display in front of the container view when animating.
        [self bringSubviewToFront:self.imageContainerView];
        
        [UIView animateWithDuration:0.27 animations:^{
            self.imageContainerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.imageContainerView.frame)*0.67, CGRectGetHeight(self.imageContainerView.frame));
            self.imageView.transform = CGAffineTransformMakeScale(self.imageScale, self.imageScale);
            self.imageView.center = self.imageContainerView.center;
        } completion:^(BOOL finished) {
            if (self.didBeginEditingHandler != nil) {
                self.didBeginEditingHandler();
            }
        }];
    }
}

- (void)animateViewsForTextDisplay {
    if (self.text.length == 0) {
        [UIView animateWithDuration:0.27 animations:^{
            self.imageContainerView.frame = CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.imageContainerView.frame));
            self.imageView.transform = CGAffineTransformIdentity;
            self.imageView.center = self.imageContainerView.center;
        } completion:^(BOOL finished) {
            if (self.didEndEditingHandler != nil) {
                self.didEndEditingHandler();
            }
        }];
    }
}

#pragma mark - Private methods

@end
