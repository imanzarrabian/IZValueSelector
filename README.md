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
```


Then you should fill the right delegates and dataSources methods and you're good to go 


Please have a look at the Example controller Code