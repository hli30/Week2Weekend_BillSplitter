//
//  ViewController.m
//  BillSplitter
//
//  Created by Harry Li on 2017-06-11.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UISlider *numberOfPeopleSlider;
@property (weak, nonatomic) IBOutlet UILabel *splitAmountLabel;

@property (nonatomic) NSString *billAmount;
@property (nonatomic) NSString *numberOfPeople;
@property (nonatomic) NSString *splitAmount;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUpdatedData:) name:@"DataUpdated" object:nil];
}

- (void)handleUpdatedData:(NSNotification *)notification{
    [self calculateSplitAmount];
    self.splitAmountLabel.text = [NSString stringWithFormat:@"$%@ between %@ people", self.splitAmount, self.numberOfPeople];
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DataUpdated" object:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self calculateSplitAmount];
    self.splitAmountLabel.text = [NSString stringWithFormat:@"$%@ between %@ people", self.splitAmount, self.numberOfPeople];
    [textField resignFirstResponder];
    return YES;
}

-(void)calculateSplitAmount{
    self.numberOfPeople = [NSString stringWithFormat:@"%.0f", self.numberOfPeopleSlider.value];
    self.billAmount = self.billAmountTextField.text;
    float splitAmount = self.billAmount.floatValue / self.numberOfPeople.floatValue;
    self.splitAmount = [NSString stringWithFormat:@"%.2f", splitAmount];
}

@end
