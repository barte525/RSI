using Microsoft.EntityFrameworkCore.Migrations;

namespace howMoney.Migrations
{
    public partial class Refactorattributestocapitalized : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "surname",
                table: "User",
                newName: "Surname");

            migrationBuilder.RenameColumn(
                name: "sum",
                table: "User",
                newName: "Sum");

            migrationBuilder.RenameColumn(
                name: "password",
                table: "User",
                newName: "Password");

            migrationBuilder.RenameColumn(
                name: "name",
                table: "User",
                newName: "Name");

            migrationBuilder.RenameColumn(
                name: "email",
                table: "User",
                newName: "Email");

            migrationBuilder.RenameColumn(
                name: "currencyPreferences",
                table: "User",
                newName: "CurrencyPreferences");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "User",
                newName: "Id");

            migrationBuilder.RenameIndex(
                name: "IX_User_id",
                table: "User",
                newName: "IX_User_Id");

            migrationBuilder.RenameIndex(
                name: "IX_User_email",
                table: "User",
                newName: "IX_User_Email");

            migrationBuilder.RenameColumn(
                name: "type",
                table: "Asset",
                newName: "Type");

            migrationBuilder.RenameColumn(
                name: "name",
                table: "Asset",
                newName: "Name");

            migrationBuilder.RenameColumn(
                name: "converterUSD",
                table: "Asset",
                newName: "ConverterUSD");

            migrationBuilder.RenameColumn(
                name: "converterPLN",
                table: "Asset",
                newName: "ConverterPLN");

            migrationBuilder.RenameColumn(
                name: "converterEUR",
                table: "Asset",
                newName: "ConverterEUR");

            migrationBuilder.RenameColumn(
                name: "id",
                table: "Asset",
                newName: "Id");

            migrationBuilder.RenameIndex(
                name: "IX_Asset_id",
                table: "Asset",
                newName: "IX_Asset_Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Surname",
                table: "User",
                newName: "surname");

            migrationBuilder.RenameColumn(
                name: "Sum",
                table: "User",
                newName: "sum");

            migrationBuilder.RenameColumn(
                name: "Password",
                table: "User",
                newName: "password");

            migrationBuilder.RenameColumn(
                name: "Name",
                table: "User",
                newName: "name");

            migrationBuilder.RenameColumn(
                name: "Email",
                table: "User",
                newName: "email");

            migrationBuilder.RenameColumn(
                name: "CurrencyPreferences",
                table: "User",
                newName: "currencyPreferences");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "User",
                newName: "id");

            migrationBuilder.RenameIndex(
                name: "IX_User_Id",
                table: "User",
                newName: "IX_User_id");

            migrationBuilder.RenameIndex(
                name: "IX_User_Email",
                table: "User",
                newName: "IX_User_email");

            migrationBuilder.RenameColumn(
                name: "Type",
                table: "Asset",
                newName: "type");

            migrationBuilder.RenameColumn(
                name: "Name",
                table: "Asset",
                newName: "name");

            migrationBuilder.RenameColumn(
                name: "ConverterUSD",
                table: "Asset",
                newName: "converterUSD");

            migrationBuilder.RenameColumn(
                name: "ConverterPLN",
                table: "Asset",
                newName: "converterPLN");

            migrationBuilder.RenameColumn(
                name: "ConverterEUR",
                table: "Asset",
                newName: "converterEUR");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Asset",
                newName: "id");

            migrationBuilder.RenameIndex(
                name: "IX_Asset_Id",
                table: "Asset",
                newName: "IX_Asset_id");
        }
    }
}
