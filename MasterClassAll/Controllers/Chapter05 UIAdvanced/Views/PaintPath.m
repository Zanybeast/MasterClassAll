//
//  PaintPath.m
//  MasterClassAll
//
//  Created by carl on 2020/12/8.
//

#import "PaintPath.h"

#define PATH_COLOR @"pathColorForPaint"

@implementation PaintPath

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _pathColor = [coder decodeObjectForKey:PATH_COLOR];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder:coder];
    [coder encodeObject:_pathColor forKey:PATH_COLOR];
}


@end
