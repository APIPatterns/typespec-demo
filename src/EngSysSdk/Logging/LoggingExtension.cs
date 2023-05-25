using Microsoft.ApplicationInsights.Extensibility;
using Serilog;

namespace WebApi.Ops;
public static class LoggingExtension
{
    const string SERILOG_CONFIG = "Ops:Logging";
    public static WebApplicationBuilder AddLogging(this WebApplicationBuilder builder)
    {
        if (OpsConfig.Current.Logging.Enabled)
        {
            builder.Host.UseSerilog((context, services, logger) => {
                logger.ReadFrom.Configuration(builder.Configuration, SERILOG_CONFIG)
                .WriteTo.ApplicationInsights(
                    services.GetRequiredService<TelemetryConfiguration>(),
                    TelemetryConverter.Traces
                )
                .Enrich.WithProperty("RevisionHash", OpsConfig.Current.RevisionHash);
            });
        }
        return builder;
    }
}
