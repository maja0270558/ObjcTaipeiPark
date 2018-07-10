//
//  ParkClient.m
//  TaipeiPark
//
//  Created by 大容 林 on 2018/7/9.
//  Copyright © 2018年 Django. All rights reserved.
//

#import "ParkClient.h"

@implementation ParkClient
- (instancetype)init
{
  self = [super init];
  if (self) {
    imageCatch = [[NSCache alloc] init];
    taskDic = [[NSMutableDictionary alloc] init];
  }
  return self;
}
- (void)requestWith:(NSURLRequest *)request completion:(void (^)(NSData *))callback
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
- (void)requestImageWith:(NSURLRequest *)request completion:(void (^)(UIImage *))callback
{
  NSString *key = request.URL.absoluteString;
  //if data exist
  if ([imageCatch objectForKey:key]) {
    callback([imageCatch objectForKey:key]);
    return;
  }
  //if don't but request exist
  else if ([taskDic objectForKey:key]) {
    return;
  } else {
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    NSURLSessionTask  *task = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      
      if(error) {
        return;
      }
      UIImage *image = [UIImage imageWithData:data];
      if (image) {
        [taskDic removeObjectForKey:key];
        [imageCatch setObject:image forKey:key];
        dispatch_async(dispatch_get_main_queue(), ^{
          callback(image);
        });
      }      
    }];
    [task resume];
    [taskDic setValue:task forKey:key];
  }
}

@end
