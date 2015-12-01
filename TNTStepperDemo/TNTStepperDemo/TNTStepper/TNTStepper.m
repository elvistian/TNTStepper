//
//  TNTStepper.m
//  PlusOrMinusView
//
//  Created by ltbl on 15/12/1.
//  Copyright (c) 2015年 ltbl. All rights reserved.
//

#import "TNTStepper.h"

@interface TNTStepper ()<UITextFieldDelegate>

@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UIButton *rightButton;
@property(nonatomic,strong)UIImageView *midImageView;

@property(nonatomic,assign)CGFloat buttonWidth;
@property(nonatomic,assign)CGFloat midViewWidth;

@end

@implementation TNTStepper

static const CGFloat KButtonWidthMax = 100;
static const CGFloat KButtonWidthDefault = 40.0;
static const CGFloat KMidViewWidthDefault = 60.0;

- (instancetype)initWithFrame:(CGRect)frame leftAndRightViewWidth:(CGFloat)viewWidth midViewWidth:(CGFloat)midViewWidth {
    self = [super initWithFrame:frame];
    if (self) {
        if (viewWidth <= 0) {
            self.buttonWidth = KButtonWidthDefault;
        }else if (viewWidth >= KButtonWidthMax) {
            self.buttonWidth = KButtonWidthMax;
        }else {
            self.buttonWidth = viewWidth;
        }
        
        if (midViewWidth <= 0) {
            self.midViewWidth = KMidViewWidthDefault;
        }else {
            self.midViewWidth = midViewWidth;
        }
        
        //UITextField的width = leftView的width + 中间显示文本的width + rightView的width
        CGRect newFrame = frame;
        newFrame.size.width = 2*self.buttonWidth + self.midViewWidth;
        self.frame = newFrame;
        
        [self _initViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame leftAndRightViewWidth:KButtonWidthDefault midViewWidth:KMidViewWidthDefault];
}

- (void)_initViews {
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftButton setFrame:CGRectMake(0, 0, self.buttonWidth, CGRectGetHeight(self.frame))];
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftButton setTitle:@"-" forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.leftButton.tag = 11;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = self.leftButton;
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton setFrame:CGRectMake(0, 0, self.buttonWidth, CGRectGetHeight(self.frame))];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightButton setTitle:@"+" forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton.tag = 22;
    self.rightViewMode = UITextFieldViewModeAlways;
    self.rightView = self.rightButton;
    
    self.midImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.midImageView.contentMode = UIViewContentModeScaleToFill;
    self.midImageView.image = [UIImage imageNamed:@"mid.png"];
    //    self.midImageView.userInteractionEnabled = YES;
    [self addSubview:self.midImageView];
    
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateHighlighted];
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateNormal];
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateHighlighted];
    
    self.keyboardType = UIKeyboardTypeNumberPad;
    self.delegate = self;
    
    self.textAlignment = NSTextAlignmentCenter;
}

- (void)_buttonAction:(UIButton *)sender {
    if (sender.tag == 11) {
        if (self.stepperValue == self.stepperValueMin) {
            return;
        }
        self.stepperValue--;
    }else if (sender.tag == 22) {
        if (self.stepperValue == self.stepperValueMax) {
            return;
        }
        self.stepperValue++;
    }
    
    self.text = [NSString stringWithFormat:@"%@",@(self.stepperValue)];
    [self callBackDelegate];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self.leftButton.titleLabel setFont:font];
    [self.rightButton.titleLabel setFont:font];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    self.text = [NSString stringWithFormat:@"%@",@(self.stepperValue)];
}

- (void)callBackDelegate {
    if (self.stepperDelegate && [self.stepperDelegate respondsToSelector:@selector(stepChanged:)]) {
        [self.stepperDelegate stepChanged:@(self.stepperValue)];
    }
}

- (BOOL)isValidTextFieldValue:(NSString *)valueString{
    if ([valueString length] == 0) {
        return YES;
    }
    double valueDouble = [valueString doubleValue];
    if (valueDouble < self.stepperValueMin || valueDouble > self.stepperValueMax) {
        return NO;
    }
    return YES;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self callBackDelegate];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *text = textField.text;
    NSString *replacesString = [text stringByReplacingCharactersInRange:range withString:string];
    BOOL validInput = [self isValidTextFieldValue:replacesString];
    if (!validInput) {
        return NO;
    }
    return YES;
}

@end
