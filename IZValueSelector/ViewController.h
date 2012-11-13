//
//  ViewController.h
//  IZValueSelector
//
//  Created by Iman Zarrabian on 02/11/12.
//  Copyright (c) 2012 Iman Zarrabian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IZValueSelectorView.h"
@interface ViewController : UIViewController<IZValueSelectorViewDataSource,IZValueSelectorViewDelegate>




@property (nonatomic,weak) IBOutlet IZValueSelectorView *selectorVertical;
@property (nonatomic,weak) IBOutlet IZValueSelectorView *selectorHorizontal;

@end
