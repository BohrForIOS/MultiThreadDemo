//
//  ViewController.m
//  NSOperation与NSOperationQueue初步使用
//
//  Created by 严锦龙 on 17/4/11.
//  Copyright © 2017年 moonbasa. All rights reserved.
//

#import "ViewController.h"
#import "CustomOperation.h"

@interface ViewController ()
@property (nonatomic, strong) NSOperationQueue *queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

#pragma mark -- 
/* *
   NSOperationQueue 和GCD 共同点
 
    1. 有队列，有任务，任务加入到队列中
    2. 不需要手动管理线程的创建和启动，系统自动判断是否需要开启线程
    // 创建线程
     NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@"jack"];
     // 启动线程
     [thread start];
 
    NSOperationQueue 和GCD 区别
    
    1.NSOperationQueue可以挂起和继续执行，而GCD只能一次执行
 */


/**
 ## GCD的队列类型
    - 并发队列
        - 自己创建的
        - 全局
    - 串行队列
        - 主队列
        - 自己创建的
 
 ## NSOperationQueue的队列类型
    - 主队列
        - [NSOperationQueue mainQueue]
        - 凡是添加到主队列中的任务（NSOperation），都会放到主线程中执行
    - 非主队列（其他队列）
        - [[NSOperationQueue alloc] init]
        - 同时包含了：串行、并发功能
        - 添加到这种队列中的任务（NSOperation），就会自动放到子线程中执行
 
 
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    // 队列挂起和继续执行
//    if (self.queue.isSuspended) {
//        // 恢复队列，继续执行
//        self.queue.suspended = NO;
//    } else {
//        // 暂停（挂起）队列，暂停执行
//        self.queue.suspended = YES;
//    }
//    
//    // 队列取消所有操作
//    //[self.queue cancelAllOperations];
    
    [self queueAddOperation];
}


- (void)queueAddOperationWhileCancelQueue {
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 设置最大并发操作数
        queue.maxConcurrentOperationCount = 1; // 就变成了串行队列
    
        // 添加操作
        [queue addOperationWithBlock:^{
            NSLog(@"download1 --- %@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:1.0];
            
            for (NSInteger i = 0; i<5000; i++) {
                NSLog(@"download1 -%zd-- %@", i, [NSThread currentThread]);
            }
        }];
        [queue addOperationWithBlock:^{
            NSLog(@"download2 --- %@", [NSThread currentThread]);
            
            for (NSInteger i = 0; i<1000; i++) {
                NSLog(@"download2 --- %@", [NSThread currentThread]);
            }
        }];
        [queue addOperationWithBlock:^{
            NSLog(@"download3 --- %@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:1.0];
            
           for (NSInteger i = 0; i<1000; i++) {
                NSLog(@"download3 --- %@", [NSThread currentThread]);
            }
        }];
 
    self.queue = queue;
}

/**
    队列添加操作
 */
- (void)queueAddOperation {
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.创建操作（操作把任务封装起来）
    // 设置最大并发操作数
    //    queue.maxConcurrentOperationCount = 2;
    //queue.maxConcurrentOperationCount = 1; // 就变成了串行队列
    
    // 2.1 创建NSInvocationOperation
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download1) object:nil];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download2) object:nil];
    
    // 2.2 创建NSBlockOperation
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download3 --- %@", [NSThread currentThread]);
    }];
    
    [op3 addExecutionBlock:^{
        NSLog(@"download4 --- %@", [NSThread currentThread]);
    }];
    [op3 addExecutionBlock:^{
        NSLog(@"download5 --- %@", [NSThread currentThread]);
    }];
    
    
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download6 --- %@", [NSThread currentThread]);
    }];
    
    // 2.3 创建CustomOperation
    CustomOperation *op5 = [[CustomOperation alloc] init];
    
    // 3. 添加操作到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    [queue addOperation:op5];
}

- (void)download1 {
    NSLog(@"download1 --- %@", [NSThread currentThread]);
}

- (void)download2 {
    NSLog(@"download2 --- %@", [NSThread currentThread]);
}

@end
