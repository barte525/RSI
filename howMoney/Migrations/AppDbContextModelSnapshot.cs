﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;
using howMoney.Data;

namespace howMoney.Migrations
{
    [DbContext(typeof(AppDbContext))]
    partial class AppDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasPostgresExtension("uuid-ossp")
                .HasAnnotation("Relational:MaxIdentifierLength", 63)
                .HasAnnotation("ProductVersion", "5.0.15")
                .HasAnnotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

            modelBuilder.Entity("howMoney.Models.Asset", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid")
                        .HasColumnName("Id")
                        .HasDefaultValueSql("uuid_generate_v4()");

                    b.Property<double>("ConverterEUR")
                        .HasColumnType("double precision")
                        .HasColumnName("ConverterEUR");

                    b.Property<double>("ConverterPLN")
                        .HasColumnType("double precision")
                        .HasColumnName("ConverterPLN");

                    b.Property<double>("ConverterUSD")
                        .HasColumnType("double precision")
                        .HasColumnName("ConverterUSD");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(30)
                        .HasColumnType("varchar(30)")
                        .HasColumnName("Name");

                    b.Property<string>("Type")
                        .IsRequired()
                        .HasMaxLength(30)
                        .HasColumnType("varchar(30)")
                        .HasColumnName("Type");

                    b.HasKey("Id");

                    b.HasIndex("Id")
                        .IsUnique();

                    b.ToTable("Asset");

                    b.HasData(
                        new
                        {
                            Id = new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa9"),
                            ConverterEUR = 100000.25,
                            ConverterPLN = 500000.25,
                            ConverterUSD = 110000.25,
                            Name = "BTC",
                            Type = "crypto"
                        },
                        new
                        {
                            Id = new Guid("4fa85f64-5717-4562-b3fc-2c963f66afa9"),
                            ConverterEUR = 10.0,
                            ConverterPLN = 50.0,
                            ConverterUSD = 11.0,
                            Name = "ETH",
                            Type = "crypto"
                        },
                        new
                        {
                            Id = new Guid("5fa85f64-5717-4562-b3fc-2c963f66afa9"),
                            ConverterEUR = 120.0,
                            ConverterPLN = 600.0,
                            ConverterUSD = 130.0,
                            Name = "GOLD",
                            Type = "metal"
                        },
                        new
                        {
                            Id = new Guid("6fa85f64-5717-4562-b3fc-2c963f66afa9"),
                            ConverterEUR = 9.0,
                            ConverterPLN = 45.0,
                            ConverterUSD = 10.0,
                            Name = "SILVER",
                            Type = "metal"
                        },
                        new
                        {
                            Id = new Guid("7fa85f64-5717-4562-b3fc-2c963f66afa9"),
                            ConverterEUR = 0.22,
                            ConverterPLN = 1.0,
                            ConverterUSD = 0.20000000000000001,
                            Name = "PLN",
                            Type = "currency"
                        },
                        new
                        {
                            Id = new Guid("8fa85f64-5717-4562-b3fc-2c963f66afa9"),
                            ConverterEUR = 0.90000000000000002,
                            ConverterPLN = 4.2000000000000002,
                            ConverterUSD = 1.0,
                            Name = "USD",
                            Type = "currency"
                        },
                        new
                        {
                            Id = new Guid("9fa85f64-5717-4562-b3fc-2c963f66afa9"),
                            ConverterEUR = 1.0,
                            ConverterPLN = 4.9000000000000004,
                            ConverterUSD = 1.1200000000000001,
                            Name = "EUR",
                            Type = "currency"
                        },
                        new
                        {
                            Id = new Guid("2fa85f64-5717-4562-b3fc-2c963f66afa9"),
                            ConverterEUR = 0.90000000000000002,
                            ConverterPLN = 0.14999999999999999,
                            ConverterUSD = 0.80000000000000004,
                            Name = "GBP",
                            Type = "currency"
                        });
                });

            modelBuilder.Entity("howMoney.Models.User", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid")
                        .HasColumnName("Id")
                        .HasDefaultValueSql("uuid_generate_v4()");

                    b.Property<string>("CurrencyPreference")
                        .IsRequired()
                        .HasMaxLength(30)
                        .HasColumnType("varchar(30)")
                        .HasColumnName("CurrencyPreferences");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("varchar(50)")
                        .HasColumnName("Email");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(30)
                        .HasColumnType("varchar(30)")
                        .HasColumnName("Name");

                    b.Property<string>("PasswordHash")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("varchar(255)")
                        .HasColumnName("PasswordHash");

                    b.Property<string>("PasswordSalt")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("varchar(255)")
                        .HasColumnName("PasswordSalt");

                    b.Property<string>("Surname")
                        .IsRequired()
                        .HasMaxLength(30)
                        .HasColumnType("varchar(30)")
                        .HasColumnName("Surname");

                    b.HasKey("Id");

                    b.HasIndex("Email")
                        .IsUnique();

                    b.HasIndex("Id")
                        .IsUnique();

                    b.ToTable("User");

                    b.HasData(
                        new
                        {
                            Id = new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"),
                            CurrencyPreference = "EUR",
                            Email = "bartek@gmail.com",
                            Name = "Bartek",
                            PasswordHash = "UbN/VoI/974MZ9iTx0gV+TVUbZHK745jzU51suahhOIXFA/OKK2+/Nwfeno/SbJGjAkyZAZnG7nOW5GV99aR+A==",
                            PasswordSalt = "9eII7vkhEcnJwaFRAkv6Wvq1h0uIol+pMwgNQkE5ooLL9eBK+vf8GinvN0LVxfy8dOkem2Z76yl/DtcGd94vZGQ8lJFAy1z+Xt9jWP/amZQbhU3t1SnUrwQGtTd5LZ0bCQcKqtMBbWoGOb7lnJiJLZ+oXtK9SgMMgFJICgWiAZo=",
                            Surname = "Nowak"
                        },
                        new
                        {
                            Id = new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa7"),
                            CurrencyPreference = "USD",
                            Email = "ola@gmail.com",
                            Name = "Ola",
                            PasswordHash = "UbN/VoI/974MZ9iTx0gV+TVUbZHK745jzU51suahhOIXFA/OKK2+/Nwfeno/SbJGjAkyZAZnG7nOW5GV99aR+A==",
                            PasswordSalt = "9eII7vkhEcnJwaFRAkv6Wvq1h0uIol+pMwgNQkE5ooLL9eBK+vf8GinvN0LVxfy8dOkem2Z76yl/DtcGd94vZGQ8lJFAy1z+Xt9jWP/amZQbhU3t1SnUrwQGtTd5LZ0bCQcKqtMBbWoGOb7lnJiJLZ+oXtK9SgMMgFJICgWiAZo=",
                            Surname = "Generowicz"
                        },
                        new
                        {
                            Id = new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa8"),
                            CurrencyPreference = "PLN",
                            Email = "martyna@gmail.com",
                            Name = "Martyna",
                            PasswordHash = "UbN/VoI/974MZ9iTx0gV+TVUbZHK745jzU51suahhOIXFA/OKK2+/Nwfeno/SbJGjAkyZAZnG7nOW5GV99aR+A==",
                            PasswordSalt = "9eII7vkhEcnJwaFRAkv6Wvq1h0uIol+pMwgNQkE5ooLL9eBK+vf8GinvN0LVxfy8dOkem2Z76yl/DtcGd94vZGQ8lJFAy1z+Xt9jWP/amZQbhU3t1SnUrwQGtTd5LZ0bCQcKqtMBbWoGOb7lnJiJLZ+oXtK9SgMMgFJICgWiAZo=",
                            Surname = "Grzegorczyk"
                        });
                });

            modelBuilder.Entity("howMoney.Models.UserAsset", b =>
                {
                    b.Property<Guid>("UserId")
                        .HasColumnType("uuid");

                    b.Property<Guid>("AssetId")
                        .HasColumnType("uuid");

                    b.Property<double>("Amount")
                        .HasColumnType("double precision");

                    b.HasKey("UserId", "AssetId");

                    b.ToTable("UserAssets");

                    b.HasData(
                        new
                        {
                            UserId = new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"),
                            AssetId = new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa9"),
                            Amount = 0.00020000000000000001
                        },
                        new
                        {
                            UserId = new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"),
                            AssetId = new Guid("4fa85f64-5717-4562-b3fc-2c963f66afa9"),
                            Amount = 100.0
                        },
                        new
                        {
                            UserId = new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"),
                            AssetId = new Guid("5fa85f64-5717-4562-b3fc-2c963f66afa9"),
                            Amount = 11.0
                        },
                        new
                        {
                            UserId = new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"),
                            AssetId = new Guid("6fa85f64-5717-4562-b3fc-2c963f66afa9"),
                            Amount = 10040.219999999999
                        },
                        new
                        {
                            UserId = new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"),
                            AssetId = new Guid("7fa85f64-5717-4562-b3fc-2c963f66afa9"),
                            Amount = 500.0
                        },
                        new
                        {
                            UserId = new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"),
                            AssetId = new Guid("8fa85f64-5717-4562-b3fc-2c963f66afa9"),
                            Amount = 1100.5
                        },
                        new
                        {
                            UserId = new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"),
                            AssetId = new Guid("9fa85f64-5717-4562-b3fc-2c963f66afa9"),
                            Amount = 0.02
                        },
                        new
                        {
                            UserId = new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"),
                            AssetId = new Guid("2fa85f64-5717-4562-b3fc-2c963f66afa9"),
                            Amount = 100.11
                        },
                        new
                        {
                            UserId = new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa8"),
                            AssetId = new Guid("7fa85f64-5717-4562-b3fc-2c963f66afa9"),
                            Amount = 0.02
                        },
                        new
                        {
                            UserId = new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa8"),
                            AssetId = new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa9"),
                            Amount = 100.0
                        });
                });
#pragma warning restore 612, 618
        }
    }
}
