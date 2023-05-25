using Microsoft.ApplicationInsights.Extensibility;
using Serilog;

namespace WebApi.Ops;
public static class InsightsExtension
{
    public static WebApplicationBuilder AddInsights(this WebApplicationBuilder builder)
    {
        builder.Services.AddSingleton<ITelemetryInitializer, TelemetryInitializer>();
        builder.Services.AddApplicationInsightsTelemetry(opts => {
            opts.ApplicationVersion = OpsConfig.Current.ServiceVersion;
        });
        builder.Services.AddApplicationInsightsTelemetryProcessor<ProbeFilter>();
        return builder;
    }
}
