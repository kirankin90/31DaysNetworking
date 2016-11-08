//
//  ViewController.h
//  31DaysNetworking
//
//  Created by Kiran  Kumar on 11/8/16.
//  Copyright © 2016 Kiran  Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <NSURLSessionDelegate> {
    NSMutableData* _receivedData;
}
@property (weak, nonatomic) IBOutlet UITextField *textFieldData;
@property (weak, nonatomic) IBOutlet UILabel *labelData;

- (IBAction)buttonFetchData1:(id)sender;

- (IBAction)buttonFetchData2:(id)sender;

@end

