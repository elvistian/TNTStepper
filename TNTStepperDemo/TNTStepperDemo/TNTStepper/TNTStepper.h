//
//  TNTStepper.h
//  PlusOrMinusView
//
//  Created by ltbl on 15/12/1.
//  Copyright (c) 2015年 ltbl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TNTStepperDelegate <NSObject>

- (void)stepChanged:(NSNumber *)number;

@end

@interface TNTStepper : UITextField

@property(nonatomic,assign)id<TNTStepperDelegate> stepperDelegate;
@property(nonatomic,assign)CGFloat stepperValueMax;//最大值
@property(nonatomic,assign)CGFloat stepperValueMin;//最小值 默认1
@property(nonatomic,assign)CGFloat stepperValue;//最小值 默认1

/**
 *  @param frame        PlusOrMinusView的frame
 *  @param viewWidth    左右加减号view的宽度 最大限制100
 *  @param midViewWidth 中间显示文字view的宽度 无最大限制
 *  @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame leftAndRightViewWidth:(CGFloat)viewWidth midViewWidth:(CGFloat)midViewWidth;

@end
