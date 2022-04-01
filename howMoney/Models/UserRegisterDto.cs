using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace howMoney.Models
{
    public class UserRegisterDto
    {
        [Required]
        [MaxLength(50, ErrorMessage = "Email is too long.")]
        public string Email { get; set; } = string.Empty;

        [Required]
        [MaxLength(30, ErrorMessage = "Name is too long.")]
        public string Name { get; set; }

        [Required]
        [MaxLength(30, ErrorMessage = "Surname is too long.")]
        public string Surname { get; set; }

        [Required]
        [MaxLength(30, ErrorMessage = "Password is too long.")]
        public string Password { get; set; }


        [Required]
        [MaxLength(30, ErrorMessage = "Currency preference is too long.")]
        public string CurrencyPreference { get; set; }
    }
}
