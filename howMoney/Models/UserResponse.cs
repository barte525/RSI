using System;
namespace howMoney.Models
{
    public class UserResponse
    {
        public Guid Id { get; set; }
        public string Email { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public string CurrencyPreference { get; set; }
        public double sum { get; set; }
        public string Token { get; set; }
    }
}
