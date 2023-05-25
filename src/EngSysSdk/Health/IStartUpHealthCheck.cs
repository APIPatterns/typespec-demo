using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace WebApi.Ops;

public interface IStartupHealthCheck : IHealthCheck
{
    bool StartupCompleted { get; set; }
    bool StartupHealthy { get; set; }
}
