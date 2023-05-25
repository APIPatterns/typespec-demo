namespace WebApi.Ops;

public class HealthConfig
{
    public bool Enabled { get; set; } = false;

    public string ReadyPath { get; set; } = "/health/ready";

    public string LivePath { get; set; } = "/health/live";
}

