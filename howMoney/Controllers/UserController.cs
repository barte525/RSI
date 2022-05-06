using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using howMoney.Models;
using howMoney.Data;
using Microsoft.AspNetCore.JsonPatch;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;
using Microsoft.AspNetCore.Cors;

namespace howMoney.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [EnableCors("frontend_cors")]
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

        [HttpPut("{id}"), Authorize]
        public bool Put([FromBody] User user)
        {
            string loggedUsersEmail = User.FindFirstValue(ClaimTypes.Email);
            if (loggedUsersEmail.Equals(user.Email))
            {
                ;
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
            HttpContext.Response.StatusCode = 401;
            return false;
        }

        [HttpPatch("{id:Guid}")]
        public bool PatchUser(Guid id, [FromBody] JsonPatchDocument<User> patchUser)
        {
            if (patchUser != null)
            {
                var userToUpdate = _userRepository.GetById(id);
                if (userToUpdate == null || !ModelState.IsValid)
                {
                    return false;
                }

                patchUser.ApplyTo(userToUpdate, ModelState);
                _userRepository.Update(userToUpdate);

                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
