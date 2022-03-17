using System;
using System.ComponentModel.DataAnnotations;

namespace howMoney
{
    public class Asset
    {
       [Key]
       public int Id { get; set; }
       public string Type { get; set; }
    }
}
