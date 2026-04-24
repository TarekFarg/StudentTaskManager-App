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
    public int UserId { get; set; }
}

public class TaskResponseDto
{
    public int Id { get; set; }
    public string Title { get; set; }
    public string? Description { get; set; }
    public DateTime DueDate { get; set; }
    public string Priority { get; set; }
    public bool IsCompleted { get; set; }
    public bool IsFavorite { get; set; }
}