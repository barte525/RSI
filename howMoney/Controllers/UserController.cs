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
    public class UserController : ControllerBase
    {
        private readonly ILogger<UserController> _logger;
        private readonly IRepository<User> _userRepository;

        public UserController(ILogger<UserController> logger, IRepository<User> userRepository)
        {
            _logger = logger;
            _userRepository = userRepository;
        }

        [HttpGet]
        public IEnumerable<User> Get() => _userRepository.GetAll();

        [HttpGet("{id}")]
        public User Get(Guid id) => _userRepository.GetById(id);

        [HttpPost]
        public async Task<Object> Post([FromBody] User user)
        {
            try
            {
                await _userRepository.Create(user);
                return true;
            }
            catch (Exception ex)
            {
                return ex;
            }
        }

        [HttpDelete("{id}")]
        public bool DeleteUser(Guid id)
        {
            try
            {
                _userRepository.Delete(id);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        [HttpPut("{id}")]
        public bool Put([FromBody] User user)
        {
            try
            {
                _userRepository.Update(user);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
