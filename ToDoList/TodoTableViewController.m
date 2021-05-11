//
//  TodoTableViewController.m
//  ToDoList
//
//  Created by Moataz on 05/04/2021.
//

#import "TodoTableViewController.h"
#import "ViewController.h"
#import "EditViewController.h"
#import "Task.h"
#import "EditViewController.h"

@interface TodoTableViewController (){
    NSMutableArray<Task*> *tasksArray;
    NSMutableArray<Task*> *tasksToDoArray;
    NSUserDefaults *defaults;
    BOOL isFiltered;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation TodoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isFiltered = false;
    _searchBar.delegate = self;
    defaults = [NSUserDefaults standardUserDefaults];
    [self loadArrays];
    [self updateArray];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    printf("search method");
    if (searchText.length==0) {
        isFiltered = false;
        [self updateArray];
    }else{
        isFiltered = true;
        printf("search method");
        [tasksToDoArray removeAllObjects];
        for (int i =0; i<[tasksArray count]; i++) {
            Task *myTask = [tasksArray objectAtIndex:i];
            NSRange nameRange = [myTask.title rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (nameRange.location != NSNotFound) {
                [tasksToDoArray addObject:myTask];
            }
        }
        [self.tableView reloadData];
    }
}

-(void)loadArrays{
    NSData *readData = [defaults objectForKey:@"tasksArray"];
    tasksArray = [NSKeyedUnarchiver unarchiveObjectWithData:readData];
   if ([tasksArray count]==0) {
        tasksArray = [NSMutableArray new];
    }
}

-(void)updateArray{
    tasksToDoArray = [NSMutableArray new];
    for (int i = 0; i < [tasksArray count]; i++) {
        Task *task = [tasksArray objectAtIndex:i];
        if ([task state]==0) {
            [tasksToDoArray addObject:task];
        }
    }
    [self.tableView reloadData];
}

-(void)saveData{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tasksArray];
    [defaults setObject:data forKey:@"tasksArray"];
    [defaults synchronize];
}

- (void)addTask:(Task*)task{
//    printf("hello %s %s %d %s  \n",[task.title UTF8String],[task.tDescription UTF8String],task.priority ,[task.date.description UTF8String]);
    [self startLocalNotification:task.date :task.title];
    [tasksArray addObject:task];
//    [tasksToDoArray addObject:task];
    [self updateArray];
    printf("all array count %d\n",[tasksArray count]);
    [self saveData];
    [self.tableView reloadData];
}

- (void)editTask:(Task *)task :(int)position{
    [self loadArrays];
//    [tasksArray removeObjectAtIndex:position];
    for (int i = 0; i<[tasksArray count]; i++) {
        if (position == [tasksArray objectAtIndex:i].tid){
            [tasksArray replaceObjectAtIndex:i withObject:task];
        }
    }
//    [tasksArray addObject:task];
    [self updateArray];
    [self saveData];
}

- (IBAction)addItem:(id)sender {
    printf("task count = %d\n",[tasksArray count]);
    ViewController *addTaskScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    addTaskScreen.tid = [tasksArray lastObject].tid +1;
    addTaskScreen.addTaskProtocol = self;
    [self.navigationController pushViewController:addTaskScreen animated:YES];
}

-(void)startLocalNotification :(NSDate*) date : (NSString*) title {
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = date;
    notification.alertBody = title;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber = 10;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

#pragma mark - Table view data source

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Task *task = [tasksToDoArray objectAtIndex:indexPath.row];
//        int tid = task.tid;
//        for (int i = 0; i<[tasksArray count]; i++) {
//            if ([tasksArray objectAtIndex:i].tid==tid) {
//                [tasksArray removeObjectAtIndex:i];
//            }
//        }
        [tasksArray removeObject:task];
        [tasksToDoArray removeObjectAtIndex:indexPath.row];
        [self saveData];
        [tableView reloadData]; // tell table to refresh now
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditViewController *editScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];
    Task *editTask = [tasksToDoArray objectAtIndex:indexPath.row];
    editScreen.task = editTask;
//    editScreen.objectNumber = indexPath.row;
    editScreen.objectNumber = editTask.tid;
    printf("all array count %d task no %d\n",[tasksArray count],editTask.tid);
    editScreen.editTaskProtocol = self;
    [self.navigationController pushViewController:editScreen animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [tasksToDoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Task *task = [tasksToDoArray objectAtIndex:indexPath.row];
    IBOutlet UILabel *taskTitle = [cell viewWithTag:1];
    taskTitle.text = task.title;
    IBOutlet UILabel *taskPriority = [cell viewWithTag:2];
    UIView *priorityCircle = [cell viewWithTag:3];
    switch (task.priority) {
        case 0:
            taskPriority.text = @"L";
            priorityCircle.backgroundColor = [UIColor yellowColor];
            break;
        case 1:
            taskPriority.text = @"M";
            priorityCircle.backgroundColor = [UIColor orangeColor];
            break;
        case 2:
            taskPriority.text = @"H";
            priorityCircle.backgroundColor = [UIColor redColor];
            break;
        default:
            break;
    }
    priorityCircle.layer.cornerRadius = 15;
    
    return cell;
}


@end
