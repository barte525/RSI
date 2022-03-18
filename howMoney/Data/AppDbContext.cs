using System;
using howMoney.Models;
using Microsoft.EntityFrameworkCore;

namespace howMoney.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {

        }

        public DbSet<Asset> Assets { get; set; }
}
}
