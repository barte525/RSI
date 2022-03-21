using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using howMoney.Data;

namespace howMoney.Models
{
    public class UserRepository : IRepository<User>
    {
        private readonly AppDbContext _context;

        public UserRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<User> Create(User _object)
        {
            var obj = await _context.Users.AddAsync(_object);
            _context.SaveChanges();
            return obj.Entity;
        }

        public void Delete(Guid id)
        {
            var obj = _context.Users.Where(a => a.Id == id).FirstOrDefault();
            _context.Remove(obj);
            _context.SaveChanges();
        }

        public IEnumerable<User> GetAll()
        {
            return _context.Users.ToList();
        }

        public User GetById(Guid Id)
        {
            return _context.Users.Where(a => a.Id == Id).FirstOrDefault();
        }

        public void Update(User _object)
        {
            _context.Users.Update(_object);
            _context.SaveChanges();
        }
    }
}
