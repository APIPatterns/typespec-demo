using WebApi.Ops;

namespace WebApi.Services;

public class StartupBackgroundService : BackgroundService
{
    private readonly IStartupHealthCheck healthCheck;
    private readonly ILogger<StartupBackgroundService> logger;

    public StartupBackgroundService(ILogger<StartupBackgroundService> logger, IStartupHealthCheck healthCheck)
    {
        this.healthCheck = healthCheck;
        this.logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        try
        {
            //perform startup tasks


            // Simulate the effect of a long-running task.
            await Task.Delay(TimeSpan.FromSeconds(5), stoppingToken);

            this.logger.LogInformation("Startup Task Completed");
            this.healthCheck.StartupCompleted = true;
        }
        catch (Exception e)
        {
            // if startup fails, mark unhealthy
            this.logger.LogError(e, "Startup Task Failed");
            this.healthCheck.StartupHealthy = false;
        }
    }
}
