//
//  SaeTextField.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 7/1/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "SaeTextField.h"

@interface SaeTextField ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIView *borderView;

@end

@implementation SaeTextField

#pragma mark - Constants
static CGFloat const borderTickness = 2;
static CGPoint const textFieldInset = {0, 6};
static CGPoint const placeholderInset = {0, 6};

#pragma mark - Custom accessorys
- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    
    self.borderView.backgroundColor = borderColor;
    [self.imageView setTintColor:borderColor];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
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
        self.imageView = [[UIImageView alloc] init];
        self.borderView = [[UIView alloc] init];
        self.placeholderLabel = [[UILabel alloc] init];
        
        self.borderColor  = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        self.placeholderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.cursorColor = self.borderColor;
        self.textColor = self.cursorColor;
        
        self.image = [UIImage imageNamed:@"pencil.png"];
        
        self.placeholderFontScale = 0.8;
    }
    
    return self;
}

#pragma mark - Overridden methods
- (void)drawRect:(CGRect)rect {
    CGFloat length = self.placeholderLabel.font.lineHeight;
    
    self.borderView.frame = CGRectMake(CGRectGetWidth(rect), CGRectGetHeight(rect)-borderTickness, CGRectGetWidth(rect), borderTickness);
    [self addSubview:self.borderView];
    
    self.imageView.frame = CGRectMake(CGRectGetWidth(rect)-length, CGRectGetHeight(rect)-length-borderTickness, length, length);
    [self addSubview:self.imageView];
    
    self.placeholderLabel.frame = CGRectMake(placeholderInset.x, CGRectGetHeight(rect)-self.placeholderLabel.font.lineHeight-placeholderInset.y-borderTickness, CGRectGetWidth(rect)-length, self.placeholderLabel.font.lineHeight+placeholderInset.y);
    [self addSubview:self.placeholderLabel];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect newBounds = CGRectMake(0, self.placeholderLabel.font.lineHeight+placeholderInset.y, CGRectGetWidth(bounds), CGRectGetHeight(bounds)-self.placeholderLabel.font.lineHeight-placeholderInset.y-borderTickness);
    
    return CGRectInset(newBounds, textFieldInset.x, textFieldInset.y);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect newBounds = CGRectMake(0, self.placeholderLabel.font.lineHeight+placeholderInset.y, CGRectGetWidth(bounds), CGRectGetHeight(bounds)-self.placeholderLabel.font.lineHeight-placeholderInset.y-borderTickness);
    
    return CGRectInset(newBounds, textFieldInset.x, textFieldInset.y);
}

- (void)animateViewsForTextEntry {
    if (self.text.length == 0) {
        self.imageView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
        
        [UIView animateWithDuration:0.35 animations:^{
            self.placeholderLabel.layer.transform =  CATransform3DMakeTranslation(0, -CGRectGetHeight([self textRectForBounds:self.bounds])-placeholderInset.y, 0);
            
            self.borderView.frame = CGRectOffset(self.borderView.frame, -CGRectGetWidth(self.bounds), 0);
            self.imageView.frame = CGRectOffset(self.imageView.frame, -CGRectGetWidth(self.bounds), 0);
        } completion:^(BOOL finished) {
            if (self.didBeginEditingHandler != nil) {
                self.didBeginEditingHandler();
            }
        }];
    }
}

- (void)animateViewsForTextDisplay {
    if (self.text.length == 0) {
        [UIView animateWithDuration:0.35 animations:^{
            self.borderView.frame = CGRectOffset(self.borderView.frame, CGRectGetWidth(self.bounds), 0);
            
            CGFloat length = self.placeholderLabel.font.lineHeight;
            self.imageView.frame = CGRectMake(CGRectGetWidth(self.bounds)-length, CGRectGetHeight(self.bounds)-length, length, length);
            
            self.placeholderLabel.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.imageView.layer.transform = CATransform3DIdentity;
            } completion:^(BOOL finished) {
                if (self.didEndEditingHandler != nil) {
                    self.didEndEditingHandler();
                }
            }];
        }];
    }
}

#pragma mark - Private methods
- (UIFont *)placeholderFontFromFont:(UIFont *)font {
    UIFont *smallerFont = [UIFont fontWithName:font.fontName size:font.pointSize*self.placeholderFontScale];
    
    return smallerFont;
}

@end
