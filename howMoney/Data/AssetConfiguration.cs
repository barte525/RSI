using System;
using howMoney.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace howMoney.Data
{
    internal class AssetConfiguration : IEntityTypeConfiguration<Asset>
    {
        private const string TableName = "Asset";
        public void Configure(EntityTypeBuilder<Asset> builder)
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

            builder.Property(x => x.Type)
                .HasColumnName("Type")
                .HasColumnType("varchar(30)")
                .HasMaxLength(30);

            builder.Property(x => x.Name)
                .HasColumnName("Name")
                .HasColumnType("varchar(30)")
                .HasMaxLength(30);

            builder.Property(x => x.ConverterPLN)
                .HasColumnName("ConverterPLN")
                .HasColumnType("double precision");

            builder.Property(x => x.ConverterEUR)
                .HasColumnName("ConverterEUR")
                .HasColumnType("double precision");

            builder.Property(x => x.ConverterUSD)
                .HasColumnName("ConverterUSD")
                .HasColumnType("double precision");
        }
    }
}
