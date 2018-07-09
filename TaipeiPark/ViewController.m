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
}

- (void)getParkData
{
  NSURLRequest *request = [requestProvider getRequest:[requestProvider getParkURLString] withMethod:GET];
  [ParkClient requestWith:request completion:^(NSData *jsonData) {
    self->requestProvider.offset += 30;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *result = dict[@"result"];
    NSArray *results = result[@"results"];
    for (NSDictionary *item in [results objectEnumerator]) {
      ParkModel *model = [[ParkModel alloc] initWithDic:item];
 
      [self->data addObject:model];
    }
    printf("data count %d", data.count);
    [self->tableView reloadData];
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
  cell.title.text = modelData.variety;
  cell.intro.text = modelData.note;
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return UITableViewAutomaticDimension;
}

@end
