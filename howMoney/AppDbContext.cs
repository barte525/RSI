using System;
using Microsoft.EntityFrameworkCore;

namespace howMoney
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {

        }

        public DbSet<Asset> Assets { get; set; }
}
}
