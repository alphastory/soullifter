//
//  IAPRestoreSelectorView.m
//  The Soul Lifter
//
//  Created by Kyle Sebestyen on 9/9/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "IAPRestoreSelectorView.h"
#import <StoreKit/StoreKit.h>


@implementation IAPRestoreSelectorView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.allowsMultipleSelection = YES;
    self.delegate = self;
    self.dataSource = self;
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"IAPRestoreCell"];
    return self;
}

-(void)setTransancations:(NSArray*)_transactions
{
    transactions = _transactions;
    [self reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return transactions.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IAPRestoreCell"];
    
    SKPaymentTransaction *transaction = transactions[indexPath.row];
    
    cell.textLabel.text = transaction.transactionIdentifier;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
