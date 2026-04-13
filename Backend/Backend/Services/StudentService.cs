using Backend.Dtos;
using Backend.Models;
using Microsoft.EntityFrameworkCore;

namespace Backend.Services
{
    public class StudentService : IStudentService
    {
        private readonly ApplicationDbContext _context;

        public StudentService(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<string> SignUpAsync(SignUpDto dto)
        {
            // check email exists
            if (await _context.Students.AnyAsync(x => x.Email == dto.Email))
                return "Email already exists";

            // check studentId matches email
            if (!dto.Email.StartsWith(dto.StudentId))
                return "StudentId must match email";

            var student = new Student
            {
                FullName = dto.FullName,
                Gender = dto.Gender,
                Email = dto.Email,
                StudentId = dto.StudentId,
                AcademicLevel = dto.AcademicLevel,
                PasswordHash = dto.Password // لاحقًا نعمل Hash
            };

            _context.Students.Add(student);
            await _context.SaveChangesAsync();

            return "Signup Success";
        }
    }
}
