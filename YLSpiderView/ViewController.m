//
//  ViewController.m
//  YLSpiderView
//
//  Created by hsuyelin on 2018/5/16.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

#import "ViewController.h"

#import "YLSpiderView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self showSpiderViewTest1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showSpiderViewTest2];
    });
}

- (void)showSpiderViewTest1
{
    YLSpiderView *spiderView = [[YLSpiderView alloc] initWithFrame:CGRectMake(kScreenWidth * 0.75 / 5, 74, kScreenWidth * 3.5 / 5, kScreenWidth * 3.5 / 5)];
    spiderView.valueDescArr = @[@"击杀",@"生存",@"助攻",@"物理",@"魔法",@"防御",@"金钱"];
    spiderView.valueArr = @[@[@"80",@"40",@"100",@"76",@"75",@"50",@"60"]];
//    spiderView.areaFillColorArr = @[[UIColor colorWithRed:36 / 225.0 green:119 / 255.0 blue:125 / 255.0 alpha:1.0],
//                                    [UIColor colorWithRed:72 / 225.0 green:176 / 255.0 blue:184 / 255.0 alpha:1.0],
//                                    [UIColor colorWithRed:127 / 225.0 green:211 / 255.0 blue:217 / 255.0 alpha:1.0],
//                                    [UIColor colorWithRed:127 / 225.0 green:211 / 255.0 blue:217 / 255.0 alpha:0.5]];
//    spiderView.areaBorderColorArr = @[[UIColor colorWithRed:36 / 225.0 green:119 / 255.0 blue:125 / 255.0 alpha:1.0],
//                                      [UIColor colorWithRed:72 / 225.0 green:176 / 255.0 blue:184 / 255.0 alpha:1.0],
//                                      [UIColor colorWithRed:127 / 225.0 green:211 / 255.0 blue:217 / 255.0 alpha:1.0],
//                                      [UIColor colorWithRed:168 / 255.0 green:217 / 255.0 blue:217 / 255.0 alpha:1.0]];
//    spiderView.valueBorderColorArr = @[[UIColor colorWithRed:234 / 255.0 green:74 / 255.0 blue:54 / 255.0 alpha:1.0]];
//    spiderView.separatorLineColor = [UIColor colorWithRed:145 / 255.0 green:207 / 255.0 blue:207 / 255.0 alpha:1.0];
    [spiderView yl_configSpiderView];
    
    [self.view addSubview:spiderView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        spiderView.valueArr = @[@[@"30",@"40",@"60",@"25",@"100",@"70",@"80"]];
        [spiderView yl_reloadData];
    });
}

- (void)showSpiderViewTest2
{
    YLSpiderView *spiderView = [[YLSpiderView alloc] initWithFrame:CGRectMake(kScreenWidth * 0.75 / 5, 74, kScreenWidth * 3.5 / 5, kScreenWidth * 3.5 / 5)];
    spiderView.valueDescArr = @[@"击杀",@"生存",@"助攻",@"物理",@"魔法",@"防御",@"金钱"];
    spiderView.valueArr = @[@[@"80",@"40",@"100",@"76",@"75",@"50",@"60"],
                            @[@"30",@"40",@"60",@"25",@"100",@"70",@"80"]];
    spiderView.areaFillColorArr = @[[UIColor colorWithRed:36 / 225.0 green:119 / 255.0 blue:125 / 255.0 alpha:1.0],
                                    [UIColor colorWithRed:72 / 225.0 green:176 / 255.0 blue:184 / 255.0 alpha:1.0],
                                    [UIColor colorWithRed:127 / 225.0 green:211 / 255.0 blue:217 / 255.0 alpha:1.0],
                                    [UIColor colorWithRed:127 / 225.0 green:211 / 255.0 blue:217 / 255.0 alpha:0.5]];
    spiderView.areaBorderColorArr = @[[UIColor colorWithRed:36 / 225.0 green:119 / 255.0 blue:125 / 255.0 alpha:1.0],
                                      [UIColor colorWithRed:72 / 225.0 green:176 / 255.0 blue:184 / 255.0 alpha:1.0],
                                      [UIColor colorWithRed:127 / 225.0 green:211 / 255.0 blue:217 / 255.0 alpha:1.0],
                                      [UIColor colorWithRed:168 / 255.0 green:217 / 255.0 blue:217 / 255.0 alpha:1.0]];
    spiderView.valueBorderColorArr = @[[UIColor colorWithRed:234 / 255.0 green:74 / 255.0 blue:54 / 255.0 alpha:1.0]];
    spiderView.separatorLineColor = [UIColor colorWithRed:145 / 255.0 green:207 / 255.0 blue:207 / 255.0 alpha:1.0];
    [spiderView yl_configSpiderView];
    
    [self.view addSubview:spiderView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        spiderView.valueArr = @[@[@"20",@"60",@"80",@"90",@"35",@"65",@"100"],
                                @[@"30",@"40",@"60",@"25",@"100",@"70",@"80"]];
        [spiderView yl_reloadDataAtIndex:0];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
