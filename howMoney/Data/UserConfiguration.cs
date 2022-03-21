using System;
using howMoney.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace howMoney.Data
{
    internal class UserConfiguration : IEntityTypeConfiguration<User>
    {
        private const string TableName = "user";
        public void Configure(EntityTypeBuilder<User> builder)
        {
            builder.ToTable(TableName);
            builder.HasKey(x => x.Id);

            builder.Property(x => x.Id)
                .HasColumnName("id")
                .HasColumnType("uuid")
                .HasDefaultValueSql("uuid_generate_v4()")
                .IsRequired();

            builder.HasIndex(x => x.Id)
                .IsUnique();

            builder.Property(x => x.Email)
                .HasColumnName("email")
                .HasColumnType("varchar(50)")
                .HasMaxLength(50);

            builder.HasIndex(x => x.Email)
                .IsUnique();

            builder.Property(x => x.Name)
                .HasColumnName("name")
                .HasColumnType("varchar(30)")
                .HasMaxLength(30);

            builder.Property(x => x.Surname)
                .HasColumnName("surname")
                .HasColumnType("varchar(30)")
                .HasMaxLength(30);

            builder.Property(x => x.Password)
                .HasColumnName("password")
                .HasColumnType("varchar(100)")
                .HasMaxLength(100);

            builder.Property(x => x.Sum)
                .HasColumnName("sum")
                .HasColumnType("double precision");

            builder.Property(x => x.CurrencyPreference)
                .HasColumnName("currencyPreferences")
                .HasColumnType("varchar(30)")
                .HasMaxLength(30);
        }
    }
}
