using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace WebApi.Ops;

public class EnvHealthCheck : IEnvHealthCheck
{
    private readonly IConfiguration _configuration;

    // private volatile bool isHealthy = true;

    public bool isHealthy
    {
        get => bool.Parse(_configuration.GetValue<string>("Healthy") ?? "true");
        // set => this.isHealthy = value;
    }

    public EnvHealthCheck(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    public Task<HealthCheckResult> CheckHealthAsync(
        HealthCheckContext context, CancellationToken cancellationToken = default)
    {
        var data = new Dictionary<string, object>();

        data.Add("Healthy", _configuration.GetValue<string>("Healthy") ?? "true");

        if (this.isHealthy)
        {
            return Task.FromResult(HealthCheckResult.Healthy("Storage is healthy.", data: data));
        }
        else
        {
            return Task.FromResult(HealthCheckResult.Unhealthy("Storage is unhealthy.", data: data));
        }
    }
}
