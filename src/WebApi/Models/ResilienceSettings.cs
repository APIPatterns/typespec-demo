namespace WebApi.Models
{
    public class ResilienceSettings
    {
        public Guid id { get; set; }
        public string? apiName { get; set; }
        public int delayPercentage { get; set; }
        public int delaySeconds { get; set; }
        public int faultPercentage { get; set; }
        public int faultResponseCode { get; set; }
        public bool healthy { get; set; }

    }
}
