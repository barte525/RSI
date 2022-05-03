using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace howMoney.Models
{
    public interface IRepository<T>
    {
        public Task<T> Create(T _object);

        public void Update(T _object);

        public IEnumerable<T> GetAll(Guid? Id = null);

        public T GetById(Guid Id, Guid? Id2 = null);

        public T GetByEmail(string emial);

        public void Delete(Guid id, Guid? Id2 = null);
    }
}
