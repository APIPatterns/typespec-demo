using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Mvc;
using WebApi.Models;

namespace WebApi.Functions
{ 
    public partial class GadgetsApiController
    { 

        private IActionResult _GadgetsInterfaceGetGadgets([FromQuery][Required()]string apiVersion)
        {
            var manufactorer = new Manufacturer
            {
                Name = "Acme Corporation",
            };
            // Generate a list of gadgets to return as a response to the request
            var gadgets = new List<Gadget>
            {
                new Gadget { Manufacturer = manufactorer, Id = Guid.NewGuid().ToString() },
                new Gadget { Manufacturer = manufactorer, Id = Guid.NewGuid().ToString() },
                new Gadget { Manufacturer = manufactorer, Id = Guid.NewGuid().ToString() },
                new Gadget { Manufacturer = manufactorer, Id = Guid.NewGuid().ToString() },
                new Gadget { Manufacturer = manufactorer, Id = Guid.NewGuid().ToString() }
            };

            return new OkObjectResult(new { value = gadgets });
        }
    }
}


