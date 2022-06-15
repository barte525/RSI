using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace howMoney.Migrations
{
    public partial class deletetype : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Type",
                table: "Asset");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Type",
                table: "Asset",
                type: "varchar(30)",
                maxLength: 30,
                nullable: false,
                defaultValue: "");

            migrationBuilder.UpdateData(
                table: "Asset",
                keyColumn: "Id",
                keyValue: new Guid("2fa85f64-5717-4562-b3fc-2c963f66afa9"),
                column: "Type",
                value: "currency");

            migrationBuilder.UpdateData(
                table: "Asset",
                keyColumn: "Id",
                keyValue: new Guid("3fa85f64-5717-4562-b3fc-2c963f66afa9"),
                column: "Type",
                value: "crypto");

            migrationBuilder.UpdateData(
                table: "Asset",
                keyColumn: "Id",
                keyValue: new Guid("4fa85f64-5717-4562-b3fc-2c963f66afa9"),
                column: "Type",
                value: "crypto");

            migrationBuilder.UpdateData(
                table: "Asset",
                keyColumn: "Id",
                keyValue: new Guid("5fa85f64-5717-4562-b3fc-2c963f66afa9"),
                column: "Type",
                value: "metal");

            migrationBuilder.UpdateData(
                table: "Asset",
                keyColumn: "Id",
                keyValue: new Guid("6fa85f64-5717-4562-b3fc-2c963f66afa9"),
                column: "Type",
                value: "metal");

            migrationBuilder.UpdateData(
                table: "Asset",
                keyColumn: "Id",
                keyValue: new Guid("7fa85f64-5717-4562-b3fc-2c963f66afa9"),
                column: "Type",
                value: "currency");

            migrationBuilder.UpdateData(
                table: "Asset",
                keyColumn: "Id",
                keyValue: new Guid("8fa85f64-5717-4562-b3fc-2c963f66afa9"),
                column: "Type",
                value: "currency");

            migrationBuilder.UpdateData(
                table: "Asset",
                keyColumn: "Id",
                keyValue: new Guid("9fa85f64-5717-4562-b3fc-2c963f66afa9"),
                column: "Type",
                value: "currency");
        }
    }
}
