namespace Backend.Services
{
    public interface ITaskService
    {
        Task<TaskItem> AddTaskAsync(AddTaskDto dto);
        Task<TaskItem> DeleteTaskAsync(int id);
        Task<TaskItem> MarkTaskAsCompletedAsync(int id);
        Task<TaskItem> EditTaskAsync(AddTaskDto dto , int id);

    }
}
