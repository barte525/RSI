using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace howMoney.Models
{
    public class Asset
    {
       [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
       public Guid Id { get; set; }

       [Required]
       [MaxLength(30, ErrorMessage = "Type is too long.")]
       public string Type { get; set; }

       [Required]
       [MaxLength(30, ErrorMessage = "Name is too long.")]
       public string Name { get; set; }

       [Required]
       public double ConverterPLN { get; set; }

       [Required]
       public double ConverterEUR { get; set; }

       [Required]
       public double ConverterUSD { get; set; }

       public ICollection<UserAsset> UserAssets { get; set; }
    }
}
