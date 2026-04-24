using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class TaskItem
{
    public int Id { get; set; }

    [Required]
    public string Title { get; set; }

    public string? Description { get; set; }

    [Required]
    public DateTime DueDate { get; set; }

    [Required]
    public string Priority { get; set; } // Low / Medium / High

    public bool IsCompleted { get; set; } = false;

    public bool IsFavorite { get; set; } = false;

    // Foreign Key
    public int StudentId { get; set; }

    [ForeignKey("StudentId")]
    public Student Student { get; set; }
}