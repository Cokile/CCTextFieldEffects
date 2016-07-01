//
//  KuroTextField.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/29/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "KuroTextField.h"

@interface KuroTextField ()

@property (strong ,nonatomic) CAShapeLayer *leftLayer;
@property (strong, nonatomic) CAShapeLayer *rightLayer;
@property (nonatomic) CGFloat placeholderHeight;

@end


/**
    When I implement the original effect for Kuro with two CAShpaLayer, there is a issue for text alignment (thoungh I do not think it is the problem of CAShapeLayer), So I made some change to Kuro.
    The current effect for Kuro can be implemented simply by a CALayer. There is not need to use two CAShapeLayer. But I am somehow lazy to modify the code.
    // TODO: Use single CALayer.
 */
@implementation KuroTextField

# pragma mark - Constants
static CGFloat const borderThickness = 3;
static CGFloat const borderMoveDistance = 12;
static CGPoint const placeholderInset = {10,2};
static CGPoint const textFieldInset = {6,0};

# pragma mark - Custom accessorys
- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    
    self.leftLayer.strokeColor = borderColor.CGColor;
    self.rightLayer.strokeColor = borderColor.CGColor;
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
    return self.placeholderLabel.font.lineHeight;
}

# pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        self.leftLayer = [[CAShapeLayer alloc] init];
        self.leftLayer.fillColor = [UIColor clearColor].CGColor;
        self.leftLayer.borderColor = self.leftLayer.fillColor;
        self.leftLayer.lineWidth = borderThickness;
        
        self.rightLayer = [[CAShapeLayer alloc] init];
        self.rightLayer.fillColor = [UIColor clearColor].CGColor;
        self.rightLayer.borderColor = self.rightLayer.fillColor;
        self.rightLayer.lineWidth = borderThickness;
        
        self.placeholderLabel = [[UILabel alloc] init];        
        
        self.borderColor = [UIColor colorWithRed:0.4549 green:0.4745 blue:0.5059 alpha:1];
        self.placeholderColor = [UIColor colorWithRed:0.8745 green:0.3961 blue:0.5373 alpha:1];
        self.cursorColor = [UIColor colorWithRed:0.5686 green:0.5882 blue:0.6314 alpha:1];
        self.textColor = self.cursorColor;
        
        self.placeholderFontScale = 0.85;
    }
    
    return self;
}

# pragma mark - Overridden methods
- (void)drawRect:(CGRect)rect {
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    [leftPath moveToPoint:CGPointMake(CGRectGetWidth(rect)/2+borderMoveDistance*2,borderThickness/2)];
    [leftPath addLineToPoint:CGPointMake(borderMoveDistance+borderThickness,borderThickness/2)];
    [leftPath addLineToPoint:CGPointMake(borderMoveDistance+borderThickness,CGRectGetHeight(rect)-borderThickness-placeholderInset.y-self.placeholderHeight)];
    [leftPath addLineToPoint:CGPointMake(CGRectGetWidth(rect)/2+2*borderMoveDistance,CGRectGetHeight(rect)-borderThickness-placeholderInset.y-self.placeholderHeight)];
    self.leftLayer.path = leftPath.CGPath;
    [self.layer addSublayer:self.leftLayer];
    
    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    [rightPath moveToPoint:CGPointMake(CGRectGetWidth(rect)/2,borderThickness/2)];
    [rightPath addLineToPoint:CGPointMake(CGRectGetWidth(rect)-borderMoveDistance-borderThickness,borderThickness/2)];
    [rightPath addLineToPoint:CGPointMake(CGRectGetWidth(rect)-borderMoveDistance-borderThickness,CGRectGetHeight(rect)-borderThickness-placeholderInset.y-self.placeholderHeight)];
    [rightPath addLineToPoint:CGPointMake(CGRectGetWidth(rect)/2,CGRectGetHeight(rect)-borderThickness-placeholderInset.y-self.placeholderHeight)];
    self.rightLayer.path = rightPath.CGPath;
    [self.layer addSublayer:self.rightLayer];
    
    self.placeholderLabel.frame = CGRectMake(placeholderInset.x+borderMoveDistance, (CGRectGetHeight([self textRectForBounds:rect])-self.placeholderHeight)/2+2*borderThickness, CGRectGetWidth(rect), self.placeholderHeight);
    [self.placeholderLabel sizeToFit];
    [self addSubview:self.placeholderLabel];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect newBounds = CGRectMake(0, 0, CGRectGetWidth(bounds), CGRectGetHeight(bounds)-borderThickness-placeholderInset.y-self.placeholderHeight);
    
    return  CGRectInset(newBounds, 1.5*borderThickness+textFieldInset.x, 1.5*borderThickness);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect newBounds = CGRectMake(0, 0, CGRectGetWidth(bounds), CGRectGetHeight(bounds)-borderThickness-placeholderInset.y-self.placeholderHeight);
    
    return  CGRectInset(newBounds, 1.5*borderThickness+textFieldInset.x, 1.5*borderThickness);
}

- (void)animateViewsForTextEntry {
    if (self.text.length == 0) {
        // Hide cursor when animating.
        UIColor *originalCursorColor = self.cursorColor;
        self.cursorColor = [UIColor clearColor];
        
        [UIView transitionWithView:self.placeholderLabel duration:0.35 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.placeholderLabel.transform = CGAffineTransformMakeScale(0.001, 0.001);
            self.leftLayer.frame = CGRectOffset(self.leftLayer.frame, -borderMoveDistance, 0);
            self.rightLayer.frame = CGRectOffset(self.rightLayer.frame, borderMoveDistance, 0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                self.placeholderLabel.frame = CGRectOffset(self.placeholderLabel.frame, -borderMoveDistance, CGRectGetHeight(self.bounds)*0.5-0.75*borderThickness-0.5*placeholderInset.y);
                self.placeholderLabel.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                self.cursorColor = originalCursorColor;
                
                if (self.didBeginEditingHandler != nil) {
                    self.didBeginEditingHandler();
                }
            }];
        }];
    }
}

- (void)animateViewsForTextDisplay {
    if (self.text.length == 0) {
        [UIView transitionWithView:self.placeholderLabel duration:0.35 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.placeholderLabel.transform = CGAffineTransformMakeScale(0.001, 0.001);
            self.leftLayer.frame = CGRectOffset(self.leftLayer.frame, borderMoveDistance, 0);
            self.rightLayer.frame = CGRectOffset(self.rightLayer.frame, -borderMoveDistance, 0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.placeholderLabel.frame = CGRectOffset(self.placeholderLabel.frame, borderMoveDistance, -CGRectGetHeight(self.bounds)*0.5+0.75*borderThickness+0.5*placeholderInset.y);
                self.placeholderLabel.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (self.didEndEditingHandler != nil) {
                    self.didEndEditingHandler();
                }
            }];
        }];
    }
}

# pragma mark - Private methods
- (UIFont *)placeholderFontFromFont:(UIFont *)font {
    UIFont *smallerFont = [UIFont fontWithName:self.font.fontName size:self.font.pointSize*self.placeholderFontScale];
    
    return smallerFont;
}

@end
