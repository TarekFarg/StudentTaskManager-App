using Backend.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TasksController : ControllerBase
    {
        private readonly ITaskService _taskService;

        public TasksController(ITaskService taskService)
        {
            _taskService = taskService;
        }

        [HttpGet("{taskId}")]
        public async Task<IActionResult> GetTaskByTaskId(int taskId)
        {
            try
            {
                var task = await _taskService.GetTaskByTaskIdAsync(taskId);
                return Ok(task);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpPost]
        public async Task<IActionResult> AddTask(AddTaskDto dto)
        {
            try
            {
                var task = await _taskService.AddTaskAsync(dto);
                return Ok(task);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTask(int id)
        {
            try
            {
                var task = await _taskService.DeleteTaskAsync(id);
                return Ok(task);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpPut("Edit/{id}")]
        public async Task<IActionResult> EditTask([FromBody] AddTaskDto dto, int id)
        {
            try
            {
                var task = await _taskService.EditTaskAsync(dto, id);
                return Ok(task);
            }
            catch (Exception ex)
            {
                return BadRequest(new { massage = ex.Message });
            }
        }

        [HttpPut("MarkAsCompleted/{id}")]
        public async Task<IActionResult> MarkTaskAsCompleted(int id)
        {
            try
            {
                var task = await _taskService.MarkTaskAsCompletedAsync(id);
                return Ok(task);
            }
            catch (Exception ex)
            {
                return BadRequest(new { massage = ex.Message });
            }
        }
    }
}
