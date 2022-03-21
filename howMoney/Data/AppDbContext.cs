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
        public DbSet<User> Users { get; set; }
        public DbSet<UserAsset> UserAssets { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.HasPostgresExtension("uuid-ossp");
            modelBuilder.ApplyConfiguration(new AssetConfiguration());
            modelBuilder.ApplyConfiguration(new UserConfiguration());

            modelBuilder.Entity<UserAsset>()
                .HasKey(ua => new { ua.UserId, ua.AssetId });
            modelBuilder.Entity<UserAsset>()
                .HasOne(ua => ua.User)
                .WithMany(u => u.UserAssets)
                .HasForeignKey(ua => ua.UserId);
            modelBuilder.Entity<UserAsset>()
                .HasOne(ua => ua.Asset)
                .WithMany(u => u.UserAssets)
                .HasForeignKey(ua => ua.AssetId);
        }
    }
}
