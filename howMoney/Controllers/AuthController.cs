﻿using Microsoft.AspNetCore.Mvc;
using howMoney.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using Microsoft.Extensions.Configuration;
using howMoney.Services;
using System.Collections.Generic;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace howMoney.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly IRepository<User> _userRepository;
        private readonly IUserService _userService;

        public AuthController(IConfiguration configuration, IUserService userService, IRepository<User> userRepository)
        {
            _configuration = configuration;
            _userService = userService;
            _userRepository = userRepository;
        }

        [HttpGet, Authorize]
        public ActionResult<string> GetMe()
        {
            var email = _userService.GetMyEmail();
            return Ok(email);

            //var userName = User?.Identity?.Name;
            //var userName2 = User.FindFirstValue(ClaimTypes.Name);
            //var role = User.FindFirstValue(ClaimTypes.Role);
            //return Ok(new { userName, userName2, role });
        }


        [HttpPost("register")]
        public async Task<Object> Register(UserRegisterDto request)
        {
            CreatePasswordHash(request.Password, out string passwordHash, out string passwordSalt);

            User user = new User
            {
                Email = request.Email,
                Name = request.Name,
                Surname = request.Surname,
                CurrencyPreference = request.CurrencyPreference,
                Sum = 0,
                PasswordHash = passwordHash,
                PasswordSalt = passwordSalt
            };

            try
            {
                await _userRepository.Create(user);
                return Ok(user);
            }
            catch (Exception ex)
            {
                return ex;
            }
        }

    //    [HttpPost("login")]
  /*      public async Task<ActionResult<string>> Login(UserLoginDto request)
        {

            if (user.Email != request.Email)
            {
                return BadRequest("User not found.");
            }

            if (!VerifyPasswordHash(request.Password, user.PasswordHash, user.PasswordSalt))
            {
                return BadRequest("Wrong password.");
            }

            string token = CreateToken(user);
            return Ok(token);
        }*/

        private string CreateToken(User user)
        {
            List<Claim> claims = new List<Claim>
            {
                new Claim(ClaimTypes.Email, user.Email),
                new Claim(ClaimTypes.Role, "Admin")
            };

            var key = new SymmetricSecurityKey(System.Text.Encoding.UTF8.GetBytes(
                _configuration.GetSection("AppSettings:Token").Value));

            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha512Signature);

            var token = new JwtSecurityToken(
                claims: claims,
                expires: DateTime.Now.AddDays(1),
                signingCredentials: creds);

            var jwt = new JwtSecurityTokenHandler().WriteToken(token);

            return jwt;
        }

        private void CreatePasswordHash(string password, out string passwordHash, out string passwordSalt)
        {
            using (var hmac = new HMACSHA512())
            {
                passwordSalt = Convert.ToBase64String(hmac.Key);
                passwordHash = Convert.ToBase64String(hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password)));
                Console.WriteLine(passwordSalt);
                Console.WriteLine(passwordHash);
            }
        }

    /*    private bool VerifyPasswordHash(string password, string passwordHash, string passwordSalt)
        {
            using (var hmac = new HMACSHA512(passwordSalt))
            {
                var computedHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                return computedHash.SequenceEqual(passwordHash);
            }
        }*/
    }
}