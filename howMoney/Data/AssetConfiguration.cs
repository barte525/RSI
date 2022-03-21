using System;
using howMoney.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace howMoney.Data
{
    internal class AssetConfiguration : IEntityTypeConfiguration<Asset>
    {
        private const string TableName = "asset";
        public void Configure(EntityTypeBuilder<Asset> builder)
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

            builder.Property(x => x.Type)
                .HasColumnName("type")
                .HasColumnType("varchar(30)")
                .HasMaxLength(30);

            builder.Property(x => x.Name)
                .HasColumnName("name")
                .HasColumnType("varchar(30)")
                .HasMaxLength(30);

            builder.Property(x => x.ConverterPLN)
                .HasColumnName("converterPLN")
                .HasColumnType("double precision");

            builder.Property(x => x.ConverterEUR)
                .HasColumnName("converterEUR")
                .HasColumnType("double precision");

            builder.Property(x => x.ConverterUSD)
                .HasColumnName("converterUSD")
                .HasColumnType("double precision");
        }
    }
}
