using Microsoft.EntityFrameworkCore.Migrations;

namespace howMoney.Migrations
{
    public partial class tulus : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_UserAssets_Asset_AssetId",
                table: "UserAssets");

            migrationBuilder.DropForeignKey(
                name: "FK_UserAssets_User_UserId",
                table: "UserAssets");

            migrationBuilder.DropIndex(
                name: "IX_UserAssets_AssetId",
                table: "UserAssets");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_UserAssets_AssetId",
                table: "UserAssets",
                column: "AssetId");

            migrationBuilder.AddForeignKey(
                name: "FK_UserAssets_Asset_AssetId",
                table: "UserAssets",
                column: "AssetId",
                principalTable: "Asset",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserAssets_User_UserId",
                table: "UserAssets",
                column: "UserId",
                principalTable: "User",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
