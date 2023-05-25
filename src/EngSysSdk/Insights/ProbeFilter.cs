using Microsoft.ApplicationInsights.Channel;
using Microsoft.ApplicationInsights.Extensibility;

namespace WebApi.Ops;

public class ProbeFilter : ITelemetryProcessor
{
    private ITelemetryProcessor Next { get; set; }

    // next will point to the next TelemetryProcessor in the chain.
    public ProbeFilter(ITelemetryProcessor next)
    {
        this.Next = next;
    }

    public void Process(ITelemetry item)
    {
        // To filter out an item, return without calling the next processor.
        if (item.Context.Operation.Name != null &&
            (item.Context.Operation.Name.StartsWith($"GET {OpsConfig.Current.Health.ReadyPath}") ||
                item.Context.Operation.Name.StartsWith($"GET {OpsConfig.Current.Health.LivePath}"))
           ) { return; }

        this.Next.Process(item);
    }

}