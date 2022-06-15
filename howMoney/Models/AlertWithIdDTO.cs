namespace howMoney.Models
{
    public class AlertWithIdDto
    {
        public int id { get; set; } = 0;
        public string asset_name { get; set; } = string.Empty;
        public string currency { get; set; } = string.Empty;
        public double value { get; set; } = 0.0;

        public string asset_type { get; set; } = string.Empty;
    }
}
