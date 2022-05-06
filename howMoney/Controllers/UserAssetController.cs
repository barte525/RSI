using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using howMoney.Models;
using howMoney.Data;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;


namespace howMoney.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserAssetController : ControllerBase
    {
        private readonly ILogger<UserAssetController> _logger;
        private readonly IRepository<UserAsset> _userAssetRepository;
        private readonly IRepository<User> _userRepository;
        private readonly IRepository<Asset> _assetRepository;

        public UserAssetController(ILogger<UserAssetController> logger, IRepository<UserAsset> userAssetRepository, IRepository<User> userRepository, IRepository<Asset> assetRepository)
        {
            _logger = logger;
            _userAssetRepository = userAssetRepository;
            _userRepository = userRepository;
            _assetRepository = assetRepository;
        }

        [HttpGet("userId"), Authorize]
        public IEnumerable<UserAsset> Get(Guid userId)
        {
            if (Authenticate_user(User.FindFirstValue(ClaimTypes.Email), userId))
                return _userAssetRepository.GetAll(userId);
            HttpContext.Response.StatusCode = 401;
            return null;
        }

        [HttpGet("{userId, assetId}"), Authorize]
        public UserAsset Get(Guid userId, Guid assetId)
        {
            if (Authenticate_user(User.FindFirstValue(ClaimTypes.Email), userId))
                _userAssetRepository.GetById(userId, assetId);
            HttpContext.Response.StatusCode = 401;
            return null;
        }

        [HttpGet("sum/{userId}"), Authorize]
        public double? GetSum(Guid userId)
        {
            if (Authenticate_user(User.FindFirstValue(ClaimTypes.Email), userId))
            {
                try
                {
                    double sum = 0;
                    double converter;
                    User user = _userRepository.GetById(userId);
                    string chosenCurrencyName = "Converter" + user.CurrencyPreference;

                    IEnumerable<UserAsset> userAssets = _userAssetRepository.GetAll(userId);
                    IEnumerable<Asset> assets = _assetRepository.GetAll();

                    var allUserAssets = from u in userAssets
                                        join a in assets
                                        on u.AssetId equals a.Id
                                        select new
                                        {
                                            Amount = u.Amount,
                                            ConverterPLN = a.ConverterPLN,
                                            ConverterUSD = a.ConverterUSD,
                                            ConverterEUR = a.ConverterEUR
                                        };

                    foreach (var asset in allUserAssets)
                    {
                        var value = asset.GetType().GetProperty(chosenCurrencyName).GetValue(asset, null);
                        converter = (double)value;
                        sum += asset.Amount * converter;
                    }
                    return sum;
                } catch
                {
                    HttpContext.Response.StatusCode = 400;
                    return null;
                }
            }

            HttpContext.Response.StatusCode = 401;
            return null;
        }

        [HttpPost, Authorize]
        public async Task<Object> Post([FromBody] UserAsset userAsset)
        {
            if (Authenticate_user(User.FindFirstValue(ClaimTypes.Email), userAsset.UserId))
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
            HttpContext.Response.StatusCode = 401;
            return null;
        }

        [HttpDelete("{userId, assetId}"), Authorize]
        public bool DeleteAsset(Guid userId, Guid assetId)
        {
            if (Authenticate_user(User.FindFirstValue(ClaimTypes.Email), userId))
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
            HttpContext.Response.StatusCode = 401;
            return false;
        }

        [HttpPut("{userId, assetId}"), Authorize]
        public bool Put([FromBody] UserAsset userAsset)
        {
            if (Authenticate_user(User.FindFirstValue(ClaimTypes.Email), userAsset.UserId))
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
            HttpContext.Response.StatusCode = 401;
            return false;
        }

        private bool Authenticate_user(string loggedUsersEmail, Guid userId) {
            string usersEmail = _userRepository.GetById(userId).Email;
            return loggedUsersEmail.Equals(usersEmail);
        }
    }
}

