//
//  Task.h
//  ToDoList
//
//  Created by Moataz on 05/04/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject<NSCoding>

@property NSString *title, *tDescription;
@property int priority, tid, state;
@property NSDate *date;
@end

NS_ASSUME_NONNULL_END
