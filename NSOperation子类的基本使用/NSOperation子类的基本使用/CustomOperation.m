//
//  CustomOperation.m
//  NSOperation子类的基本使用
//
//  Created by 王二 on 17/4/18.
//  Copyright © 2017年 moonbasa. All rights reserved.
//

#import "CustomOperation.h"

@implementation CustomOperation

/**
 重新main方法，在这里执行任务
 */
- (void)main {
    for (NSInteger i = 0; i<10; i++) {
        NSLog(@"download1 -%zd-- %@", i, [NSThread currentThread]);
    }
    if (self.isCancelled) return;
    
    for (NSInteger i = 0; i<10; i++) {
        NSLog(@"download2 -%zd-- %@", i, [NSThread currentThread]);
    }
    if (self.isCancelled) return;
    
    for (NSInteger i = 0; i<10; i++) {
        NSLog(@"download3 -%zd-- %@", i, [NSThread currentThread]);
    }
    if (self.isCancelled) return;
}

@end
