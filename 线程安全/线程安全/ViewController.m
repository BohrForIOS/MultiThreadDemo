//
//  ViewController.m
//  线程安全
//
//  Created by 王二 on 17/4/14.
//  Copyright © 2017年 mbs008. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/** 售票员01 */
@property (nonatomic, strong) NSThread *thread01;
/** 售票员02 */
@property (nonatomic, strong) NSThread *thread02;
/** 售票员03 */
@property (nonatomic, strong) NSThread *thread03;

/** 票的总数 */
@property (nonatomic, assign) NSInteger ticketCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ticketCount = 100;
    
    self.thread01 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread01.name = @"售票员01";
    
    self.thread02 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread02.name = @"售票员02";
    
    self.thread03 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread03.name = @"售票员03";
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.thread01 start];
    [self.thread02 start];
    [self.thread03 start];
}

- (void)saleTicket {
    while (1) {
        @synchronized(self) {
            // 先取出总数
            NSInteger count = self.ticketCount;
            if (count > 0) {
                self.ticketCount = count - 1;
                NSLog(@"%@卖了一张票，还剩下%zd张", [NSThread currentThread].name, self.ticketCount);
            } else {
                NSLog(@"票已经卖完了");
                break;
            }
        }
    }
}



@end
