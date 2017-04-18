//
//  ViewController.m
//  NSOperation子类的基本使用
//
//  Created by 严锦龙 on 17/4/13.
//  Copyright © 2017年 moonbasa. All rights reserved.
//

#import "ViewController.h"
#import "CustomOperation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self customOperation];
}

/**
 NSBlockOperation的基本使用
 */
- (void)blockOperation {
    // 1.创建操作
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        // 在主线程
        NSLog(@"下载1------%@", [NSThread currentThread]);
    }];
    
    // 2.添加额外的任务(在子线程执行)
    [op addExecutionBlock:^{
        NSLog(@"下载2------%@", [NSThread currentThread]);
    }];
    
    [op addExecutionBlock:^{
        NSLog(@"下载3------%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"下载4------%@", [NSThread currentThread]);
    }];
    
    // 3.启动操作
    [op start];
}

/**
 NSInvocationOperation的使用
 */
- (void)invocationOperation {
    // 1.创建操作
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    // 2.启动操作
    [op start];
}

- (void)run {
    NSLog(@"------%@", [NSThread currentThread]);
}

/**
 自定义操作的使用
 */
- (void)customOperation {
    CustomOperation *op = [CustomOperation new];
    [op start];
}

@end
