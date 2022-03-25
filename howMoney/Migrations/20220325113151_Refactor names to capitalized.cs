using Microsoft.EntityFrameworkCore.Migrations;

namespace howMoney.Migrations
{
    public partial class Refactornamestocapitalized : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_UserAssets_asset_AssetId",
                table: "UserAssets");

            migrationBuilder.DropForeignKey(
                name: "FK_UserAssets_user_UserId",
                table: "UserAssets");

            migrationBuilder.DropPrimaryKey(
                name: "PK_user",
                table: "user");

            migrationBuilder.DropPrimaryKey(
                name: "PK_asset",
                table: "asset");

            migrationBuilder.RenameTable(
                name: "user",
                newName: "User");

            migrationBuilder.RenameTable(
                name: "asset",
                newName: "Asset");

            migrationBuilder.RenameIndex(
                name: "IX_user_id",
                table: "User",
                newName: "IX_User_id");

            migrationBuilder.RenameIndex(
                name: "IX_user_email",
                table: "User",
                newName: "IX_User_email");

            migrationBuilder.RenameIndex(
                name: "IX_asset_id",
                table: "Asset",
                newName: "IX_Asset_id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_User",
                table: "User",
                column: "id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Asset",
                table: "Asset",
                column: "id");

            migrationBuilder.AddForeignKey(
                name: "FK_UserAssets_Asset_AssetId",
                table: "UserAssets",
                column: "AssetId",
                principalTable: "Asset",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserAssets_User_UserId",
                table: "UserAssets",
                column: "UserId",
                principalTable: "User",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_UserAssets_Asset_AssetId",
                table: "UserAssets");

            migrationBuilder.DropForeignKey(
                name: "FK_UserAssets_User_UserId",
                table: "UserAssets");

            migrationBuilder.DropPrimaryKey(
                name: "PK_User",
                table: "User");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Asset",
                table: "Asset");

            migrationBuilder.RenameTable(
                name: "User",
                newName: "user");

            migrationBuilder.RenameTable(
                name: "Asset",
                newName: "asset");

            migrationBuilder.RenameIndex(
                name: "IX_User_id",
                table: "user",
                newName: "IX_user_id");

            migrationBuilder.RenameIndex(
                name: "IX_User_email",
                table: "user",
                newName: "IX_user_email");

            migrationBuilder.RenameIndex(
                name: "IX_Asset_id",
                table: "asset",
                newName: "IX_asset_id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_user",
                table: "user",
                column: "id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_asset",
                table: "asset",
                column: "id");

            migrationBuilder.AddForeignKey(
                name: "FK_UserAssets_asset_AssetId",
                table: "UserAssets",
                column: "AssetId",
                principalTable: "asset",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserAssets_user_UserId",
                table: "UserAssets",
                column: "UserId",
                principalTable: "user",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
