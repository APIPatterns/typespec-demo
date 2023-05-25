using System.Text.Json;
using Microsoft.Extensions.FileProviders;
using WebApi.Ops;
using WebApi.Services;


namespace WebApi
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            var apiName = builder.Configuration.GetValue<string>("ApiName");
            builder.AddOps(args);
            builder.Services.AddHttpClient();
            builder.Services.AddHttpContextAccessor();

            builder.Services.AddSingleton<IEnvHealthCheck, EnvHealthCheck>();
            builder.Services.AddHealthChecks().AddCheck<IEnvHealthCheck>(
                "EnvHealthy",
                tags: new[] { HealthTag.Live }
            );

            // Add services to the container.
            builder.Services.AddHostedService<StartupBackgroundService>();

            builder.Services.AddControllers()
                                .AddJsonOptions(option => option.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase);

            builder.Services.AddEndpointsApiExplorer();

            var app = builder.Build();

            app.UseStaticFiles(new StaticFileOptions
            {
                FileProvider = new PhysicalFileProvider(
                    Path.Combine(builder.Environment.ContentRootPath, "spec")),
                RequestPath = "/spec"
            });

            app.ConfigOps();

            app.UseAuthorization();

            app.MapControllers();

            app.UseSwaggerUI(options =>
            {
                options.SwaggerEndpoint("/spec/openapi.json", "v1");
                options.RoutePrefix = string.Empty;
            });

            app.Run();
        }
    }
}