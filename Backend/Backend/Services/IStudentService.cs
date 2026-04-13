using Backend.Dtos;

namespace Backend.Services
{
    public interface IStudentService
    {
        Task<string> SignUpAsync(StudentDto dto);
        Task<StudentProfileDto> LoginAsync(LoginDto dto);
        Task<StudentProfileDto> GetProfileAsync(int studentId);
    }
}
