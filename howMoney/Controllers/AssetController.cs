using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using howMoney.Models;
using howMoney.Data;

namespace howMoney.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AssetController : ControllerBase
    {
        private AppDbContext _context;
        private readonly ILogger<AssetController> _logger;
        private readonly IRepository<Asset> _assetRepository;

        public AssetController(ILogger<AssetController> logger, AppDbContext context, IRepository<Asset> assetRepository)
        {
            _logger = logger;
            _context = context;
            _assetRepository = assetRepository;
        }

        [HttpGet]
        public IEnumerable<Asset> Get() => _assetRepository.GetAll();

        [HttpGet("{id}")]
        public Asset Get(Guid id) => _assetRepository.GetById(id);

        [HttpPost]
        public async Task<Object> Post([FromBody] Asset asset)
        {
            try
            {
                await _assetRepository.Create(asset);
                return true;
            }
            catch (Exception)
            {

                return false;
            }
        }

        [HttpDelete("{id}")]
        public bool DeletePerson(Guid id)
        {
            try
            {
                _assetRepository.Delete(id);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

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
                return false;
            }
        }
    }
}
