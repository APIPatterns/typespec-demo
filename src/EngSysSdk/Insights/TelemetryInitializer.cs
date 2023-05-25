using Microsoft.ApplicationInsights.Channel;
using Microsoft.ApplicationInsights.Extensibility;

namespace WebApi.Ops;

public class TelemetryInitializer : ITelemetryInitializer
{
    private readonly IHttpContextAccessor _httpContextAccessor;

    public TelemetryInitializer(IHttpContextAccessor httpContextAccessor)
    {
        _httpContextAccessor = httpContextAccessor;
    }

    public void Initialize(ITelemetry telemetry)
    {
        telemetry.Context.Cloud.RoleName = OpsConfig.Current.ServiceName;
        telemetry.Context.Cloud.RoleInstance = OpsConfig.Current.ServiceInstanceId;
        telemetry.Context.GlobalProperties["service.revhash"] = OpsConfig.Current.RevisionHash;
        telemetry.Context.GlobalProperties["service.namespace"] = OpsConfig.Current.ServiceNamespace;
        telemetry.Context.GlobalProperties["service.name"] = OpsConfig.Current.ServiceName;
        telemetry.Context.GlobalProperties["service.version"] = OpsConfig.Current.ServiceVersion;
        telemetry.Context.GlobalProperties["service.instanceid"] = OpsConfig.Current.ServiceInstanceId;
    }
}