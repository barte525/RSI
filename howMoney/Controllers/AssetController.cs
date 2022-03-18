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
        private readonly ILogger<AssetController> _logger;
        private AppDbContext _context;

        public AssetController(ILogger<AssetController> logger, AppDbContext context)
        {
            _logger = logger;
            _context = context;
        }

        [HttpGet]
        public IEnumerable<Asset> Get()
        {
            _context.Assets.Add(new Asset() {
                Type = "Currency",
                Name = "EUR",
                ConverterEUR = 1.0,
                ConverterPLN = 4.71,
                ConverterUSD = 1.1
            });
            _context.SaveChanges();
            return _context.Assets.ToList();
        }
    }
}
