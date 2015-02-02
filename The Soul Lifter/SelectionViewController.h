//
//  SelectionViewController.h
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/8/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectionView.h"
#import "SelectionModel.h"
#import "Card.h"

@interface SelectionViewController : UIViewController <SelectionViewDelegate, SelectionModelDelegate, CardDelegate, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) SelectionView *selectionView;
@property (strong, nonatomic) SelectionModel *model;
@property (strong, nonatomic) NSDictionary *cardData;

-(void)setActiveView:(NSString *)section;
-(void)getCardsOfType:(NSString *)type;

@end
