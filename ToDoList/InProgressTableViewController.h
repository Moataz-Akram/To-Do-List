//
//  InProgressTableViewController.h
//  ToDoList
//
//  Created by Moataz on 05/04/2021.
//

#import <UIKit/UIKit.h>
#import "EditTask.h"
NS_ASSUME_NONNULL_BEGIN

@interface InProgressTableViewController : UITableViewController <EditTask,UISearchBarDelegate, UITabBarControllerDelegate>

@end

NS_ASSUME_NONNULL_END
