//
//  SelectionViewController.m
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/8/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "SelectionViewController.h"
#import "SelectionModel.h"
#import "Card.h"

@interface SelectionViewController ()

@end

@implementation SelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)setActiveView:(NSString *)section {
    
    // Set the Active View
    
    self.selectionView = [[SelectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.selectionView.viewTitle = section;
    self.selectionView.delegate = self;
    [self.selectionView buildView];
    self.view = self.selectionView;
    
    self.model = [[SelectionModel alloc] initForType:section];
    self.model.delegate = self;
    [self getAllCardData];
    
    
}

-(void)getAllCardData {
    // Does File Exist?
    if( [self.model.data count] > 0 ){
        // Get it from the model
        [self.model getSavedCardData];
    } else {
        // Have the model create it
        [self.model setCardDefaults];
    }
}

-(void)sendCardsToView {
    [self.selectionView addCardsToUIWithData:self.model.data];
}

-(void)getCardsOfType:(NSString *)type {
    if( self.model ){
        NSLog(@"Model Exists");
    }
    if( [self.model respondsToSelector:@selector(filterCardsByType:)]){
        [self.model filterCardsByType:type];
//        if([type isEqualToString:@"static"]){
//            [self.model filterCardsByType:@"static"];
//        } else
//        
//        if([type isEqualToString:@"animated"]){
//            [self.model filterCardsByType:@"animated"];
//        } else
//            
//        if([type isEqualToString:@"favorites"]){
//            [self.model filterCardsByType:@"favorites"];
//        } else
//            
//        if([type isEqualToString:@"recents"]){
//            [self.model filterCardsByType:@"recents"];
//        }
    }
}

-(void)showMessageViewController:(MFMessageComposeViewController *)viewController {
    viewController.messageComposeDelegate = self;
    [self presentViewController:viewController animated:YES completion:nil];
}

-(void)showMailViewController:(MFMailComposeViewController *)viewController {
    viewController.mailComposeDelegate = self;
    [self presentViewController:viewController animated:YES completion:nil];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:controller completion:nil];
    if( result == MFMailComposeResultCancelled ){
        NSLog(@"Mail Cancelled");
    } else if( result == MFMailComposeResultFailed ){
        NSLog(@"Mail Failed");
    } else if( result == MFMailComposeResultSaved ){
        NSLog(@"Mail Saved");
    } else if( result == MFMailComposeResultSent ){
        NSLog(@"Mail Sent");
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController*)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:controller completion:nil];
    if( result == MessageComposeResultCancelled ){
        NSLog(@"Message Cancelled");
    } else if( result == MessageComposeResultFailed ){
        NSLog(@"Message Failed");
    } else if( result == MessageComposeResultSent ){
        NSLog(@"Message Sent");
    }
}

-(void)returnToHome {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
