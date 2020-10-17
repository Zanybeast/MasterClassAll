//
//  SectionController.h
//  MasterClassAll
//
//  Created by carl on 2020/10/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SectionController : UITableViewController

@property(nonatomic, assign) NSInteger sectionNumber;
@property(nonatomic, copy) NSArray* controllers;

@end

NS_ASSUME_NONNULL_END
