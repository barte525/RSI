using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using howMoney.Models;
using howMoney.Data;
using Microsoft.AspNetCore.Cors;

namespace howMoney.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [EnableCors("frontend_cors")]
    public class AssetController : ControllerBase
    {
        private readonly ILogger<AssetController> _logger;
        private readonly IRepository<Asset> _assetRepository;

        public AssetController(ILogger<AssetController> logger, IRepository<Asset> assetRepository)
        {
            _logger = logger;
            _assetRepository = assetRepository;
        }

        [HttpGet]
        public IEnumerable<Asset> Get() => _assetRepository.GetAll();

        [HttpGet("{id}")]
        public Asset Get(Guid id) => _assetRepository.GetById(id);

        //dev
        [HttpPost]
        public async Task<Object> Post([FromBody] Asset asset)
        {
            try
            {
                await _assetRepository.Create(asset);
                return true;
            }
            catch (Exception ex)
            {
                HttpContext.Response.StatusCode = 400;
                return ex;
            }
        }

        //dev
        [HttpDelete("{id}")]
        public bool DeleteAsset(Guid id)
        {
            try
            {
                _assetRepository.Delete(id);
                return true;
            }
            catch (Exception)
            {
                HttpContext.Response.StatusCode = 400;
                return false;
            }
        }

        //dev
        [HttpPut("{id}")]
        public bool Put([FromBody] Asset asset)
        {
            try
            {
                _assetRepository.Update(asset);
                return true;
            }
            catch (Exception)
            {
                HttpContext.Response.StatusCode = 400;
                return false;
            }
        }
    }
}
