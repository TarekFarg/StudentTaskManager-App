
using Backend.Models;
using Microsoft.EntityFrameworkCore;
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
        public async Task<TaskResponseDto> AddTaskAsync(AddTaskDto dto)
        {
            // check student exists
            var student = await _context.Students.FindAsync(dto.UserId);
            if (student == null)
                throw new Exception("Student not found");

            var task = new TaskItem
            {
                Title = dto.Title,
                Description = dto.Description,
                DueDate = dto.DueDate,
                Priority = dto.Priority,
                StudentId = dto.UserId
            };

            _context.TaskItems.Add(task);
            await _context.SaveChangesAsync();

            var taskRespone = new TaskResponseDto
            {
                Id = task.Id,
                Title = task.Title,
                Description = task.Description,
                DueDate = task.DueDate,
                Priority = task.Priority,
                IsCompleted = task.IsCompleted,
                IsFavorite = task.IsFavorite
            };

            return taskRespone;
        }

        public async Task<TaskResponseDto> DeleteTaskAsync(int id)
        {
            var task = await _context.TaskItems.FindAsync(id);
            if (task == null)
                throw new Exception("Task not found");

            

            _context.TaskItems.Remove(task);
            await _context.SaveChangesAsync();

            var taskRespone = new TaskResponseDto
            {
                Id = task.Id,
                Title = task.Title,
                Description = task.Description,
                DueDate = task.DueDate,
                Priority = task.Priority,
                IsCompleted = task.IsCompleted,
                IsFavorite = task.IsFavorite
            };

            return taskRespone;
        }

        public async Task<TaskResponseDto> EditTaskAsync(AddTaskDto dto , int id)
        {
            var task = await _context.TaskItems.FindAsync(id);
            if (task == null)
                throw new Exception("Task not found");


            task.Title = dto.Title;
            task.Description = dto.Description;
            task.DueDate = dto.DueDate;
            task.Priority = dto.Priority;
            task.StudentId = dto.UserId;

            _context.TaskItems.Update(task);
            await _context.SaveChangesAsync();

            var taskRespone = new TaskResponseDto
            {
                Id = task.Id,
                Title = task.Title,
                Description = task.Description,
                DueDate = task.DueDate,
                Priority = task.Priority,
                IsCompleted = task.IsCompleted,
                IsFavorite = task.IsFavorite
            };

            return taskRespone;
        }

        public async Task<TaskResponseDto> GetTaskByTaskIdAsync(int taskId)
        {
            var task = await _context.TaskItems.FindAsync(taskId);
            if (task == null)
                throw new Exception("Task not found");

            var taskRespone = new TaskResponseDto
            {
                Id = task.Id,
                Title = task.Title,
                Description = task.Description,
                DueDate = task.DueDate,
                Priority = task.Priority,
                IsCompleted = task.IsCompleted,
                IsFavorite = task.IsFavorite
            };
            return taskRespone;

        }

        public async Task<List<TaskResponseDto>> GetTasksByStudentAsync(int studentId)
        {
            var tasks = await _context.TaskItems
                .Where(t => t.StudentId == studentId)
                .Select(t => new TaskResponseDto
                {
                    Id = t.Id,
                    Title = t.Title,
                    Description = t.Description,
                    DueDate = t.DueDate,
                    Priority = t.Priority,
                    IsCompleted = t.IsCompleted,
                    IsFavorite = t.IsFavorite
                })
                .ToListAsync();

            return tasks;
        }

        public async Task<TaskResponseDto> MarkTaskAsCompletedAsync(int id)
        {
            var task = await _context.TaskItems.FindAsync(id);
            if (task == null)
                throw new Exception("Task not found");

            task.IsCompleted = true;

            

            _context.TaskItems.Update(task);
            await _context.SaveChangesAsync();

            var taskRespone = new TaskResponseDto
            {
                Id = task.Id,
                Title = task.Title,
                Description = task.Description,
                DueDate = task.DueDate,
                Priority = task.Priority,
                IsCompleted = task.IsCompleted,
                IsFavorite = task.IsFavorite
            };
            return taskRespone;
        }

        public async Task<TaskResponseDto> MarkAsFavorite(int taskId)
        {
            var task = await _context.TaskItems.FindAsync(taskId);

            if (task == null)
                throw new Exception("Task not found");

            task.IsFavorite = true;

            await _context.SaveChangesAsync();

            var taskRespone = new TaskResponseDto
            {
                Id = task.Id,
                Title = task.Title,
                Description = task.Description,
                DueDate = task.DueDate,
                Priority = task.Priority,
                IsCompleted = task.IsCompleted,
                IsFavorite = task.IsFavorite
            };
            return taskRespone;
        }

        public async Task<TaskResponseDto> RemoveFromFavorite(int taskId)
        {
            var task = await _context.TaskItems.FindAsync(taskId);

            if (task == null)
                throw new Exception("Task not found");

            task.IsFavorite = false;

            await _context.SaveChangesAsync();

            var taskRespone = new TaskResponseDto
            {
                Id = task.Id,
                Title = task.Title,
                Description = task.Description,
                DueDate = task.DueDate,
                Priority = task.Priority,
                IsCompleted = task.IsCompleted,
                IsFavorite = task.IsFavorite
            };
            return taskRespone;
        }
    }
}
