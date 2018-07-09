//
//  ParkTableViewCell.h
//  TaipeiPark
//
//  Created by 大容 林 on 2018/7/9.
//  Copyright © 2018年 Django. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParkTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *parkImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *intro;

@end
