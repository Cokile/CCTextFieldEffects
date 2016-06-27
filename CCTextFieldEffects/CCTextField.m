//
//  CCTextField.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/25/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "CCTextField.h"

@implementation CCTextField

#pragma mark - Custom accessorys
- (void)setCursorColor:(UIColor *)cursorColor {
    _cursorColor = cursorColor;
    
    self.tintColor = cursorColor;
}

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.delegate = self;
    }
    
    return self;
}

#pragma mark - Public methods
- (void)updateViewsForBoundsChange:(CGRect)bounds {
    NSAssert(NO, @"%@ must be overridden", NSStringFromSelector(_cmd));
}

#pragma mark - Overridden methods
- (void)drawPlaceholderInRect:(CGRect)rect {
    // Don't draw any placeholders.
}

@end
