// IZValueSelectorView.m
//
// This is free and unencumbered software released into the public domain.
//
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.
//
// In jurisdictions that recognize copyright laws, the author or authors
// of this software dedicate any and all copyright interest in the
// software to the public domain. We make this dedication for the benefit
// of the public at large and to the detriment of our heirs and
// successors. We intend this dedication to be an overt act of
// relinquishment in perpetuity of all present and future rights to this
// software under copyright law.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.

// For more information, please refer to <http://unlicense.org/>

#import "IZValueSelectorView.h"
#import <QuartzCore/QuartzCore.h>


@implementation IZValueSelectorView {
    UITableView *_contentTableView;
    CGRect _selectionRect;
    NSIndexPath *selectedIndexPath;
}

@synthesize shouldBeTransparent = _shouldBeTransparent;
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.horizontalScrolling = NO;
        selectedIndexPath = nil;
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.horizontalScrolling = NO;
        self.decelerates = YES;
    }
    return self;
}

- (void)layoutSubviews {
    if (_contentTableView == nil) {
        [self createContentTableView];
    }
    [super layoutSubviews];
}

- (NSString *)selectedImageName
{
    if (!_selectedImageName) {
        _selectedImageName = @"selectorRect";
    }
    return _selectedImageName;
}

- (void)selectRowAtIndex:(NSUInteger)index animated:(BOOL)animated
{
    selectedIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [_contentTableView scrollToRowAtIndexPath:selectedIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    [self.delegate selector:self didSelectRowAtIndex:selectedIndexPath.row];
    [_contentTableView reloadData];
}

- (void)selectRowAtIndex:(NSUInteger)index
{
    [self selectRowAtIndex:index animated:YES];
}

- (void)createContentTableView {
    
    UIImageView *selectionImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self selectedImageName]]];
    _selectionRect = [self.dataSource rectForSelectionInSelector:self];
    selectionImageView.frame = _selectionRect;
    if (self.shouldBeTransparent) {
        selectionImageView.alpha = 0.7;
    }
    
    if (self.horizontalScrolling) {
        
        //In this case user might have created a view larger than taller
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.height, self.bounds.size.width)];
    }
    else {
        _contentTableView = [[UITableView alloc] initWithFrame:self.bounds];
    }
    
    if (self.debugEnabled) {
        _contentTableView.layer.borderColor = [UIColor blueColor].CGColor;
        _contentTableView.layer.borderWidth = 1.0;
        _contentTableView.layer.cornerRadius = 10.0;
        
        _contentTableView.tableHeaderView.layer.borderColor = [UIColor blackColor].CGColor;
        _contentTableView.tableFooterView.layer.borderColor = [UIColor blackColor].CGColor;
    }
    
    
    // Initialization code
    CGFloat OffsetCreated;
    
    //If this is an horizontal scrolling we have to rotate the table view
    if (self.horizontalScrolling) {
        CGAffineTransform rotateTable = CGAffineTransformMakeRotation(-M_PI_2);
        _contentTableView.transform = rotateTable;
        
        OffsetCreated = _contentTableView.frame.origin.x;
        _contentTableView.frame = self.bounds;
    }
    
    _contentTableView.backgroundColor = [UIColor clearColor];
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (self.horizontalScrolling) {
        _contentTableView.rowHeight = [self.dataSource rowWidthInSelector:self];
    }
    else {
        _contentTableView.rowHeight = [self.dataSource rowHeightInSelector:self];
    }
    
    if (self.horizontalScrolling) {
        _contentTableView.contentInset = UIEdgeInsetsMake( _selectionRect.origin.x ,  0,_contentTableView.frame.size.height - _selectionRect.origin.x - _selectionRect.size.width - 2*OffsetCreated, 0);
    }
    else {
        _contentTableView.contentInset = UIEdgeInsetsMake( _selectionRect.origin.y, 0, _contentTableView.frame.size.height - _selectionRect.origin.y - _selectionRect.size.height  , 0);
    }
    _contentTableView.showsVerticalScrollIndicator = NO;
    _contentTableView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:_contentTableView];
    [self addSubview:selectionImageView];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */



