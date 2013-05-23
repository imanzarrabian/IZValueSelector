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




LICENSE 
===============

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>
