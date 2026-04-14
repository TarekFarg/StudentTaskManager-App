using Backend.Dtos;
using Backend.Services;
using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StudentController : Controller
    {
        private readonly IStudentService _studentService;

        public StudentController(IStudentService studentService)
        {
            _studentService = studentService;
        }

        [HttpPost("signup")]
        public async Task<IActionResult> SignUp(StudentDto dto)
        {
            var result = await _studentService.SignUpAsync(dto);
            return Ok(new { message = result });
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login(LoginDto dto)
        {
            try
            {
                var user = await _studentService.LoginAsync(dto);
                return Ok(user);
            }
            catch (Exception ex)
            {
                return Unauthorized(new { message = ex.Message });
            }
        }

        [HttpGet("profile/{id}")]
        public async Task<IActionResult> GetProfile(int id)
        {
            var profile = await _studentService.GetProfileAsync(id);
            return Ok(profile);
        }

        [HttpPut("profile/{id}")]
        public async Task<IActionResult> UpdateProfile(int id, UpdateProfileDto dto)
        {
            var result = await _studentService.UpdateProfileAsync(id, dto);
            return Ok(new { message = result });
        }
    }
}
