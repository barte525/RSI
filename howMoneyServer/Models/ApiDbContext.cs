using System;
using Microsoft.EntityFrameworkCore;

namespace howMoneyServer.data
{
    public class ApiDbContext: DbContext
    {
        public ApiDbContext(DbContextOptions<ApiDbContext>options)
        {
        }

    }
}
