using System.ComponentModel.DataAnnotations;

public class Student
{
    public int Id { get; set; }

    [Required]
    public string FullName { get; set; }

    public string? Gender { get; set; } // Male / Female

    [Required]
    [EmailAddress]
    public string Email { get; set; }

    [Required]
    public string StudentId { get; set; }

    public int? AcademicLevel { get; set; } // 1,2,3,4

    [Required]
    public string PasswordHash { get; set; }

    public string? ProfileImagePath { get; set; }

    // Navigation Property
    public List<TaskItem> Tasks { get; set; } = new List<TaskItem>();
}