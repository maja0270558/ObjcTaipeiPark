//
//  ParkClient.h
//  TaipeiPark
//
//  Created by 大容 林 on 2018/7/9.
//  Copyright © 2018年 Django. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ParkClient : NSObject {
  NSMutableDictionary<NSString *,NSURLSessionTask *> *taskDic;
  NSCache<NSString *,UIImage *> *imageCatch;
}

-(instancetype) init;
-(void) requestWith:(NSURLRequest*)request completion:(void(^)(NSData*))callback;
-(void) requestImageWith:(NSURLRequest *)request completion:(void (^)(UIImage *))callback;
@end
