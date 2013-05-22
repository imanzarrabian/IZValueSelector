//
//  ViewController.m
//  IZValueSelector
//
//  Created by Iman Zarrabian on 02/11/12.
//  Copyright (c) 2012 Iman Zarrabian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,assign) BOOL wantHorizontal;
- (IBAction)setToOne:(id)sender;
- (IBAction)setToTwo:(id)sender;
@end

@implementation ViewController
@synthesize selectorVertical = _selectorVertical;
@synthesize selectorHorizontal = _selectorHorizontal;

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.wantHorizontal = YES;

    
    //YOU CAN ALSO ASSIGN THE DATA SOURCE AND THE DELEGATE IN CODE (IT'S ALREADY DONE IN NIB, BUT DO AS YOU PREFER)
    self.selectorVertical.dataSource = self;
    self.selectorVertical.delegate = self;
    self.selectorVertical.shouldBeTransparent = YES;
    self.selectorVertical.horizontalScrolling = NO;
    
    self.selectorHorizontal.dataSource = self;
    self.selectorHorizontal.delegate = self;
    self.selectorHorizontal.shouldBeTransparent = YES;
    self.selectorHorizontal.horizontalScrolling = YES;
    
    //You can toggle Debug mode on selectors to see the layout
    self.selectorVertical.debugEnabled = NO;
    self.selectorHorizontal.debugEnabled = NO;
    
    [[self selectorHorizontal] setDecelerates:NO];

}

- (IBAction)setToOne:(id)sender
{
    [self.selectorVertical selectRowAtIndex:1];
}
- (IBAction)setToTwo:(id)sender
{
    [self.selectorVertical selectRowAtIndex:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma IZValueSelector dataSource
- (NSInteger)numberOfRowsInSelector:(IZValueSelectorView *)valueSelector {
    return 30;
}



//ONLY ONE OF THESE WILL GET CALLED (DEPENDING ON the horizontalScrolling property Value)
- (CGFloat)rowHeightInSelector:(IZValueSelectorView *)valueSelector {
    return 70.0;
}

- (CGFloat)rowWidthInSelector:(IZValueSelectorView *)valueSelector {
    return 70.0;
}

- (UIView *)selector:(IZValueSelectorView *)valueSelector viewForRowAtIndex:(NSInteger)index
{
    return [self selector:valueSelector viewForRowAtIndex:index selected:NO];
}

- (UIView *)selector:(IZValueSelectorView *)valueSelector viewForRowAtIndex:(NSInteger)index selected:(BOOL)selected {
    UILabel * label = nil;
    if (valueSelector == self.selectorHorizontal) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, self.selectorHorizontal.frame.size.height)];
    }
    else {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.selectorVertical.frame.size.width, 70)];
    }
    label.text = [NSString stringWithFormat:@"%d",index];
    label.textAlignment =  NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    if (selected) {
        label.textColor = [UIColor redColor];
    } else {
        label.textColor = [UIColor blackColor];
    }
    return label;
}

- (CGRect)rectForSelectionInSelector:(IZValueSelectorView *)valueSelector {
    //Just return a rect in which you want the selector image to appear
    //Use the IZValueSelector coordinates
    //Basically the x will be 0
    //y will be the origin of your image
    //width and height will be the same as in your selector image
    if (valueSelector == self.selectorHorizontal) {
        return CGRectMake(self.selectorHorizontal.frame.size.width/2 - 35.0, 0.0, 70.0, 90.0);
    }
    else {
        return CGRectMake(0.0, self.selectorVertical.frame.size.height/2 - 35.0, 90.0, 70.0);
    }

}

#pragma IZValueSelector delegate
- (void)selector:(IZValueSelectorView *)valueSelector didSelectRowAtIndex:(NSInteger)index {
    NSLog(@"Selected index %d",index);
}


@end
