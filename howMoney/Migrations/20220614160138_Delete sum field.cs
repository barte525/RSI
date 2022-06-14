using Microsoft.EntityFrameworkCore.Migrations;

namespace howMoney.Migrations
{
    public partial class Deletesumfield : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Sum",
                table: "User");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<double>(
                name: "Sum",
                table: "User",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0);
        }
    }
}
