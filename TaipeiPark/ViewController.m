//
//  ViewController.m
//  TaipeiPark
//
//  Created by 大容 林 on 2018/7/7.
//  Copyright © 2018年 Django. All rights reserved.
//

#import "ViewController.h"
#import "ParkTableViewCell.h"
#import "ParkClient.h"
#import "RequestProvider.h"
#import "ParkModel.h"
@interface ViewController () <UITableViewDelegate,UITableViewDataSource> {
  __weak IBOutlet UITableView *tableView;
  RequestProvider *requestProvider;
  ParkClient *client;
}
-(void) setupTableView;
-(void) getParkData;
-(void) setupProvider;
@end

@implementation ViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupTableView];
  [self setupProvider];
  [self getParkData];
}

- (void)setupProvider
{
  requestProvider = [[RequestProvider alloc] init];
}

- (void)setupTableView
{
  cellIdentifier = @"ParkTableViewCell";
  UINib *nib = [UINib nibWithNibName: cellIdentifier bundle:nil];
  [tableView registerNib:nib forCellReuseIdentifier: cellIdentifier];
  tableView.delegate = self;
  tableView.dataSource = self;
  data = [[NSMutableArray alloc] init];
  client = [[ParkClient alloc] init];
  
}

- (void)getParkData
{
  NSURLRequest *request = [requestProvider getRequest:[requestProvider getParkURLString] withMethod:GET];
  [client requestWith:request completion:^(NSData *jsonData) {
    self->requestProvider.offset += 30;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *result = dict[@"result"];
    NSArray *results = result[@"results"];
    if (results.count > 0) {
      for (NSDictionary *item in [results objectEnumerator]) {
        ParkModel *model = [[ParkModel alloc] initWithDic:item];
        
        [self->data addObject:model];
      }
      [self->tableView reloadData];
    }
  }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  ParkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier forIndexPath:indexPath];
  ParkModel *modelData = data[indexPath.row];
  cell.tag = indexPath.row;
  cell.title.text = modelData.variety;
  cell.intro.text = modelData.note;
  NSURLRequest *request = [requestProvider getRequest:modelData.image withMethod:GET];
  [client requestImageWith:request completion:^(UIImage *data) {
    if ([tableView cellForRowAtIndexPath:indexPath])/*(cell.tag == indexPath.row)*/ {
      cell.parkImage.image = data;
    }
  }];
  return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row+1 == data.count) {
    [self getParkData];
  }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  ParkTableViewCell *parkCell = cell;
  parkCell.parkImage.image = nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return UITableViewAutomaticDimension;
}

@end
