using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using howMoney.Data;

namespace howMoney.Models
{
    public class AssetRepository : IRepository<Asset>
    {
        private readonly AppDbContext _context;

        public AssetRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<Asset> Create(Asset _object)
        {
            var obj = await _context.Assets.AddAsync(_object);
            _context.SaveChanges();
            return obj.Entity;
        }

        public void Delete(Guid id, Guid? Id2 = null)
        {
            var obj = _context.Assets.Where(a => a.Id == id).FirstOrDefault();
            _context.Remove(obj);
            _context.SaveChanges();
        }

        public IEnumerable<Asset> GetAll()
        {
            return _context.Assets.ToList();
        }

        public Asset GetById(Guid Id, Guid? Id2 = null)
        {
            return _context.Assets.Where(a => a.Id == Id).FirstOrDefault();
        }

        public Asset GetByEmail(string email)
        {
            return null;
        }

        public void Update(Asset _object)
        {
            _context.Assets.Update(_object);
            _context.SaveChanges();
        }
    }
}
