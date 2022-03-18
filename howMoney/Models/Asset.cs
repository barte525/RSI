using System;
using System.ComponentModel.DataAnnotations;

namespace howMoney.Models
{
    public class Asset
    {
       [Key]
       public int Id { get; set; }
       public string Type { get; set; }
    }
}
