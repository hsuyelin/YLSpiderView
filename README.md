# YLSpiderView

仿掌上英雄联盟能力图

####演示
![演示](https://github.com/hsuyelin/YLSpiderView/blob/master/Preview/preview.gif)

####使用方式
```objectivec
/// 初始化能力图对象
YLSpiderView *spiderView = [[YLSpiderView alloc] initWithFrame:CGRectMake(kScreenWidth * 0.75 / 5, 74, kScreenWidth * 3.5 / 5, kScreenWidth * 3.5 / 5)];
/// 能力描述
spiderView.valueDescArr = @[@"击杀", @"生存", @"助攻", @"物理", @"魔法", @"防御", @"金钱"];
/// 能力值，支持多条能力值
spiderView.valueArr = @[@[@"80", @"40", @"100", @"76", @"75", @"50", @"60"],
                        @[@"30", @"40", @"60", @"25", @"100", @"70", @"80"]];
/// 从内向外，每块区域的颜色，默认4块区域，可以看头文件的属性
spiderView.areaFillColorArr = @[[UIColor colorWithRed:36 / 225.0 green:119 / 255.0 blue:125 / 255.0 alpha:1.0],
                                [UIColor colorWithRed:72 / 225.0 green:176 / 255.0 blue:184 / 255.0 alpha:1.0],
                                [UIColor colorWithRed:127 / 225.0 green:211 / 255.0 blue:217 / 255.0 alpha:1.0],
                                [UIColor colorWithRed:127 / 225.0 green:211 / 255.0 blue:217 / 255.0 alpha:0.5]];
/// 从内向外，每块区域边界的颜色
spiderView.areaBorderColorArr = @[[UIColor colorWithRed:36 / 225.0 green:119 / 255.0 blue:125 / 255.0 alpha:1.0],
                                  [UIColor colorWithRed:72 / 225.0 green:176 / 255.0 blue:184 / 255.0 alpha:1.0],
                                  [UIColor colorWithRed:127 / 225.0 green:211 / 255.0 blue:217 / 255.0 alpha:1.0],
                                  [UIColor colorWithRed:168 / 255.0 green:217 / 255.0 blue:217 / 255.0 alpha:1.0]];
/// 能力值边界颜色
spiderView.valueBorderColorArr = @[[UIColor colorWithRed:234 / 255.0 green:74 / 255.0 blue:54 / 255.0 alpha:1.0]];
/// 能力图分割线颜色
spiderView.separatorLineColor = [UIColor colorWithRed:145 / 255.0 green:207 / 255.0 blue:207 / 255.0 alpha:1.0];
/// 配置能力图相关数据，绘图，这个方法需要在所有配置完成后调用
[spiderView yl_configSpiderView];

/// 刷新指定数据
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    spiderView.valueArr = @[@[@"20",@"60",@"80",@"90",@"35",@"65",@"100"],
                            @[@"30",@"40",@"60",@"25",@"100",@"70",@"80"]];
    [spiderView yl_reloadDataAtIndex:0];
});

/// 刷新所有数据
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    spiderView.valueArr = @[@[@"30",@"40",@"60",@"25",@"100",@"70",@"80"]];
    [spiderView yl_reloadData];
});
```