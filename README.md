IZValueSelector
===============

IZValueSelector-iOS


How To use it ?
===============

Simply create your IZValueSelector view via IB or in code 
and declare your controller as the delegate and dataSource as with a simple UITableView

```
    self.selector.dataSource = self;
    self.selector.delegate = self;
    self.selector.shouldBeTransparent = YES;
    self.selector.horizontalScrolling = YES;
    self.selector.decelerates = NO;

    //You can toggle Debug mode on selectors to see the layout
    self.selector.debugEnabled = NO; 
```


Then you should fill the delegate and dataSource methods and you're good to go. 
Don't forget to provide an image for your selector!

Have a look at the provided example controller code
