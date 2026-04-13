using System.ComponentModel.DataAnnotations;

namespace Backend.Dtos
{
    public class StudentDto
    {
        [Required]
        public string FullName { get; set; }

        public string? Gender { get; set; }

        [Required]
        [EmailAddress]
        public string Email { get; set; }

        [Required]
        public string StudentId { get; set; }

        public int? AcademicLevel { get; set; }

        [Required]
        [MinLength(8)]
        public string Password { get; set; }
    }

    public class LoginDto
    {
        [Required]
        public string Email { get; set; }

        [Required]
        public string Password { get; set; }
    }

    public class StudentProfileDto
    {
        public int Id { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string StudentId { get; set; }
        public string? Gender { get; set; }
        public int? AcademicLevel { get; set; }
        public string? ProfileImagePath { get; set; }
    }

    public class UpdateProfileDto
    {
        public string FullName { get; set; }
        public string? Gender { get; set; }
        public int? AcademicLevel { get; set; }
    }
}
