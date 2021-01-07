//
//  PaintView.m
//  MasterClassAll
//
//  Created by carl on 2020/12/8.
//

#import "PaintView.h"
#import "PaintImageView.h"
#import "PaintPath.h"

#define DATA_PATH [ZFileUtil fullPathInDocumentWith:@"paintPath.data"]

@interface PaintView ()

@property (strong, nonatomic) PaintPath *path;
@property (strong, nonatomic) NSMutableArray *paths;

@end

@implementation PaintView

- (NSMutableArray *)paths {
    if (_paths == nil) {
        NSSet *classes = [NSSet setWithObjects:[PaintPath class], [UIImage class], [UIColor class], nil];
        NSMutableData *data = [NSMutableData dataWithContentsOfFile:DATA_PATH];
        NSError *error = nil;
        _paths = (NSMutableArray *)[NSKeyedUnarchiver unarchivedArrayOfObjectsOfClasses:classes fromData:data error:&error];
        
        if (_paths == nil) {
            _paths = [NSMutableArray array];
        }
        
        if (error != nil) {
            ZLog(@"error comes");
            NSLog(@"%@", error);
        }
        
    }
    return _paths;
}

- (void)setImage:(UIImage *)image {
    [self.paths addObject:image];
    
    [self setNeedsDisplay];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
}

#pragma mark - 初始化工作
- (void)setup {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}

- (void)pan: (UIPanGestureRecognizer *)pan {
    CGPoint curP = [pan locationInView:self];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.path = [[PaintPath alloc] init];
        
        self.path.lineWidth = self.lineWidth == 0 ? 1 : self.lineWidth;
        self.path.pathColor = self.lineColor;
        
        [self.path moveToPoint:curP];
        
        [self.paths addObject:self.path];
        
    }
    
    [self.path addLineToPoint:curP];
    
    [self persistance];
    
    [self setNeedsDisplay];
}

#pragma mark - 按钮点击
- (void)clear {
    [self.paths removeAllObjects];
    [self persistance];
    
    [self setNeedsDisplay];
}

- (void)undo {
    if (self.paths.count > 0) {
        [self.paths removeLastObject];
        [self persistance];
    }
    
    [self setNeedsDisplay];
}

#pragma mark - 数据持久化
- (void)persistance {
    NSError *error = nil;
    
    [[NSKeyedArchiver archivedDataWithRootObject:self.paths requiringSecureCoding:NO error:&error] writeToFile:DATA_PATH atomically:YES];
    
    if (error != nil) {
        NSLog(@"%@", error.localizedDescription);
    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    for (PaintPath *path in self.paths) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)path;
            
            [image drawInRect:rect];
        } else {
            [path.pathColor set];
            [path stroke];
        }
    }
}



@end
