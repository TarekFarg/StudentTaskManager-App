using Backend.Dtos;

namespace Backend.Services
{
    public interface IStudentService
    {
        Task<string> SignUpAsync(SignUpDto dto);
    }
}
