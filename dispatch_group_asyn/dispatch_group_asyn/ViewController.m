//
//  ViewController.m
//  dispatch_group_asyn
//
//  Created by 王二 on 17/4/17.
//  Copyright © 2017年 mbs008. All rights reserved.
//

#import "ViewController.h"

//宏定义全局并发队列
#define global_quque    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//宏定义主队列
#define main_queue       dispatch_get_main_queue()

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (copy, nonatomic) NSString *imageString1;
@property (copy, nonatomic) NSString *imageString2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageString1 = @"http://d.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=2b9a12172df5e0fefa1581533d095fcd/cefc1e178a82b9019115de3d738da9773912ef00.jpg";
    self.imageString2 = @"http://h.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=f47fd63ca41ea8d39e2f7c56f6635b2b/1e30e924b899a9018b8d3ab11f950a7b0308f5f9.jpg";
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self nonGroup];
    [self group];
}

/**
 没有使用group的方法
 */
- (void)nonGroup {
    NSDate *startDate = [NSDate date];
    NSTimeInterval startTime = startDate.timeIntervalSince1970;
    
    dispatch_async(global_quque, ^{
        //下载图片1
        UIImage *image1= [self imageWithUrl:self.imageString1];
        NSLog(@"图片1下载完成---%@",[NSThread currentThread]);
        
        //下载图片2
        UIImage *image2= [self imageWithUrl:self.imageString2];
        NSLog(@"图片2下载完成---%@",[NSThread currentThread]);
        
        //回到主线程显示图片
        dispatch_async(main_queue, ^{
            NSLog(@"显示图片---%@",[NSThread currentThread]);
            self.imageView1.image=image1;
            self.imageView2.image=image2;
            //合并两张图片
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 100), NO, 0.0);
            [image1 drawInRect:CGRectMake(0, 0, 100, 100)];
            [image2 drawInRect:CGRectMake(100, 0, 100, 100)];
            self.imageView3.image=UIGraphicsGetImageFromCurrentImageContext();
            //关闭上下文
            UIGraphicsEndImageContext();
            NSLog(@"图片合并完成---%@",[NSThread currentThread]);
            NSDate *endDate = [NSDate date];
            NSTimeInterval endTime = endDate.timeIntervalSince1970;
            NSLog(@"endTime - startTime = %f",endTime - startTime);
        });
    });
}

- (void)group {
    NSDate *startDate = [NSDate date];
    NSTimeInterval startTime = startDate.timeIntervalSince1970;

    //1.创建一个队列组
    dispatch_group_t group = dispatch_group_create();
    
    //2.开启一个任务下载图片1
    __block UIImage *image1=nil;
    dispatch_group_async(group, global_quque, ^{
        image1= [self imageWithUrl:@"http://d.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=2b9a12172df5e0fefa1581533d095fcd/cefc1e178a82b9019115de3d738da9773912ef00.jpg"];
        NSLog(@"图片1下载完成---%@",[NSThread currentThread]);
    });
    
    //3.开启一个任务下载图片2
    __block UIImage *image2=nil;
    dispatch_group_async(group, global_quque, ^{
        image2= [self imageWithUrl:@"http://h.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=f47fd63ca41ea8d39e2f7c56f6635b2b/1e30e924b899a9018b8d3ab11f950a7b0308f5f9.jpg"];
        NSLog(@"图片2下载完成---%@",[NSThread currentThread]);
    });
    
    //同时执行下载图片1\下载图片2操作
    
    //4.等group中的所有任务都执行完毕, 再回到主线程执行其他操作
    dispatch_group_notify(group,main_queue, ^{
        NSLog(@"显示图片---%@",[NSThread currentThread]);
        self.imageView1.image=image1;
        self.imageView2.image=image2;
        
        //合并两张图片
        //注意最后一个参数是浮点数（0.0），不要写成0。
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 100), NO, 0.0);
        [image1 drawInRect:CGRectMake(0, 0, 100, 100)];
        [image2 drawInRect:CGRectMake(100, 0, 100, 100)];
        self.imageView3.image=UIGraphicsGetImageFromCurrentImageContext();
        //关闭上下文
        UIGraphicsEndImageContext();
        
        NSLog(@"图片合并完成---%@",[NSThread currentThread]);
        NSDate *endDate = [NSDate date];
        NSTimeInterval endTime = endDate.timeIntervalSince1970;
        NSLog(@"endTime - startTime = %f",endTime - startTime);
    });
    
}

//封装一个方法，传入一个url参数，返回一张网络上下载的图片
- (UIImage *)imageWithUrl:(NSString *)urlStr {
    NSURL *url=[NSURL URLWithString:urlStr];
    NSData *data=[NSData dataWithContentsOfURL:url];
    UIImage *image=[UIImage imageWithData:data];
    return image;
}

@end
