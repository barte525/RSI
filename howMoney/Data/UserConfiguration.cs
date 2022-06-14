using System;
using howMoney.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace howMoney.Data
{
    internal class UserConfiguration : IEntityTypeConfiguration<User>
    {
        private const string TableName = "User";
        public void Configure(EntityTypeBuilder<User> builder)
        {
            builder.ToTable(TableName);
            builder.HasKey(x => x.Id);

            builder.Property(x => x.Id)
                .HasColumnName("Id")
                .HasColumnType("uuid")
                .HasDefaultValueSql("uuid_generate_v4()")
                .IsRequired();

            builder.HasIndex(x => x.Id)
                .IsUnique();

            builder.Property(x => x.Email)
                .HasColumnName("Email")
                .HasColumnType("varchar(50)")
                .HasMaxLength(50);

            builder.HasIndex(x => x.Email)
                .IsUnique();

            builder.Property(x => x.Name)
                .HasColumnName("Name")
                .HasColumnType("varchar(30)")
                .HasMaxLength(30);

            builder.Property(x => x.Surname)
                .HasColumnName("Surname")
                .HasColumnType("varchar(30)")
                .HasMaxLength(30);

            builder.Property(x => x.PasswordHash)
                .HasColumnName("PasswordHash")
                .HasColumnType("varchar(255)")
                .HasMaxLength(255);

            builder.Property(x => x.PasswordSalt)
               .HasColumnName("PasswordSalt")
               .HasColumnType("varchar(255)")
               .HasMaxLength(255);

            builder.Property(x => x.CurrencyPreference)
                .HasColumnName("CurrencyPreferences")
                .HasColumnType("varchar(30)")
                .HasMaxLength(30);
        }
    }
}
