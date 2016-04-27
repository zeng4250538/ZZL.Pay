//
//  ViewController.m
//  PayUnitKit
//
//  Created by ZZLClick on 16/4/25.
//  Copyright © 2016年 Click. All rights reserved.
//

#import "ViewController.h"

#import "Pay.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Pay *pay = [Pay new];
    [pay alipayOrderId:@"12312313123" withProducatName:@"德玛西亚" withProducatDescription:@"人在塔在" withPrice:100.00];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
