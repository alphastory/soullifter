//
//  CollectionSelectorTableViewController.m
//  The Soul Lifter
//
//  Created by Kyle Sebestyen on 9/28/15.
//  Copyright © 2015 Planet Soul. All rights reserved.
//

#import "CollectionSelectorTableViewController.h"

@implementation CollectionSelectorTableViewController

NSString* reuseIdentifier = @"categorySelectorIdentifier";

-(void)viewDidLoad
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [super viewDidLoad];
}

-(NSString*)getCountTitleForCollection:(CollectionModel*)collection
{
    if([collection count] != 1)
    {
        return [NSString stringWithFormat:@"%i Cards", [collection count]];
    }
    else{
        return [NSString stringWithFormat:@"%i Card", [collection count]];
    }
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.collections.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath ];
    
    CollectionModel *model = (CollectionModel *)self.collections[indexPath.row];
    cell.textLabel.text = model.collectionName;
    
    cell.detailTextLabel.text = [self getCountTitleForCollection:model];
    return cell;
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionDelegate collectionSelectorDidSelectCollection:self.collections[indexPath.row]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
