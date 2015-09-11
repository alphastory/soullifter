//
//  StoreViewController.h
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/25/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <DropboxSDK/DropboxSDK.h>
#import "StoreView.h"
#import "StoreModel.h"


@interface StoreViewController : UIViewController <StoreViewDelegate, StoreModelDelegate>
{
    UIAlertView *restoringAlert;
}


@property (strong, nonatomic) StoreView *storeView;
@property (strong, nonatomic) StoreModel *storeModel;

@end
