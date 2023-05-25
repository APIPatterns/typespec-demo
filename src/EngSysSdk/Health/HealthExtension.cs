using System.Text;
using System.Text.Json;
using Microsoft.AspNetCore.Diagnostics.HealthChecks;
using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace WebApi.Ops;

public static class HealthExtension
{
    public static WebApplicationBuilder AddHealth(this WebApplicationBuilder builder)
    {
        if (OpsConfig.Current.Health.Enabled)
        {
            builder.Services.AddSingleton<IStartupHealthCheck, StartupHealthCheck>();

            builder.Services.AddHealthChecks()
                .AddCheck<IStartupHealthCheck>(
                        "StartupReady",
                        tags: new[] { HealthTag.Ready })
                .AddCheck<IStartupHealthCheck>(
                        "StartupHealthy",
                        tags: new[] { HealthTag.Live });
        } 

        return builder;
    }

    public static WebApplication ConfigHealth(this WebApplication app)
    {
        if (OpsConfig.Current.Health.Enabled)
        {
            app.MapHealthChecks(OpsConfig.Current.Health.ReadyPath, new HealthCheckOptions
            {
                Predicate = healthCheck => healthCheck.Tags.Contains(HealthTag.Ready),
                ResponseWriter = WriteResponse
            });

            app.MapHealthChecks(OpsConfig.Current.Health.LivePath, new HealthCheckOptions
            {
                Predicate = healthCheck =>
                {
                    return healthCheck.Tags.Contains(HealthTag.Live);
                },
                ResponseWriter = WriteResponse
            });
        }
        return app;
    }

    private static Task WriteResponse(HttpContext context, HealthReport healthReport)
    {
        context.Response.ContentType = "application/json; charset=utf-8";
        var options = new JsonWriterOptions { Indented = true };

        using var memoryStream = new MemoryStream();
        using (var jsonWriter = new Utf8JsonWriter(memoryStream, options))
        {
            jsonWriter.WriteStartObject();
            jsonWriter.WriteString("status", healthReport.Status.ToString());
            jsonWriter.WriteString("revision", OpsConfig.Current.RevisionHash);
            jsonWriter.WriteStartObject("results");

            foreach (var healthReportEntry in healthReport.Entries)
            {
                jsonWriter.WriteStartObject(healthReportEntry.Key);
                jsonWriter.WriteString("status",
                    healthReportEntry.Value.Status.ToString());
                jsonWriter.WriteString("description",
                    healthReportEntry.Value.Description);
                jsonWriter.WriteStartObject("data");

                foreach (var item in healthReportEntry.Value.Data)
                {
                    jsonWriter.WritePropertyName(item.Key);

                    JsonSerializer.Serialize(jsonWriter, item.Value,
                        item.Value?.GetType() ?? typeof(object));
                }

                jsonWriter.WriteEndObject();
                jsonWriter.WriteEndObject();
            }

            jsonWriter.WriteEndObject();
            jsonWriter.WriteEndObject();
        }

        return context.Response.WriteAsync(
            Encoding.UTF8.GetString(memoryStream.ToArray()));
    }
}
