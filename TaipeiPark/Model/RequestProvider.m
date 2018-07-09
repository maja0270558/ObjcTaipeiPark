//
//  RequestProvider.m
//  TaipeiPark
//
//  Created by 大容 林 on 2018/7/9.
//  Copyright © 2018年 Django. All rights reserved.
//

#import "RequestProvider.h"

@implementation RequestProvider

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.limit = 30;
    self.offset = 0;
  }
  return self;
}

- (NSURLRequest *)getRequest:(NSString *)urlString withMethod:(HTTPMethod) method
{
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
  NSURL *url = [[NSURL alloc] initWithString:urlString];
  if (url) {
    request.URL = url;
  }
  request.HTTPMethod = [self getHTTPString:method];
  return request;
}

- (NSMutableString *)getParkURLString
{
  NSMutableString *baseURL = [NSMutableString stringWithString:@"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812"];
  NSString *limitPrefix = [NSString stringWithFormat:@"&limit=%d",self.limit];
  NSString *offsetPrefix = [NSString stringWithFormat:@"&offset=%d",self.offset];
  [baseURL appendString:limitPrefix];
  [baseURL appendString:offsetPrefix];

  return baseURL;
}

- (NSString *)getHTTPString:(HTTPMethod)method
{
  switch (method) {
    case GET:
      return @"GET";
    case POST:
      return @"POST";
    case PUT:
      return @"PUT";
    case UPDATE:
      return @"UPDATE";
    default:
      return @"";
  }
}
@end
