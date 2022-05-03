using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using howMoney.Data;

namespace howMoney.Models
{
    public class UserAssetRepository : IRepository<UserAsset>
    {
        private readonly AppDbContext _context;

        public UserAssetRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<UserAsset> Create(UserAsset _object)
        {
            var obj = await _context.UserAssets.AddAsync(_object);
            _context.SaveChanges();
            return obj.Entity;
        }

        public void Delete(Guid UserId, Guid? AssetId)
        {
            var obj = _context.UserAssets.Where(a => a.UserId == UserId && a.AssetId == AssetId).FirstOrDefault();
            _context.Remove(obj);
            _context.SaveChanges();
        }

        public IEnumerable<UserAsset> GetAll(Guid? Id)
        {
            return _context.UserAssets.Where(a => a.UserId == Id).ToList();
        }

        public UserAsset GetById(Guid UserId, Guid? AssetId)
        {
            return _context.UserAssets.Where(a => a.UserId == UserId && a.AssetId == AssetId).FirstOrDefault();
        }

        public UserAsset GetByEmail(string email)
        {
            return null;
        }

        public void Update(UserAsset _object)
        {
            _context.UserAssets.Update(_object);
            _context.SaveChanges();
        }
    }
}
