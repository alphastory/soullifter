//
//  IAPRestoreSelectorView.h
//  The Soul Lifter
//
//  Created by Kyle Sebestyen on 9/9/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IAPRestoreSelectorView : UITableView <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *transactions;
}

-(void)setTransancations:(NSArray*)transactions;

@end
