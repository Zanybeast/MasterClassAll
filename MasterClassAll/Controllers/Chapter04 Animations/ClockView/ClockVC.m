//
//  ClockVC.m
//  MasterClassAll
//
//  Created by carl on 2021/1/5.
//

#import "ClockVC.h"

#define Angle2Radian(ang) ((ang) / 180 * M_PI)
#define CLOCK_SIDE self.clockView.bounds.size.width

#define ANGLE_PER_SEC 6
#define ANGLE_PER_MIN 6
#define ANGLE_PER_HOU 30
#define ANGLE_MIN_PER_SEC 0.1
#define ANGLE_HOUR_PER_MIN 0.5

@interface ClockVC ()

@property (weak, nonatomic) IBOutlet UIImageView *clockView;

@property (weak, nonatomic) CALayer *secondLayer;
@property (weak, nonatomic) CALayer *minuteLayer;
@property (weak, nonatomic) CALayer *hourLayer;

@end

@implementation ClockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupHourHand];
    [self setupMinuteHand];
    [self setupSecondHand];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChanged) userInfo:nil repeats:YES];
    
    [self timeChanged];
}

//MARK: - 时间改变, 每秒监听一次
- (void)timeChanged {
    //获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //从日历中获取时间
    NSDateComponents *components = [calendar components:
                                    NSCalendarUnitSecond |
                                    NSCalendarUnitMinute |
                                    NSCalendarUnitHour
                                               fromDate:[NSDate date]];
    
    NSInteger second = components.second;
    NSInteger minute = components.minute;
    NSInteger hour = components.hour;
    
    CGFloat secondAngle = second * ANGLE_PER_SEC;
    CGFloat minuteAngle = minute * ANGLE_PER_MIN + second * ANGLE_MIN_PER_SEC;
    CGFloat hourAngle = hour * ANGLE_PER_HOU + minute * ANGLE_HOUR_PER_MIN;
    
    self.secondLayer.transform = CATransform3DMakeRotation(Angle2Radian(secondAngle), 0, 0, 1);
    self.minuteLayer.transform = CATransform3DMakeRotation(Angle2Radian(minuteAngle), 0, 0, 1);
    self.hourLayer.transform = CATransform3DMakeRotation(Angle2Radian(hourAngle), 0, 0, 1);
    
}

//MARK: - 设置时钟指针
- (void)setupSecondHand {
    CALayer *secLayer = [CALayer layer];
    
    secLayer.backgroundColor = [UIColor redColor].CGColor;
    
    secLayer.position = CGPointMake(CLOCK_SIDE * 0.5, CLOCK_SIDE * 0.5);
    secLayer.anchorPoint = CGPointMake(0.5, 1);
    
    secLayer.bounds = CGRectMake(0, 0, 1.5, CLOCK_SIDE * 0.5 - 20);
    
    self.secondLayer = secLayer;
    
    [self.clockView.layer addSublayer:secLayer];
}

- (void)setupMinuteHand {
    CALayer *minLayer = [CALayer layer];
    
    minLayer.backgroundColor = [UIColor darkGrayColor].CGColor;
    
    minLayer.position = CGPointMake(CLOCK_SIDE * 0.5, CLOCK_SIDE * 0.5);
    minLayer.anchorPoint = CGPointMake(0.5, 1);
    
    minLayer.bounds = CGRectMake(0, 0, 4, CLOCK_SIDE * 0.5 - 40);
    
    minLayer.cornerRadius = 4;
    
    self.minuteLayer = minLayer;
    
    [self.clockView.layer addSublayer:minLayer];
}

- (void)setupHourHand {
    CALayer *hourLayer = [CALayer layer];
    
    hourLayer.backgroundColor = [UIColor blackColor].CGColor;
    
    hourLayer.position = CGPointMake(CLOCK_SIDE * 0.5, CLOCK_SIDE * 0.5);
    hourLayer.anchorPoint = CGPointMake(0.5, 1);
    
    hourLayer.bounds = CGRectMake(0, 0, 6, CLOCK_SIDE * 0.5 - 50);
    
    hourLayer.cornerRadius = 6;
    
    self.hourLayer = hourLayer;
    
    [self.clockView.layer addSublayer:hourLayer];
}

@end
