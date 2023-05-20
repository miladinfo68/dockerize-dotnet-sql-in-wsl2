using ApiImage.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

var connStr = builder.Configuration.GetConnectionString("DefaultDB");

builder.Services.AddDbContext<MyDbContext>(options => options.UseSqlServer(connStr));

var app = builder.Build();

await app.EnsureDbCreatedWithSeedData();

app.MapGet("/", () => "health check is ok");

app.MapGet("/list", async (MyDbContext ctx) =>
{
    return await ctx.Users.ToArrayAsync();
});


app.Run();
