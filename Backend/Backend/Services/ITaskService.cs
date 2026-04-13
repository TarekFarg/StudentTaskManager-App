namespace Backend.Services
{
    public interface ITaskService
    {
        Task<TaskResponseDto> AddTaskAsync(AddTaskDto dto);
        Task<TaskResponseDto> DeleteTaskAsync(int id);
        Task<TaskResponseDto> MarkTaskAsCompletedAsync(int id);
        Task<TaskResponseDto> EditTaskAsync(AddTaskDto dto , int id);

    }
}
