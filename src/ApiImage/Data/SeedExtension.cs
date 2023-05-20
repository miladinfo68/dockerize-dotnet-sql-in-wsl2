namespace ApiImage.Data;

public static class SeedExtension
{
    public static async Task<int> EnsureDbCreatedWithSeedData(this IApplicationBuilder app)
    {
        using var scope = app.ApplicationServices.CreateScope();
        var ctx = scope.ServiceProvider.GetRequiredService<MyDbContext>();
        int affectedRows = 0;
        try
        {
            if (ctx is not null)
            {
                await ctx.Database.EnsureCreatedAsync();
                affectedRows = await ctx.AddSeedData();
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"[xxxx ====>] error message {ex?.Message} - {ex?.InnerException?.Message}"); ;
            var logger = scope.ServiceProvider.GetRequiredService<ILogger<Program>>();
            logger.LogError(ex, "An error occurred while migrating or seeding the database.");
            throw;
        }
        return affectedRows;

    }

    private static async Task<int> AddSeedData(this MyDbContext ctx)
    {
        int affectedRows = 0;
        if (!ctx.Users.Any())
        {
            await ctx.AddRangeAsync(new List<User>(){
                        new User{Name="Mahadi Jalali"},
                        new User{Name="Ali Hassani"},
                        new User{Name="Erfan Omidi"},
                     });
            affectedRows = await ctx.SaveChangesAsync();
        }
        return affectedRows;
    }

}
