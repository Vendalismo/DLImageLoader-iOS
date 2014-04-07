//
//  TableViewCell.h
//  DLImageLoader Demo
//
//  Created by Andrew Lunevich on 4/5/14.
//  Copyright (c) 2014 Andrey Lunevich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end