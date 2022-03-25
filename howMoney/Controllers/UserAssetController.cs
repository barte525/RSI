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
    public class UserAssetController : ControllerBase
    {
        private readonly ILogger<UserAssetController> _logger;
        private readonly IRepository<UserAsset> _userAssetRepository;

        public UserAssetController(ILogger<UserAssetController> logger, IRepository<UserAsset> userAssetRepository)
        {
            _logger = logger;
            _userAssetRepository = userAssetRepository;
        }

        [HttpGet]
        public IEnumerable<UserAsset> Get() => _userAssetRepository.GetAll();

        [HttpGet("{userId, assetId}")]
        public UserAsset Get(Guid userId, Guid assetId) => _userAssetRepository.GetById(userId, assetId);

        [HttpPost]
        public async Task<Object> Post([FromBody] UserAsset userAsset)
        {
            try
            {
                await _userAssetRepository.Create(userAsset);
                return true;
            }
            catch (Exception ex)
            {

                return ex;
            }
        }

        [HttpDelete("{userId, assetId}")]
        public bool DeleteAsset(Guid userId, Guid assetId)
        {
            try
            {
                _userAssetRepository.Delete(userId, assetId);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        [HttpPut("{userId, assetId}")]
        public bool Put([FromBody] UserAsset userAsset)
        {
            try
            {
                _userAssetRepository.Update(userAsset);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}

