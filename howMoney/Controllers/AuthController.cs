using System;
using System.IO;
using Microsoft.AspNetCore.Mvc;
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
using Microsoft.AspNetCore.Cors;
using System.Net.Http;


namespace howMoney.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [EnableCors("frontend_cors")]
    public class AuthController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly IRepository<User> _userRepository;
        private readonly IUserService _userService;
        private static readonly HttpClient client = new();
        private const string apiUrl = "http://127.0.0.1:8000/send_password";
        private const int passwordLength = 10;

        public AuthController(IConfiguration configuration, IUserService userService, IRepository<User> userRepository)
        {
            _configuration = configuration;
            _userService = userService;
            _userRepository = userRepository;
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
                PasswordHash = passwordHash,
                PasswordSalt = passwordSalt
            };

            string token = CreateToken(user);

            try
            {
                await _userRepository.Create(user);
                UserResponse registeredUser = new UserResponse
                {
                    Id = user.Id,
                    Email = user.Email,
                    Name = user.Name,
                    Surname = user.Surname,
                    CurrencyPreference = user.CurrencyPreference,
                    Token = token
                };
                return Ok(registeredUser);
            }
            catch (Exception ex)
            {
                HttpContext.Response.StatusCode = 400;
                return ex;
            }
        }

        [HttpPost("login")]
        public async Task<ActionResult<string>> Login(UserLoginDto request)
        {
            User user = _userRepository.GetByEmail(request.Email);

            if (user == null || !VerifyPasswordHash(request.Password, user.PasswordHash, user.PasswordSalt))
            {
                return BadRequest("Invalid login credentials.");
            }

            string token = CreateToken(user);

            UserResponse loggedUser = new UserResponse
            {
                Id = user.Id,
                Email = user.Email,
                Name = user.Name,
                Surname = user.Surname,
                CurrencyPreference = user.CurrencyPreference,
                Token = token
            };
            return Ok(loggedUser);
        }

        [HttpPost("change"), Authorize]
        public ActionResult<string> Change(PasswordDto request)
        {
            User user = _userRepository.GetByEmail(User.FindFirstValue(ClaimTypes.Email));

            if (!VerifyPasswordHash(request.Password, user.PasswordHash, user.PasswordSalt))
            {
                return BadRequest("Invalid Password");
            }

            CreatePasswordHash(request.NewPassword, out string passwordHash, out string passwordSalt);

            user.PasswordSalt = passwordSalt;
            user.PasswordHash = passwordHash;

            _userRepository.Update(user);

            return Ok();
        }

        [HttpPost("generate/{email}")]
        public async Task<ActionResult<string>> Generate(string email)
        {
            string password = GeneratePassword();
            using (StreamWriter writetext = new StreamWriter("passwords.txt"))
            {
                writetext.WriteLine("email: " + email + " password: " + password);
            }
            User user = _userRepository.GetByEmail(email);
            if (user == null)
            {
                return BadRequest("No user with that email");
            }
            CreatePasswordHash(password, out string passwordHash, out string passwordSalt);
            user.PasswordSalt = passwordSalt;
            user.PasswordHash = passwordHash;
            _userRepository.Update(user);
            await client.GetAsync(apiUrl + "?email=" + email + "&password=" + password);
            return Ok("New password generated and sent to email");
        }

        private string GeneratePassword()
        {
            var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var stringChars = new char[passwordLength];
            var random = new Random();

            for (int i = 0; i < stringChars.Length; i++)
            {
                stringChars[i] = chars[random.Next(chars.Length)];
            }

            var finalString = new String(stringChars);
            return finalString;
        }

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
            }
        }

        private bool VerifyPasswordHash(string password, string passwordHash, string passwordSalt)
        {
            using (var hmac = new HMACSHA512(Convert.FromBase64String(passwordSalt)))
            {
                var computedHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                var hash = System.Text.Encoding.UTF8.GetBytes(passwordHash);
                return computedHash.SequenceEqual(Convert.FromBase64String(passwordHash));
            }
        }
    }
}
