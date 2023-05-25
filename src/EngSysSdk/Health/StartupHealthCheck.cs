using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace WebApi.Ops;

public class StartupHealthCheck : IStartupHealthCheck
{
    private volatile bool _isReady = false;
    private volatile bool _isHealthy = true;
    private readonly ILogger logger;

    public bool StartupCompleted
    {
        get => _isReady;
        set => _isReady = value;
    }

    public bool StartupHealthy
    {
        get => _isHealthy;
        set => _isHealthy = value;
    }

    public StartupHealthCheck(ILogger<StartupHealthCheck> logger)
    {
        this.logger = logger;
    }

    public Task<HealthCheckResult> CheckHealthAsync(
        HealthCheckContext context, CancellationToken cancellationToken = default)
    {
        if (context.Registration.Tags.Contains(HealthTag.Ready))
        {
            if (StartupCompleted)
            {
                return Task.FromResult(HealthCheckResult.Healthy("The startup task has completed."));
            }

            return Task.FromResult(HealthCheckResult.Unhealthy("The startup task is still running."));
        }

        if (context.Registration.Tags.Contains(HealthTag.Live))
        {
            if (StartupHealthy)
            {
                return Task.FromResult(HealthCheckResult.Healthy("The startup task is healthy."));
            }

            return Task.FromResult(HealthCheckResult.Unhealthy("The startup task failed."));
        }

        this.logger.LogWarning($"HealthCheck tags unrecognized. Expected '{HealthTag.Live}' or '{HealthTag.Ready}'.");
        return Task.FromResult(HealthCheckResult.Degraded($"HealthCheck tags unrecognized. Expected '{HealthTag.Live}' or '{HealthTag.Ready}'."));
    }
}
