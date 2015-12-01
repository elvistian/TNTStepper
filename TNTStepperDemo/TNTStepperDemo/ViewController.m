//
//  ViewController.m
//  TNTStepperDemo
//
//  Created by ltbl on 15/12/1.
//  Copyright (c) 2015年 ltbl. All rights reserved.
//

#import "ViewController.h"
#import "TNTStepper.h"

@interface ViewController ()<TNTStepperDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    TNTStepper *stepView = [[TNTStepper alloc] initWithFrame:CGRectMake(20, 100, 150, 40)];
    stepView.stepperDelegate = self;
    stepView.stepperValueMax = 10;
    stepView.stepperValueMin = 1;
    stepView.stepperValue = 1;
    [self.view addSubview:stepView];
}

- (void)stepChanged:(NSNumber *)number {
    NSLog(@"%@",number);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
