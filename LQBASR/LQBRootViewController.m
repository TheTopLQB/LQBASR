//
//  LQBRootViewController.m
//  LQBASR
//
//  Created by 李庆彬 on 26/02/2018.
//  Copyright © 2018 LQB. All rights reserved.
//

#import "LQBRootViewController.h"
#import "LQBBDViewController.h"
#import "LQBXFViewController.h"
#import "LQBAppleViewController.h"

static NSString * const cellIdentifier = @"cell";

@interface LQBRootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray * asrArray;

@end

@implementation LQBRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.asrArray = @[@"百度语音识别",@"讯飞语音识别",@"apple自带语音识别"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.asrArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.asrArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LQBBDViewController * bdVC = [[LQBBDViewController alloc] init];
        [self.navigationController pushViewController:bdVC animated:YES];
    }else if (indexPath.row == 1) {
        LQBXFViewController * xfVC = [[LQBXFViewController alloc] init];
        [self.navigationController pushViewController:xfVC animated:YES];
    }else if (indexPath.row == 2) {
        LQBAppleViewController * appleVC = [[LQBAppleViewController alloc] init];
        [self.navigationController pushViewController:appleVC animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end




