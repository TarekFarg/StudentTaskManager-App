using System.ComponentModel.DataAnnotations;

namespace Backend.Dtos
{
    public class SignUpDto
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
}
