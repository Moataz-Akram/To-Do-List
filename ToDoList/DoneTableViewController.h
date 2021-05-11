//
//  DoneTableViewController.h
//  ToDoList
//
//  Created by Moataz on 05/04/2021.
//

#import <UIKit/UIKit.h>
#import "EditTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoneTableViewController : UITableViewController<EditTask,UISearchBarDelegate>

@end

NS_ASSUME_NONNULL_END
