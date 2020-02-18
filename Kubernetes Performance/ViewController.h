//
//  ViewController.h
//  Kubernetes Performance
//
//  Created by Suleman Imdad on 2/16/20.
//  Copyright © 2020 Suleman Imdad. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Charts-Swift.h>


@interface ViewController : NSViewController <ChartViewDelegate>

@property (weak) IBOutlet LineChartView *theCPUChart;
@property (weak) IBOutlet LineChartView *theMemoryUsageChart;




@end

