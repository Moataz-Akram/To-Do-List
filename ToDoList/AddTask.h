//
//  AddTask.h
//  ToDoList
//
//  Created by Moataz on 05/04/2021.
//

#import <Foundation/Foundation.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AddTask <NSObject>
-(void)addTask : (Task*) task;
@end

NS_ASSUME_NONNULL_END
