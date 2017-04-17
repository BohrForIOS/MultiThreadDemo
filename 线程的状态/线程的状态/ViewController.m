//
//  ViewController.m
//  线程的状态
//
//  Created by 王二 on 17/4/17.
//  Copyright © 2017年 mbs008. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/**
 *
 */
@property (nonatomic, strong) NSThread *thread;
@end

@implementation ViewController

- (IBAction)btnTouch:(id)sender {
    // 已经结束的线程，再次开启会崩掉
    [self.thread start];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.创建线程--->新建状态
    self.thread = [[NSThread alloc]initWithTarget:self selector:@selector(therad) object:nil];
    // 设置线程名称
    self.thread.name = @"线程A";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 2.开启线程---->就绪和运行状态
    [self.thread start];
}

-(void)therad {
    NSThread *current=[NSThread currentThread];
    NSLog(@"therad---打印线程---%@",self.thread.name);
    NSLog(@"therad---线程开始---%@",current.name);
    //3.设置线程阻塞1，阻塞2秒 --->阻塞状态
    NSLog(@"接下来，线程阻塞2秒");
    [NSThread sleepForTimeInterval:2.0];
    
    //第二种设置线程阻塞2，以当前时间为基准阻塞4秒
    NSLog(@"接下来，线程阻塞4秒");
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:4.0];
    [NSThread sleepUntilDate:date];
    for (int i=0; i<10; i++) {
        NSLog(@"线程--%d--%@",i,current.name);
        // 结束线程--- >死亡状态
//        [NSThread exit];
        
    }
    // 4. 任务结束 --- >死亡状态
    NSLog(@"test---线程结束---%@",current.name);
}

@end
