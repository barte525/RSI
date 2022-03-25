using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace howMoney.Models
{
    public interface IRepository<T>
    {
        public Task<T> Create(T _object);

        public void Update(T _object);

        public IEnumerable<T> GetAll();

        public T GetById(Guid Id, Guid? Id2 = null);

        public void Delete(Guid id, Guid? Id2 = null);
    }
}
