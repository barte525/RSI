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

            modelBuilder.Entity<User>().HasData(
                new User
                {
                    Id = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa6"),
                    Email = "bartek@gmail.com",
                    Name = "Bartek",
                    Surname = "Nowak",
                    PasswordHash = "UbN/VoI/974MZ9iTx0gV+TVUbZHK745jzU51suahhOIXFA/OKK2+/Nwfeno/SbJGjAkyZAZnG7nOW5GV99aR+A==",
                    PasswordSalt = "9eII7vkhEcnJwaFRAkv6Wvq1h0uIol+pMwgNQkE5ooLL9eBK+vf8GinvN0LVxfy8dOkem2Z76yl/DtcGd94vZGQ8lJFAy1z+Xt9jWP/amZQbhU3t1SnUrwQGtTd5LZ0bCQcKqtMBbWoGOb7lnJiJLZ+oXtK9SgMMgFJICgWiAZo=",
                    Sum = 0,
                    CurrencyPreference = "EUR"
                },
                new User
                {
                    Id = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa7"),
                    Email = "ola@gmail.com",
                    Name = "Ola",
                    Surname = "Generowicz",
                    PasswordHash = "UbN/VoI/974MZ9iTx0gV+TVUbZHK745jzU51suahhOIXFA/OKK2+/Nwfeno/SbJGjAkyZAZnG7nOW5GV99aR+A==",
                    PasswordSalt = "9eII7vkhEcnJwaFRAkv6Wvq1h0uIol+pMwgNQkE5ooLL9eBK+vf8GinvN0LVxfy8dOkem2Z76yl/DtcGd94vZGQ8lJFAy1z+Xt9jWP/amZQbhU3t1SnUrwQGtTd5LZ0bCQcKqtMBbWoGOb7lnJiJLZ+oXtK9SgMMgFJICgWiAZo=",
                    Sum = 0,
                    CurrencyPreference = "USD"
                },
                new User
                {
                    Id = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa8"),
                    Email = "martyna@gmail.com",
                    Name = "Martyna",
                    Surname = "Grzegorczyk",
                    PasswordHash = "UbN/VoI/974MZ9iTx0gV+TVUbZHK745jzU51suahhOIXFA/OKK2+/Nwfeno/SbJGjAkyZAZnG7nOW5GV99aR+A==",
                    PasswordSalt = "9eII7vkhEcnJwaFRAkv6Wvq1h0uIol+pMwgNQkE5ooLL9eBK+vf8GinvN0LVxfy8dOkem2Z76yl/DtcGd94vZGQ8lJFAy1z+Xt9jWP/amZQbhU3t1SnUrwQGtTd5LZ0bCQcKqtMBbWoGOb7lnJiJLZ+oXtK9SgMMgFJICgWiAZo=",
                    Sum = 0,
                    CurrencyPreference = "PLN"
                }
            );
            modelBuilder.Entity<Asset>().HasData(
                new Asset { Id = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa9"), Type = "crypto", Name = "BTC", ConverterEUR=100000.25, ConverterPLN= 500000.25, ConverterUSD= 110000.25 },
                new Asset { Id = Guid.Parse("4fa85f64-5717-4562-b3fc-2c963f66afa9"), Type = "crypto", Name = "ETH", ConverterEUR = 10, ConverterPLN = 50, ConverterUSD = 11 },
                new Asset { Id = Guid.Parse("5fa85f64-5717-4562-b3fc-2c963f66afa9"), Type = "metal", Name = "GOLD", ConverterEUR = 120, ConverterPLN = 600, ConverterUSD = 130 },
                new Asset { Id = Guid.Parse("6fa85f64-5717-4562-b3fc-2c963f66afa9"), Type = "metal", Name = "SILVER", ConverterEUR = 9, ConverterPLN = 45, ConverterUSD = 10 },
                new Asset { Id = Guid.Parse("7fa85f64-5717-4562-b3fc-2c963f66afa9"), Type = "currency", Name = "PLN", ConverterEUR = 0.22, ConverterPLN = 1, ConverterUSD = 0.2 },
                new Asset { Id = Guid.Parse("8fa85f64-5717-4562-b3fc-2c963f66afa9"), Type = "currency", Name = "USD", ConverterEUR = 0.9, ConverterPLN = 4.2, ConverterUSD = 1 },
                new Asset { Id = Guid.Parse("9fa85f64-5717-4562-b3fc-2c963f66afa9"), Type = "currency", Name = "EUR", ConverterEUR = 1, ConverterPLN = 4.9, ConverterUSD = 1.12 },
                new Asset { Id = Guid.Parse("2fa85f64-5717-4562-b3fc-2c963f66afa9"), Type = "currency", Name = "GBP", ConverterEUR = 0.9, ConverterPLN = 0.15, ConverterUSD = 0.8 }
            );
            modelBuilder.Entity<UserAsset>().HasData(
                new UserAsset { UserId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa6"), AssetId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa9"), Amount=0.0002 },
                new UserAsset { UserId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa6"), AssetId = Guid.Parse("4fa85f64-5717-4562-b3fc-2c963f66afa9"), Amount = 100 },
                new UserAsset { UserId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa6"), AssetId = Guid.Parse("5fa85f64-5717-4562-b3fc-2c963f66afa9"), Amount = 11 },
                new UserAsset { UserId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa6"), AssetId = Guid.Parse("6fa85f64-5717-4562-b3fc-2c963f66afa9"), Amount = 10040.22 },
                new UserAsset { UserId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa6"), AssetId = Guid.Parse("7fa85f64-5717-4562-b3fc-2c963f66afa9"), Amount = 500 },
                new UserAsset { UserId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa6"), AssetId = Guid.Parse("8fa85f64-5717-4562-b3fc-2c963f66afa9"), Amount = 1100.5 },
                new UserAsset { UserId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa6"), AssetId = Guid.Parse("9fa85f64-5717-4562-b3fc-2c963f66afa9"), Amount = 0.02 },
                new UserAsset { UserId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa6"), AssetId = Guid.Parse("2fa85f64-5717-4562-b3fc-2c963f66afa9"), Amount = 100.11 },
                new UserAsset { UserId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa8"), AssetId = Guid.Parse("7fa85f64-5717-4562-b3fc-2c963f66afa9"), Amount = 0.02 },
                new UserAsset { UserId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa8"), AssetId = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa9"), Amount = 100 }
            );

        }
    }
}
