using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace howMoney.Migrations
{
    public partial class seeddata : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Asset",
                columns: new[] { "Id", "ConverterEUR", "ConverterPLN", "ConverterUSD", "Name", "Type" },
                values: new object[,]
                {
                    { new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa9"), 100000.25, 500000.25, 110000.25, "BTC", "crypto" },
                    { new Guid("4fa85f64-5717-4562-b3fc-2c963f66afa9"), 10.0, 50.0, 11.0, "ETH", "crypto" },
                    { new Guid("5fa85f64-5717-4562-b3fc-2c963f66afa9"), 120.0, 600.0, 130.0, "GOLD", "metal" },
                    { new Guid("6fa85f64-5717-4562-b3fc-2c963f66afa9"), 9.0, 45.0, 10.0, "SILVER", "metal" },
                    { new Guid("7fa85f64-5717-4562-b3fc-2c963f66afa9"), 0.22, 1.0, 0.20000000000000001, "PLN", "currency" },
                    { new Guid("8fa85f64-5717-4562-b3fc-2c963f66afa9"), 0.90000000000000002, 4.2000000000000002, 1.0, "USD", "currency" },
                    { new Guid("9fa85f64-5717-4562-b3fc-2c963f66afa9"), 1.0, 4.9000000000000004, 1.1200000000000001, "EUR", "currency" },
                    { new Guid("2fa85f64-5717-4562-b3fc-2c963f66afa9"), 0.90000000000000002, 0.14999999999999999, 0.80000000000000004, "GBP", "currency" }
                });

            migrationBuilder.InsertData(
                table: "User",
                columns: new[] { "Id", "CurrencyPreferences", "Email", "Name", "PasswordHash", "PasswordSalt", "Sum", "Surname" },
                values: new object[,]
                {
                    { new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"), "EUR", "bartek@gmail.com", "Bartek", "UbN/VoI/974MZ9iTx0gV+TVUbZHK745jzU51suahhOIXFA/OKK2+/Nwfeno/SbJGjAkyZAZnG7nOW5GV99aR+A==", "9eII7vkhEcnJwaFRAkv6Wvq1h0uIol+pMwgNQkE5ooLL9eBK+vf8GinvN0LVxfy8dOkem2Z76yl/DtcGd94vZGQ8lJFAy1z+Xt9jWP/amZQbhU3t1SnUrwQGtTd5LZ0bCQcKqtMBbWoGOb7lnJiJLZ+oXtK9SgMMgFJICgWiAZo=", 0.0, "Nowak" },
                    { new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa7"), "USD", "ola@gmail.com", "Ola", "UbN/VoI/974MZ9iTx0gV+TVUbZHK745jzU51suahhOIXFA/OKK2+/Nwfeno/SbJGjAkyZAZnG7nOW5GV99aR+A==", "9eII7vkhEcnJwaFRAkv6Wvq1h0uIol+pMwgNQkE5ooLL9eBK+vf8GinvN0LVxfy8dOkem2Z76yl/DtcGd94vZGQ8lJFAy1z+Xt9jWP/amZQbhU3t1SnUrwQGtTd5LZ0bCQcKqtMBbWoGOb7lnJiJLZ+oXtK9SgMMgFJICgWiAZo=", 0.0, "Generowicz" },
                    { new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa8"), "PLN", "martyna@gmail.com", "Martyna", "UbN/VoI/974MZ9iTx0gV+TVUbZHK745jzU51suahhOIXFA/OKK2+/Nwfeno/SbJGjAkyZAZnG7nOW5GV99aR+A==", "9eII7vkhEcnJwaFRAkv6Wvq1h0uIol+pMwgNQkE5ooLL9eBK+vf8GinvN0LVxfy8dOkem2Z76yl/DtcGd94vZGQ8lJFAy1z+Xt9jWP/amZQbhU3t1SnUrwQGtTd5LZ0bCQcKqtMBbWoGOb7lnJiJLZ+oXtK9SgMMgFJICgWiAZo=", 0.0, "Grzegorczyk" }
                });

            migrationBuilder.InsertData(
                table: "UserAssets",
                columns: new[] { "AssetId", "UserId", "Amount" },
                values: new object[,]
                {
                    { new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"), 0.00020000000000000001 },
                    { new Guid("4fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"), 100.0 },
                    { new Guid("5fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"), 11.0 },
                    { new Guid("6fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"), 10040.219999999999 },
                    { new Guid("7fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"), 500.0 },
                    { new Guid("8fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"), 1100.5 },
                    { new Guid("9fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"), 0.02 },
                    { new Guid("2fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"), 100.11 },
                    { new Guid("7fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa8"), 0.02 },
                    { new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa8"), 100.0 }
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "User",
                keyColumn: "Id",
                keyValue: new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa7"));

            migrationBuilder.DeleteData(
                table: "UserAssets",
                keyColumns: new[] { "AssetId", "UserId" },
                keyValues: new object[] { new Guid("2fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6") });

            migrationBuilder.DeleteData(
                table: "UserAssets",
                keyColumns: new[] { "AssetId", "UserId" },
                keyValues: new object[] { new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6") });

            migrationBuilder.DeleteData(
                table: "UserAssets",
                keyColumns: new[] { "AssetId", "UserId" },
                keyValues: new object[] { new Guid("4fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6") });

            migrationBuilder.DeleteData(
                table: "UserAssets",
                keyColumns: new[] { "AssetId", "UserId" },
                keyValues: new object[] { new Guid("5fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6") });

            migrationBuilder.DeleteData(
                table: "UserAssets",
                keyColumns: new[] { "AssetId", "UserId" },
                keyValues: new object[] { new Guid("6fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6") });

            migrationBuilder.DeleteData(
                table: "UserAssets",
                keyColumns: new[] { "AssetId", "UserId" },
                keyValues: new object[] { new Guid("7fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6") });

            migrationBuilder.DeleteData(
                table: "UserAssets",
                keyColumns: new[] { "AssetId", "UserId" },
                keyValues: new object[] { new Guid("8fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6") });

            migrationBuilder.DeleteData(
                table: "UserAssets",
                keyColumns: new[] { "AssetId", "UserId" },
                keyValues: new object[] { new Guid("9fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6") });

            migrationBuilder.DeleteData(
                table: "UserAssets",
                keyColumns: new[] { "AssetId", "UserId" },
                keyValues: new object[] { new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa8") });

            migrationBuilder.DeleteData(
                table: "UserAssets",
                keyColumns: new[] { "AssetId", "UserId" },
                keyValues: new object[] { new Guid("7fa85f64-5717-4562-b3fc-2c963f66afa9"), new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa8") });

            migrationBuilder.DeleteData(
                table: "Asset",
                keyColumn: "Id",
                keyValue: new Guid("2fa85f64-5717-4562-b3fc-2c963f66afa9"));

            migrationBuilder.DeleteData(
                table: "Asset",
                keyColumn: "Id",
                keyValue: new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa9"));

            migrationBuilder.DeleteData(
                table: "Asset",
                keyColumn: "Id",
                keyValue: new Guid("4fa85f64-5717-4562-b3fc-2c963f66afa9"));

            migrationBuilder.DeleteData(
                table: "Asset",
                keyColumn: "Id",
                keyValue: new Guid("5fa85f64-5717-4562-b3fc-2c963f66afa9"));

            migrationBuilder.DeleteData(
                table: "Asset",
                keyColumn: "Id",
                keyValue: new Guid("6fa85f64-5717-4562-b3fc-2c963f66afa9"));

            migrationBuilder.DeleteData(
                table: "Asset",
                keyColumn: "Id",
                keyValue: new Guid("7fa85f64-5717-4562-b3fc-2c963f66afa9"));

            migrationBuilder.DeleteData(
                table: "Asset",
                keyColumn: "Id",
                keyValue: new Guid("8fa85f64-5717-4562-b3fc-2c963f66afa9"));

            migrationBuilder.DeleteData(
                table: "Asset",
                keyColumn: "Id",
                keyValue: new Guid("9fa85f64-5717-4562-b3fc-2c963f66afa9"));

            migrationBuilder.DeleteData(
                table: "User",
                keyColumn: "Id",
                keyValue: new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa6"));

            migrationBuilder.DeleteData(
                table: "User",
                keyColumn: "Id",
                keyValue: new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa8"));
        }
    }
}
