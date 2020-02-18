//
//  ViewController.m
//  Kubernetes Performance
//
//  Created by Suleman Imdad on 2/16/20.
//  Copyright © 2020 Suleman Imdad. All rights reserved.
//

#import "ViewController.h"
#import "Stats.h"
#import "ChartDataProvider.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCharts];
    [self startChartTimer];
}


- (void)startChartTimer{
    NSDate *d = [NSDate dateWithTimeIntervalSinceNow: 1.0];
    NSTimer *t = [[NSTimer alloc] initWithFireDate: d
                                          interval: 1
                                            target: self
                                          selector:@selector(onTick:)
                                          userInfo:nil repeats:YES];
    
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer:t forMode: NSDefaultRunLoopMode];
}

-(void)onTick:(NSTimer *)timer {
    [Stats getDataWithCompletion:^(NSMutableArray *statsArray) {

        [self runOnMainQueueWithoutDeadlocking:^{
            [self updateCharts:statsArray];
        }];
    }];
}

-(void)runOnMainQueueWithoutDeadlocking:(void (^)(void))block{
    if ([NSThread isMainThread])
    {
        block();
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}



-(void) setupCharts {
    
    
    NSFont * legendFont = [NSFont fontWithName:@"Verdana" size:19.0];
    NSFont * labelsFont = [NSFont fontWithName:@"Verdana" size:8.0];
    NSColor *gridBackgroundColor = [NSColor colorWithWhite:1.0 alpha:0.5];
    //[NSColor whiteColor] ;
    NSColor *labelsColor = [NSColor textColor];
    
    _theCPUChart.delegate = self;
    _theMemoryUsageChart.delegate = self;
    
    _theCPUChart.legend.font = legendFont;
    _theMemoryUsageChart.legend.font = legendFont;
    _theMemoryUsageChart.rightAxis.labelFont = labelsFont;
    _theCPUChart.rightAxis.labelFont = labelsFont;
    _theMemoryUsageChart.xAxis.labelFont = labelsFont;
    _theCPUChart.xAxis.labelFont = labelsFont;
    _theMemoryUsageChart.leftAxis.drawLabelsEnabled = false;
    _theCPUChart.leftAxis.drawLabelsEnabled = false;
    _theCPUChart.drawGridBackgroundEnabled = true;
    _theCPUChart.gridBackgroundColor = gridBackgroundColor;
    _theMemoryUsageChart.drawGridBackgroundEnabled = true;
    _theMemoryUsageChart.gridBackgroundColor = gridBackgroundColor;
    _theCPUChart.legend.textColor = labelsColor;
    _theMemoryUsageChart.legend.textColor = labelsColor;
    _theMemoryUsageChart.rightAxis.labelTextColor = labelsColor;
    _theCPUChart.rightAxis.labelTextColor = labelsColor;
    _theMemoryUsageChart.xAxis.labelTextColor = labelsColor;
    _theCPUChart.xAxis.labelTextColor = labelsColor;
    _theCPUChart.xAxis.labelPosition = XAxisLabelPositionBottom;
    _theCPUChart.xAxis.drawGridLinesEnabled = false;
    _theCPUChart.xAxis.drawAxisLineEnabled = false;
    _theMemoryUsageChart.xAxis.labelPosition = XAxisLabelPositionBottom;
    _theMemoryUsageChart.xAxis.drawGridLinesEnabled = false;
    _theMemoryUsageChart.xAxis.drawAxisLineEnabled = false;
    _theCPUChart.drawBordersEnabled = true;
    _theCPUChart.borderLineWidth = 2.0;
    _theCPUChart.borderColor = labelsColor;
    _theMemoryUsageChart.drawBordersEnabled = true;
    _theMemoryUsageChart.borderLineWidth = 2.0;
    _theMemoryUsageChart.borderColor = labelsColor;
}

- (void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight {
    //
}

-(void)updateCharts:(NSMutableArray*)statsArray{
    
    @autoreleasepool {
        NSMutableArray * timeStamps;
        LineChartData * chartDataForPower;
        LineChartData * chartDataForMemory;
        
        [ChartDataProvider getChartData:&chartDataForMemory chartDataForPower:&chartDataForPower statsArray:statsArray timeStamps:&timeStamps];
        
        _theCPUChart.data = chartDataForPower;
        _theMemoryUsageChart.data = chartDataForMemory;
        
        ChartIndexAxisValueFormatter * dhartIndexAxisValueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:timeStamps];
        
        _theCPUChart.xAxis.valueFormatter = dhartIndexAxisValueFormatter;
        _theCPUChart.xAxis.granularity = 1;
    
        _theMemoryUsageChart.xAxis.valueFormatter = dhartIndexAxisValueFormatter;
        _theMemoryUsageChart.xAxis.granularity = 1;
        
        [_theCPUChart notifyDataSetChanged];
        [_theMemoryUsageChart notifyDataSetChanged];
        
    }
}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}




@end
