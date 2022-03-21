using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace howMoney.Models
{
    public class User
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public Guid Id { get; set; }

        [Required]
        [MaxLength(50, ErrorMessage = "Email is too long.")]
        public string Email { get; set; }

        [Required]
        [MaxLength(30, ErrorMessage = "Name is too long.")]
        public string Name { get; set; }

        [Required]
        [MaxLength(30, ErrorMessage = "Surname is too long.")]
        public string Surname { get; set; }

        [Required]
        [MaxLength(100, ErrorMessage = "Password is too long.")]
        public string Password { get; set; }

        [Required]
        public double Sum { get; set; }

        [Required]
        [MaxLength(30, ErrorMessage = "Currency preference is too long.")]
        public string CurrencyPreference { get; set; }

        public ICollection<UserAsset> UserAssets { get; set; }
    }
}
