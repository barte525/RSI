using howMoney.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace howMoney.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [EnableCors("frontend_cors")]
    public class AlertController : ControllerBase
    {
        private static readonly HttpClient client = new();
        private const string apiUrl = "http://127.0.0.1:8000/api/alert/";

        [HttpGet, Authorize]
        public async Task<Object> Get()
        {
            var email = User.FindFirstValue(ClaimTypes.Email);
            var respone = await client.GetStringAsync(apiUrl + "?email=" + email);
            var model = JsonConvert.DeserializeObject<List<AlertWithIdDto>>(respone);
            return model;
        }

        [HttpPost, Authorize]
        public async Task<Object> Post(AlertDto alert)
        {
            var email = User.FindFirstValue(ClaimTypes.Email);
            AlertWithEmailDto alertWithEmail = new AlertWithEmailDto
            {
                email = email,
                currency = alert.currency,
                value = alert.value,
                asset_name = alert.asset_name,
            };
            var json = JsonConvert.SerializeObject(alertWithEmail);
            var content = new StringContent(json.ToString(), Encoding.UTF8, "application/json");
            var response = await client.PostAsync(apiUrl, content);
            int statusCode = (int)response.StatusCode;
            HttpContext.Response.StatusCode = statusCode;
            if (statusCode == 200)
                return true;
            return false;
        }

        [HttpDelete("{id}"), Authorize]
        public async Task<Object> Delete(int id)
        {
            var email = User.FindFirstValue(ClaimTypes.Email);
            var response = await client.DeleteAsync(apiUrl + "?id=" + id + "&email=" + email);
            int statusCode = (int)response.StatusCode;
            HttpContext.Response.StatusCode = statusCode;
            if (statusCode == 200)
                return true;
            return false;
        }
    }
}
