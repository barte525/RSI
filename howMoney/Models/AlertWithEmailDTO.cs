﻿namespace howMoney.Models
{
    public class AlertWithEmailDTO
    {
        public string email { get; set; } = string.Empty;
        public string asset_name { get; set; } = string.Empty;
        public string currency { get; set; } = string.Empty;
        public double value { get; set; } = 0.0;

        public AlertWithEmailDTO()
        {

        }
    }
}
