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

        public async Task<string> UpdateProfileAsync(int studentId, UpdateProfileDto dto)
        {
            var student = await _context.Students.FindAsync(studentId);
            if (student == null)
                return "Student not found";

            student.FullName = dto.FullName ?? student.FullName;
            student.Gender = dto.Gender ?? student.Gender;
            student.AcademicLevel = dto.AcademicLevel ?? student.AcademicLevel;
            student.ProfileImagePath = dto.ProfileImagePath ?? student.ProfileImagePath;

            await _context.SaveChangesAsync();

            return "Profile Updated";
        }

        public async Task<StudentProfileDto> GetProfileAsync(int studentId)
        {
            var student = await _context.Students.FindAsync(studentId);
            if (student == null)
                throw new Exception("Student not found");

            return new StudentProfileDto
            {
                Id = student.Id,
                FullName = student.FullName,
                Email = student.Email,
                StudentId = student.StudentId,
                Gender = student.Gender,
                AcademicLevel = student.AcademicLevel,
                ProfileImagePath = student.ProfileImagePath
            };
        }

        public async Task<StudentProfileDto> LoginAsync(LoginDto dto)
        {
            var student = await _context.Students
            .FirstOrDefaultAsync(x => x.Email == dto.Email);

            if (student == null || student.PasswordHash != dto.Password)
                throw new Exception("Invalid email or password");

            return new StudentProfileDto
            {
                Id = student.Id,
                FullName = student.FullName,
                Email = student.Email,
                StudentId = student.StudentId,
                Gender = student.Gender,
                AcademicLevel = student.AcademicLevel,
                ProfileImagePath = student.ProfileImagePath
            };
        }

        public async Task<string> SignUpAsync(StudentDto dto)
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
                PasswordHash = dto.Password 
            };

            _context.Students.Add(student);
            await _context.SaveChangesAsync();

            return "Signup Success";
        }
    }
}
