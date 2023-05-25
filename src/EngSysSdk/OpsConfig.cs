namespace WebApi.Ops;

public class OpsConfig
{
    const string OPS_CONFIG_KEY = "Ops";
    const string REVISION_ENV_VAR = "REVISION";
    const string SERVICENAME_ENV_VAR = "SERVICENAME";
    const string SERVICEVERSION_ENV_VAR = "VERSION";
    const string SERVICENAMESPACE_ENV_VAR = "SERVICENAMESPACE";
    const byte REVHASH_LENGTH = 7;

    private static OpsConfig _current = new();
    public static OpsConfig Current => _current;

    public static void Load(ConfigurationManager config)
    {
        _current = config.GetSection(OPS_CONFIG_KEY).Get<OpsConfig>();

        var revision = config[REVISION_ENV_VAR];
        if (!string.IsNullOrWhiteSpace(revision))
        {
            _current.RevisionHash = revision.PadLeft(REVHASH_LENGTH).Substring(0, REVHASH_LENGTH);
        }

        var serviceName = config[SERVICENAME_ENV_VAR];
        if (!string.IsNullOrWhiteSpace(serviceName))
        {
            _current.ServiceName = serviceName;
        }

        var serviceNamespace = config[SERVICENAMESPACE_ENV_VAR];
        if (!string.IsNullOrWhiteSpace(serviceNamespace))
        {
            _current.ServiceNamespace = serviceNamespace;
        }

        var serviceVersion = config[SERVICEVERSION_ENV_VAR];
        if (!string.IsNullOrWhiteSpace(serviceVersion))
        {
            _current.ServiceVersion = serviceVersion;
        }

    }

    public string RevisionHash { get; internal set; } = "*NOREV*";

    public string ServiceNamespace { get; internal set; } = "Contoso";

    public string ServiceName { get; internal set; } = "WebApi";

    public string ServiceVersion { get; internal set; } = "0.0.0";

    public string ServiceInstanceId { get; } = Guid.NewGuid().ToString();

    public HealthConfig Health { get; set; } = new HealthConfig();

    public LoggingConfig Logging { get; set; } = new LoggingConfig();
}
