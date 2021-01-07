//
//  CarM1.m
//  MasterClassAll
//
//  Created by carl on 2020/11/1.
//

#import "CarM1.h"

@implementation CarM1

+ (instancetype)carWithName:(NSString *)name icon:(NSString *)icon {
    CarM1 *car = [[CarM1 alloc] init];
    car.name = name;
    car.icon = icon;
    return car;
}

@end
