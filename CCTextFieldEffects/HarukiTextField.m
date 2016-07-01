//
//  HarukiTextField.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/28/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "HarukiTextField.h"

@interface HarukiTextField ()

@property (strong, nonatomic) CALayer *upperLayer;
@property (strong, nonatomic) CALayer *lowerLayer;
@property (nonatomic) CGFloat placeholderHeight;

@end

@implementation HarukiTextField

#pragma mark - Constants
static CGFloat const borderSize = 3;
static CGFloat const borderMoveDistance = 8;
static CGPoint const textFieldInsets = {8, 0};
static CGPoint const placeHolderInsets = {8, 0};

#pragma mark - Custom accessorys
- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    
    self.upperLayer.borderColor = borderColor.CGColor;
    self.lowerLayer.borderColor = borderColor.CGColor;
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

- (CGFloat)placeholderHeight {
    return placeHolderInsets.y + [self placeholderFontFromFont:self.font].lineHeight;
}

#pragma mark - Liftcycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.upperLayer = [[CALayer alloc] init];
        self.upperLayer.borderWidth = borderSize;
        
        self.lowerLayer = [[CALayer alloc] init];
        self.lowerLayer.borderWidth = borderSize;
        
        self.placeholderLabel = [[UILabel alloc] init];
        
        self.borderColor = [UIColor colorWithRed:0.4147 green:0.4745 blue:0.5373 alpha:1];
        self.placeholderColor = self.borderColor;
        self.cursorColor = [UIColor colorWithRed:0.6863 green:0.7098 blue:0.7333 alpha:1];
        self.textColor = self.cursorColor;
        
        self.placeholderFontScale = 0.75;
    }
    
    return self;
}

#pragma mark - Overridden methods
- (void)drawRect:(CGRect)rect {
    self.upperLayer.frame = CGRectMake(0, self.placeholderHeight+borderMoveDistance, CGRectGetWidth(self.bounds), borderSize);
    [self.layer addSublayer:self.upperLayer];
    
    self.lowerLayer.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-borderSize-borderMoveDistance, CGRectGetWidth(self.bounds), borderSize);
    [self.layer addSublayer:self.lowerLayer];
    
    self.placeholderLabel.frame = [self placeholderRectForBounds:self.bounds];
    [self addSubview:self.placeholderLabel];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    if ([self isFirstResponder] || self.text.length!=0) {
        return CGRectMake(placeHolderInsets.x, placeHolderInsets.y, bounds.size.width, self.placeholderHeight);
    } else {
        return [self textRectForBounds:bounds];
    }
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectOffset(bounds, textFieldInsets.x, textFieldInsets.y+self.placeholderHeight/2);
}

- (void)animateViewsForTextEntry {
    if (self.text.length == 0) {
        // Hide the cursor when the animating
        UIColor *originalCursorColor = self.cursorColor;
        self.cursorColor = [UIColor clearColor];
        
        [UIView animateWithDuration:0.35 animations:^{
            self.upperLayer.frame = CGRectMake(0, self.placeholderHeight*1.1, CGRectGetWidth(self.bounds), borderSize);
            self.lowerLayer.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-borderSize, CGRectGetWidth(self.bounds), borderSize);
            self.placeholderLabel.frame = [self placeholderRectForBounds:self.bounds];
        } completion:^(BOOL finished) {
            self.cursorColor = originalCursorColor;
            
            if (self.didBeginEditingHandler != nil) {
                self.didBeginEditingHandler();
            }
        }];
    }
}

- (void)animateViewsForTextDisplay {
    if (self.text.length == 0) {
        [UIView animateWithDuration:0.35 animations:^{
            self.upperLayer.frame = CGRectMake(0, self.placeholderHeight+borderMoveDistance, CGRectGetWidth(self.bounds), borderSize);
            self.lowerLayer.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-borderSize-borderMoveDistance, CGRectGetWidth(self.bounds), borderSize);
            self.placeholderLabel.frame = [self placeholderRectForBounds:self.bounds];
        } completion:^(BOOL finished) {
            if (self.didEndEditingHandler != nil) {
                self.didEndEditingHandler();
            }
        }];
    }
}

#pragma mark - Private methods
- (UIFont *)placeholderFontFromFont:(UIFont *)font {
    UIFont *smallerFont = [UIFont fontWithName:font.fontName size:font.pointSize*self.placeholderFontScale];
    
    return smallerFont;
}

@end
