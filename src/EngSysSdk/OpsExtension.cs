using Microsoft.ApplicationInsights.Extensibility;
using Microsoft.Extensions.Logging.ApplicationInsights;

namespace WebApi.Ops;
public static class OpsExtension
{
    public static WebApplicationBuilder AddOps(this WebApplicationBuilder builder, string[] args)
    {
        OpsConfig.Load(builder.Configuration);

        builder.AddInsights()
               .AddHealth()
               .AddLogging();

        return builder;
    }

    public static WebApplication ConfigOps(this WebApplication app)
    {
        app.ConfigHealth();
        return app;
    }

}
