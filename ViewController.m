//
//  ViewController.m
//  31DaysNetworking
//
//  Created by Kiran  Kumar on 11/8/16.
//  Copyright © 2016 Kiran  Kumar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)buttonFetchData1:(id)sender {
    NSString *queryString = [NSString stringWithFormat:@" http://chrisrisner.com/Labs/day7test.php?name = %@ ", [self.textFieldData text]];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:queryString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [theRequest setHTTPMethod:@"POST"];
    NSString *post = [NSString stringWithFormat:@"postedValue=%@", [self.textFieldData text]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    [theRequest setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:theRequest];
    if (dataTask) {
        _receivedData = [NSMutableData data];
    }
    else {
        NSLog(@"Some error");
    }
    
}

- (IBAction)buttonFetchData2:(id)sender {
    
}

- (void)connection:(NSURLSession*)connection didReceiveResponse:(nonnull NSURLResponse *)response{
    if (_receivedData == NULL) {
        _receivedData = [[NSMutableData alloc]init];
    }
    [_receivedData setLength:0];
    NSLog(@"didReceiveResponse: responseData Length:(%lu) ", (unsigned long)_receivedData.length);
}

- (void)connection:(NSURLSession*)connection didReceiveData:(nonnull NSData *)data {
    [_receivedData appendData:data];
}

-(void)connection:(NSURLSession*)connection didFailWithError:(nonnull NSError *)error {
    NSLog(@"Connection failed with error - %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

-(void)connectionDidFinishLoading: (NSURLSession*)connection {
    NSLog(@"data received succesfully with %lu bytes of data ", [_receivedData length]);
    NSString *responseText = [[NSString alloc]initWithData:_receivedData encoding:NSASCIIStringEncoding];
    NSLog(@"Response :%@", responseText);
    NSString *newLineString = @"/n";
    responseText = [responseText stringByReplacingOccurrencesOfString:@"<br />" withString:newLineString];
    [self.labelData setText:responseText];
}
@end
