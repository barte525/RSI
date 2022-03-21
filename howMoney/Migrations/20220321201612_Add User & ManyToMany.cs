using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace howMoney.Migrations
{
    public partial class AddUserManyToMany : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameIndex(
                name: "id",
                table: "asset",
                newName: "IX_asset_id");

            migrationBuilder.CreateTable(
                name: "user",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false, defaultValueSql: "uuid_generate_v4()"),
                    email = table.Column<string>(type: "varchar(50)", maxLength: 50, nullable: false),
                    name = table.Column<string>(type: "varchar(30)", maxLength: 30, nullable: false),
                    password = table.Column<string>(type: "varchar(100)", maxLength: 100, nullable: false),
                    sum = table.Column<double>(type: "double precision", nullable: false),
                    currencyPreferences = table.Column<string>(type: "varchar(30)", maxLength: 30, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_user", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "UserAssets",
                columns: table => new
                {
                    UserId = table.Column<Guid>(type: "uuid", nullable: false),
                    AssetId = table.Column<Guid>(type: "uuid", nullable: false),
                    Amount = table.Column<double>(type: "double precision", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserAssets", x => new { x.UserId, x.AssetId });
                    table.ForeignKey(
                        name: "FK_UserAssets_asset_AssetId",
                        column: x => x.AssetId,
                        principalTable: "asset",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UserAssets_user_UserId",
                        column: x => x.UserId,
                        principalTable: "user",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_user_email",
                table: "user",
                column: "email",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_user_id",
                table: "user",
                column: "id",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_UserAssets_AssetId",
                table: "UserAssets",
                column: "AssetId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "UserAssets");

            migrationBuilder.DropTable(
                name: "user");

            migrationBuilder.RenameIndex(
                name: "IX_asset_id",
                table: "asset",
                newName: "id");
        }
    }
}
