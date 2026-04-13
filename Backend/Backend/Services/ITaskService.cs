namespace Backend.Services
{
    public interface ITaskService
    {
        Task<TaskItem> AddTaskAsync(AddTaskDto dto);
    }
}
