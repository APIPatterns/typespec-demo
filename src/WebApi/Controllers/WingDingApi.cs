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
    public partial class WingDingApiController : ControllerBase
    { 
        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <param name="apiVersion">The version of the API in the form YYYY-MM-DD</param>
        /// <response code="204">There is no content to send for this request, but the headers may be useful. </response>
        /// <response code="0">An unexpected error response.</response>
        [HttpDelete]
        [Route("wingdings/{id}")]
        public IActionResult WingDingInterfaceDeleteWingDing(string id, [FromQuery][Required()]string apiVersion)
        {
            var method = this.GetType().GetMethod("_WingDingInterfaceDeleteWingDing", BindingFlags.NonPublic | BindingFlags.Instance);
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
        /// <response code="200">The request has succeeded.</response>
        /// <response code="0">An unexpected error response.</response>
        [HttpGet]
        [Route("wingdings/{id}")]
        public IActionResult WingDingInterfaceGetWingDing(string id, [FromQuery][Required()]string apiVersion)
        {
            var method = this.GetType().GetMethod("_WingDingInterfaceGetWingDing", BindingFlags.NonPublic | BindingFlags.Instance);
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
        [Route("wingdings")]
        public IActionResult WingDingInterfaceGetWingDings([FromQuery][Required()]string apiVersion)
        {
            var method = this.GetType().GetMethod("_WingDingInterfaceGetWingDings", BindingFlags.NonPublic | BindingFlags.Instance);
            if(method == null)
            {
                return new StatusCodeResult((int)HttpStatusCode.NotImplemented);
            }
            return (ActionResult)method.Invoke(this, new object[] { apiVersion });
        }
    }
}