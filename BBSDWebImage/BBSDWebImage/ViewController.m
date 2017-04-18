//
//  ViewController.m
//  BBSDWebImage
//
//  Created by 王二 on 17/4/18.
//  Copyright © 2017年 mbs008. All rights reserved.
//

#import "ViewController.h"
#import "SimpleCellModel.h"
#import "UIImageView+BBWebCache.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
/**
 *  所有数据
 */
@property (nonatomic, strong) NSArray *dataModels;
/**
 *
 */
@property (nonatomic, strong) IBOutlet UITableView *mainTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"dataModel";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    SimpleCellModel *dataModel = self.dataModels[indexPath.row];
    cell.textLabel.text = dataModel.name;
    cell.detailTextLabel.text = dataModel.download;
    [cell.imageView bb_setImageWithUrlString:dataModel.icon];
    
    return cell;
}

#pragma mark - getter

- (NSArray *)dataModels {
    if (!_dataModels) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dataModels.plist" ofType:nil]];
        
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            for (int i = 0; i < 10; i++) {
                [dataArray addObject:[SimpleCellModel cellModelWithDict:dict]];
            }
        }
        _dataModels = dataArray;
    }
    
    return _dataModels;
}

@end