#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = [self.dataSource numberOfRowsInSelector:self];
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *contentSubviews = [cell.contentView subviews];
    //We the content view already has a subview we just replace it, no need to add it again
    //hopefully ARC will do the rest and release the old retained view
    if ([contentSubviews count] >0 ) {
        UIView *contentSubV = [contentSubviews objectAtIndex:0];
        
        //This will release the previous contentSubV
        [contentSubV removeFromSuperview];
        BOOL selected = indexPath.row == selectedIndexPath.row;
        UIView *viewToAdd = nil;
        if ([self.dataSource respondsToSelector:@selector(selector:viewForRowAtIndex:selected:)]) {
            viewToAdd = [self.dataSource selector:self viewForRowAtIndex:indexPath.row selected:selected];
        } else {
            viewToAdd = [self.dataSource selector:self viewForRowAtIndex:indexPath.row];
        }
        contentSubV = viewToAdd;
        if (self.debugEnabled) {
            viewToAdd.layer.borderWidth = 1.0;
            viewToAdd.layer.borderColor = [UIColor redColor].CGColor;
        }
        [cell.contentView addSubview:contentSubV];
    }
    else {
        BOOL selected = indexPath.row == selectedIndexPath.row;
        UIView *viewToAdd = nil;
        if ([self.dataSource respondsToSelector:@selector(selector:viewForRowAtIndex:selected:)]) {
            viewToAdd = [self.dataSource selector:self viewForRowAtIndex:indexPath.row selected:selected];
        } else {
            viewToAdd = [self.dataSource selector:self viewForRowAtIndex:indexPath.row];
        }
        //This is a new cell so we just have to add the view
        if (self.debugEnabled) {
            viewToAdd.layer.borderWidth = 1.0;
            viewToAdd.layer.borderColor = [UIColor redColor].CGColor;
        }
        [cell.contentView addSubview:viewToAdd];
        
    }
    
    if (self.debugEnabled) {
        cell.layer.borderColor = [UIColor greenColor].CGColor;
        cell.layer.borderWidth = 1.0;
    }
    
    if (self.horizontalScrolling) {
        CGAffineTransform rotateTable = CGAffineTransformMakeRotation(M_PI_2);
        cell.transform = rotateTable;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _contentTableView) {
        selectedIndexPath = indexPath;
        [_contentTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
        [self.delegate selector:self didSelectRowAtIndex:indexPath.row];
        [_contentTableView reloadData];
    }
}

#pragma mark Scroll view methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self decelerates]) {
        [self scrollToTheSelectedCell];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) { 
        [self scrollToTheSelectedCell];
    }
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (![self decelerates]) {
        [self scrollToTheSelectedCell];
    }
}

- (void)scrollToTheSelectedCell {
    
    CGRect selectionRectConverted = [self convertRect:_selectionRect toView:_contentTableView];
    NSArray *indexPathArray = [_contentTableView indexPathsForRowsInRect:selectionRectConverted];
    
    CGFloat intersectionHeight = 0.0;
    
    for (NSIndexPath *index in indexPathArray) {
        //looping through the closest cells to get the closest one
        UITableViewCell *cell = [_contentTableView cellForRowAtIndexPath:index];
        CGRect intersectedRect = CGRectIntersection(cell.frame, selectionRectConverted);
        
        if (intersectedRect.size.height>=intersectionHeight) {
            selectedIndexPath = index;
            intersectionHeight = intersectedRect.size.height;
        }
    }
    if (selectedIndexPath!=nil) {
        //As soon as we elected an indexpath we just have to scroll to it
        [_contentTableView scrollToRowAtIndexPath:selectedIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        [self.delegate selector:self didSelectRowAtIndex:selectedIndexPath.row];
        [_contentTableView reloadData];
    }
}



- (void)reloadData {
    [_contentTableView reloadData];
}




@end
