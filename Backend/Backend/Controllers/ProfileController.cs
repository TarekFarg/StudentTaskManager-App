using Backend.Dtos;
using Backend.Services;
using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProfileController : Controller
    {
        private readonly IStudentService _studentService;

        public ProfileController(IStudentService studentService)
        {
            _studentService = studentService;
        }


        [HttpGet("{id}")]
        public async Task<IActionResult> GetProfile(int id)
        {
            var profile = await _studentService.GetProfileAsync(id);
            return Ok(profile);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateProfile(int id, UpdateProfileDto dto)
        {
            var result = await _studentService.UpdateProfileAsync(id, dto);
            return Ok(new { message = result });
        }

        [HttpPost("upload-profile-image")]
        public async Task<IActionResult> UploadProfileImage(IFormFile file)
        {
            if (file == null || file.Length == 0)
                return BadRequest("No file uploaded");

            // folder path
            var folderPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/profileImages");

            if (!Directory.Exists(folderPath))
                Directory.CreateDirectory(folderPath);

            // unique file name
            var fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);

            var filePath = Path.Combine(folderPath, fileName);

            // save file
            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await file.CopyToAsync(stream);
            }

            // return URL (important)
            var url = $"{Request.Scheme}://{Request.Host}/profileImages/{fileName}";

            return Ok(new { path = url });
        }
    }
}
