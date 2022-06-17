using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using howMoney.Models;
using howMoney.Data;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;


namespace howMoney.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [EnableCors("frontend_cors")]
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

        [HttpGet, Authorize]
        public IEnumerable<Object> Get()
        {
            User currentUser = _userRepository.GetByEmail(User.FindFirstValue(ClaimTypes.Email));
            IEnumerable<UserAsset> userAssets = _userAssetRepository.GetAll(currentUser.Id);
            IEnumerable<Asset> assets = _assetRepository.GetAll();
            var allUserAssets = GetUsersAssetHelper(userAssets, assets, currentUser);
            return allUserAssets;
        }

        [HttpGet("{assetId}"), Authorize]
        public Object Get(Guid assetId)
        {
            User currentUser = _userRepository.GetByEmail(User.FindFirstValue(ClaimTypes.Email));
            List<UserAsset> userAssets = new List<UserAsset>();
            UserAsset userAsset = _userAssetRepository.GetById(currentUser.Id, assetId);
            if (userAsset == null)
            {
                return BadRequest("No such userAsset");
            }
            userAssets.Add(userAsset);
            List<Asset> assets = new List<Asset>();
            assets.Add(_assetRepository.GetById(assetId));

            var allUserAssets = GetUsersAssetHelper(userAssets, assets, currentUser);
            Object result = null;
            foreach (var asset in allUserAssets)
                result = asset;
            return result;
        }

        private IEnumerable<Object> GetUsersAssetHelper(IEnumerable<UserAsset> userAssets, IEnumerable<Asset> assets, User currentUser)
        {
            string chosenCurrencyName = "Converter" + currentUser.CurrencyPreference;
            var allUserAssets = from u in userAssets
                                join a in assets
                                on u.AssetId equals a.Id
                                select new
                                {
                                    AssetId = u.AssetId,
                                    Amount = u.Amount,
                                    Name = a.Name,
                                    CurrencyPreferenceAmount = (double)a.GetType().GetProperty(chosenCurrencyName).GetValue(a, null) * u.Amount
                                };
            return allUserAssets;

        }

        [HttpGet("sum"), Authorize]
        public double? GetSum()
        {
            Guid userId = _userRepository.GetByEmail(User.FindFirstValue(ClaimTypes.Email)).Id;
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
            }
            catch
            {
                HttpContext.Response.StatusCode = 400;
                return null;
            }

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
                    HttpContext.Response.StatusCode = 400;
                    return ex;
                }
            }
            HttpContext.Response.StatusCode = 401;
            return null;
        }

        [HttpDelete("{assetId}"), Authorize]
        public bool DeleteAsset(Guid assetId)
        {
            try
            {   
                _userAssetRepository.Delete(_userRepository.GetByEmail(User.FindFirstValue(ClaimTypes.Email)).Id, assetId);
                return true;
            }
            catch (Exception)
            {
                HttpContext.Response.StatusCode = 400;
                return false;
            }
        }


        [HttpPut, Authorize]
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
                    HttpContext.Response.StatusCode = 400;
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

