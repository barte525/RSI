using Microsoft.EntityFrameworkCore.Migrations;

namespace howMoney.Migrations
{
    public partial class AddSurnameforuser : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "surname",
                table: "user",
                type: "varchar(30)",
                maxLength: 30,
                nullable: false,
                defaultValue: "");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "surname",
                table: "user");
        }
    }
}
