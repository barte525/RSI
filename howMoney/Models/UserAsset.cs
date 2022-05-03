using System;
using System.ComponentModel.DataAnnotations;

namespace howMoney.Models
{
    public class UserAsset
    {
        public Guid UserId { get; set; }

        public Guid AssetId { get; set; }

        [Required]
        public double Amount { get; set; }
    }
}
