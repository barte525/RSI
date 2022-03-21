using System;
using System.ComponentModel.DataAnnotations;

namespace howMoney.Models
{
    public class UserAsset
    {
        public Guid UserId { get; set; }
        public User User { get; set; }

        public Guid AssetId { get; set; }
        public Asset Asset { get; set; }

        [Required]
        public double Amount { get; set; }
    }
}
