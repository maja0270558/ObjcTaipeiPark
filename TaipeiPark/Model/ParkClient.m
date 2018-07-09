//
//  ParkClient.m
//  TaipeiPark
//
//  Created by 大容 林 on 2018/7/9.
//  Copyright © 2018年 Django. All rights reserved.
//

#import "ParkClient.h"

@implementation ParkClient

+ (void)requestWith:(NSURLRequest *)request completion:(void (^)(NSData *))callback
{
  NSURLSession *defaultSession = [NSURLSession sharedSession];
  NSURLSessionTask *task = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (error){
      return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
      callback(data);
    });
    
  }];
  [task resume];

}

@end
