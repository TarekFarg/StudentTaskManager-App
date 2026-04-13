
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

        public async Task<TaskItem> DeleteTaskAsync(int id)
        {
            var task = await _context.TaskItems.FindAsync(id);
            if (task == null)
                throw new Exception("Task not found");

            _context.TaskItems.Remove(task);
            await _context.SaveChangesAsync();
            return task;
        }
    }
}
