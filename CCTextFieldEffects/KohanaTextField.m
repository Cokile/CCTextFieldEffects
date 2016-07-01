//
//  KohanaTextField.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 7/1/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "KohanaTextField.h"

@interface KohanaTextField ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation KohanaTextField

#pragma mark - Constants
static CGPoint const placeholderInsets = {0, 0};
static CGPoint const textFieldInsets = {6, 0};

#pragma mark - Custom accessorys
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
    [self.imageView setTintColor:placeholderColor];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)setPlaceholderFontScale:(CGFloat)placeholderFontScale {
    _placeholderFontScale = placeholderFontScale;
    
    self.placeholderLabel.font = [self placeholderFontFromFont:self.font];
}

- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    
    self.placeholderLabel.text = placeholder;
}

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.placeholderLabel = [[UILabel alloc] init];
        self.imageView = [[UIImageView alloc] init];

        self.placeholderColor = [UIColor colorWithRed:0.8235 green:0.8235 blue:0.8235 alpha:1];
        self.cursorColor = [UIColor colorWithRed:0.4157 green:0.4745 blue:0.5373 alpha:1];
        self.textColor = self.cursorColor;
        self.backgroundColor = [UIColor whiteColor];
        
        self.placeholderFontScale = 0.8;
    }
    
    return self;
}

#pragma mark - Overridden methods
- (void)drawRect:(CGRect)rect {
    CGFloat length = CGRectGetHeight(rect);
    
    self.imageView.frame = CGRectInset(CGRectMake(-length, 0, length, length), length*0.25, length*0.25);
    self.imageView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    [self addSubview:self.imageView];
    
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(rect), length);;
    self.placeholderLabel.frame = CGRectInset(frame, length*0.3, placeholderInsets.y);
    [self addSubview:self.placeholderLabel];
}


- (CGRect)textRectForBounds:(CGRect)bounds {
    CGFloat length = CGRectGetHeight(self.bounds);
    
    CGRect rect = CGRectOffset(bounds, length+textFieldInsets.x, 0);
    return CGRectMake(rect.origin.x, rect.origin.y, CGRectGetWidth(rect)-2*textFieldInsets.x-length, CGRectGetHeight(rect));
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGFloat length = CGRectGetHeight(self.bounds);
    
    CGRect rect = CGRectOffset(bounds, length+textFieldInsets.x, 0);
    return CGRectMake(rect.origin.x, rect.origin.y, CGRectGetWidth(rect)-2*textFieldInsets.x-length, CGRectGetHeight(rect));
}

- (void)animateViewsForTextEntry {
    if (self.text.length == 0) {
        [UIView animateWithDuration:0.25 animations:^{
            CGFloat length = CGRectGetHeight(self.bounds);
            
            self.imageView.frame = CGRectOffset(self.imageView.frame, length, 0);
            self.placeholderLabel.frame = CGRectOffset(self.placeholderLabel.frame, length, 0);
            self.placeholderLabel.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)animateViewsForTextDisplay {
    if (self.text.length == 0) {
        [UIView animateWithDuration:0.24 animations:^{
            CGFloat length = CGRectGetHeight(self.bounds);
            
            self.imageView.frame = CGRectOffset(self.imageView.frame, -length, 0);
            self.placeholderLabel.frame = CGRectOffset(self.placeholderLabel.frame, -length, 0);
            self.placeholderLabel.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark - Private methods
- (UIFont *)placeholderFontFromFont:(UIFont *)font {
    UIFont *smallerFont = [UIFont fontWithName:font.fontName size:font.pointSize*self.placeholderFontScale];
    
    return smallerFont;
}

@end
