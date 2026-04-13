using System.ComponentModel.DataAnnotations;

public class AddTaskDto
{
    [Required]
    public string Title { get; set; }

    public string? Description { get; set; }

    [Required]
    public DateTime DueDate { get; set; }

    [Required]
    public string Priority { get; set; } 

    [Required]
    public int StudentId { get; set; }
}