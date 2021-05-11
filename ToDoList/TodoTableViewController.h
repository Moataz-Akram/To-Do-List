//
//  TodoTableViewController.h
//  ToDoList
//
//  Created by Moataz on 05/04/2021.
//

#import <UIKit/UIKit.h>
#import "AddTask.h"
#import "EditTask.h"
#import <UserNotifications/UserNotifications.h>
NS_ASSUME_NONNULL_BEGIN

@interface TodoTableViewController : UITableViewController <EditTask,AddTask,UISearchBarDelegate>

@end

NS_ASSUME_NONNULL_END
