/*
 * Widget Service
 *
 * No description provided (generated by Openapi Generator https://github.com/openapitools/openapi-generator)
 *
 * The version of the OpenAPI document: 1.0.0
 * 
 * Generated by: https://openapi-generator.tech
 */

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using System.Text.Json;
using WebApi.Models;
using System.Net;
using System.Reflection;

namespace WebApi.Functions
{ 
    /// <summary>
    /// 
    /// </summary>
    [ApiController]
    public partial class WidgetsApiController : ControllerBase
    { 
        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <response code="200">The request has succeeded.</response>
        /// <response code="0">An unexpected error response.</response>
        [HttpPost]
        [Route("widgets/{id}/analyze")]
        public IActionResult WidgetsInterfaceAnalyze(string id)
        {
            var method = this.GetType().GetMethod("_WidgetsInterfaceAnalyze", BindingFlags.NonPublic | BindingFlags.Instance);
            if(method == null)
            {
                return new StatusCodeResult((int)HttpStatusCode.NotImplemented);
            }
            return (ActionResult)method.Invoke(this, new object[] { id });
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <param name="apiVersion">The version of the API in the form YYYY-MM-DD</param>
        /// <param name="widgetCreateOrUpdate"></param>
        /// <response code="200">The request has succeeded.</response>
        /// <response code="0">An unexpected error response.</response>
        [HttpPut]
        [Route("widgets/{id}")]
        [Consumes("application/json")]
        public IActionResult WidgetsInterfaceCreate(string id, [FromQuery(Name = "api-version")][Required()]string apiVersion, [FromBody]WidgetCreateOrUpdate widgetCreateOrUpdate)
        {
            var method = this.GetType().GetMethod("_WidgetsInterfaceCreate", BindingFlags.NonPublic | BindingFlags.Instance);
            if(method == null)
            {
                return new StatusCodeResult((int)HttpStatusCode.NotImplemented);
            }
            return (ActionResult)method.Invoke(this, new object[] { id, apiVersion, widgetCreateOrUpdate });
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <param name="apiVersion">The version of the API in the form YYYY-MM-DD</param>
        /// <response code="204">There is no content to send for this request, but the headers may be useful. </response>
        /// <response code="0">An unexpected error response.</response>
        [HttpDelete]
        [Route("widgets/{id}")]
        public IActionResult WidgetsInterfaceDelete(string id, [FromQuery(Name = "api-version")][Required()]string apiVersion)
        {
            var method = this.GetType().GetMethod("_WidgetsInterfaceDelete", BindingFlags.NonPublic | BindingFlags.Instance);
            if(method == null)
            {
                return new StatusCodeResult((int)HttpStatusCode.NotImplemented);
            }
            return (ActionResult)method.Invoke(this, new object[] { id, apiVersion });
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="apiVersion">The version of the API in the form YYYY-MM-DD</param>
        /// <response code="200">The request has succeeded.</response>
        /// <response code="0">An unexpected error response.</response>
        [HttpGet]
        [Route("widgets")]
        public IActionResult WidgetsInterfaceList([FromQuery(Name = "api-version")][Required()]string apiVersion)
        {
            var method = this.GetType().GetMethod("_WidgetsInterfaceList", BindingFlags.NonPublic | BindingFlags.Instance);
            if(method == null)
            {
                return new StatusCodeResult((int)HttpStatusCode.NotImplemented);
            }
            return (ActionResult)method.Invoke(this, new object[] { apiVersion });
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <param name="apiVersion">The version of the API in the form YYYY-MM-DD</param>
        /// <response code="200">The request has succeeded.</response>
        /// <response code="0">An unexpected error response.</response>
        [HttpGet]
        [Route("widgets/{id}")]
        public IActionResult WidgetsInterfaceRead(string id, [FromQuery(Name = "api-version")][Required()]string apiVersion)
        {
            var method = this.GetType().GetMethod("_WidgetsInterfaceRead", BindingFlags.NonPublic | BindingFlags.Instance);
            if(method == null)
            {
                return new StatusCodeResult((int)HttpStatusCode.NotImplemented);
            }
            return (ActionResult)method.Invoke(this, new object[] { id, apiVersion });
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <param name="apiVersion">The version of the API in the form YYYY-MM-DD</param>
        /// <param name="widgetsInterfaceUpdateRequest"></param>
        /// <response code="200">The request has succeeded.</response>
        /// <response code="0">An unexpected error response.</response>
        [HttpPatch]
        [Route("widgets/{id}")]
        [Consumes("application/merge-patch+json")]
        public IActionResult WidgetsInterfaceUpdate(string id, [FromQuery(Name = "api-version")][Required()]string apiVersion, [FromBody]WidgetsInterfaceUpdateRequest widgetsInterfaceUpdateRequest)
        {
            var method = this.GetType().GetMethod("_WidgetsInterfaceUpdate", BindingFlags.NonPublic | BindingFlags.Instance);
            if(method == null)
            {
                return new StatusCodeResult((int)HttpStatusCode.NotImplemented);
            }
            return (ActionResult)method.Invoke(this, new object[] { id, apiVersion, widgetsInterfaceUpdateRequest });
        }
    }
}