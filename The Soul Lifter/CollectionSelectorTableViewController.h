//
//  CollectionSelectorTableViewController.h
//  The Soul Lifter
//
//  Created by Kyle Sebestyen on 9/28/15.
//  Copyright © 2015 Planet Soul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionModel.h"


@protocol CollectionSelectorProtocol <NSObject>

-(void)collectionSelectorDidSelectCollection:(CollectionModel*)collection;

@end

@interface CollectionSelectorTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, weak)id<CollectionSelectorProtocol>collectionDelegate;
@property(nonatomic,strong)NSArray*collections;

@end
