
using Backend.Models;
using System;

namespace Backend.Services
{
    public class TaskService : ITaskService
    {
        private readonly ApplicationDbContext _context;

        public TaskService(ApplicationDbContext context)
        {
            _context = context;
        }
        public async Task<TaskItem> AddTaskAsync(AddTaskDto dto)
        {
            // check student exists
            var student = await _context.Students.FindAsync(dto.StudentId);
            if (student == null)
                throw new Exception("Student not found");

            var task = new TaskItem
            {
                Title = dto.Title,
                Description = dto.Description,
                DueDate = dto.DueDate,
                Priority = dto.Priority,
                StudentId = dto.StudentId
            };

            _context.TaskItems.Add(task);
            await _context.SaveChangesAsync();

            return task;
        }
    }
}
